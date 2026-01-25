#!/usr/bin/env python3
"""
Final production IEA scraper for OECD countries.
Downloads oil data: oil final consumption by product.
"""

import time
import os
from pathlib import Path
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.support.ui import WebDriverWait
from selenium.common.exceptions import InvalidSessionIdException, TimeoutException
import urllib.parse
import csv
from datetime import datetime

# List of OECD countries (from cars_on_the_road.csv)
OECD_COUNTRIES = [
    "australia",
    "austria",
    "belgium",
    "brazil",
    "canada",
    "denmark",
    "finland",
    "germany",
    "greece",
    "iceland",
    "ireland",
    "italy",
    "japan",
    "korea",
    "latvia",
    "luxembourg",
    "netherlands",
    "new-zealand",
    "norway",
    "portugal",
    "slovenia",
    "spain",
    "sweden",
    "switzerland",
    "turkiye",
    "united-kingdom",
    "united-states",
]


def init_driver():
    """Initialize Selenium webdriver with appropriate options."""
    options = webdriver.ChromeOptions()
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    options.add_argument('--disable-gpu')
    options.add_argument('--window-size=1920,1080')
    driver = webdriver.Chrome(options=options)
    return driver


def extract_csv_from_data_url(data_url):
    """Extract CSV content from a data URL."""
    if not data_url or not data_url.startswith('data:text/csv'):
        return None

    # Extract the URL-encoded content
    content = data_url.split(',', 1)[1]
    # URL decode
    decoded = urllib.parse.unquote(content)
    return decoded


def wait_for_page_idle(driver, timeout=10):
    """Wait for page to be idle."""
    script = """
    return (window.performance.timing.loadEventEnd > 0) &&
           (document.readyState === 'complete');
    """

    try:
        wait = WebDriverWait(driver, timeout)
        wait.until(lambda d: d.execute_script(script))
    except TimeoutException:
        pass  # Continue anyway


def classify_file(filename, content):
    """
    Classify file type and return standardized name.

    Returns: (file_type, standardized_name) or (None, None) if should skip
    """
    filename_lower = filename.lower()
    content_lower = content.lower() if content else ''

    # Skip regional comparison files (North America, etc.)
    if 'north america' in filename_lower or 'regional' in filename_lower:
        return None, None

    # Skip per capita files
    if 'per capita' in filename_lower:
        return None, None

    # Looking for oil final consumption by product (NOT by sector)
    # Skip snapshot files that have a specific year in the title
    if 'oil final consumption' in filename_lower and 'product' in filename_lower:
        has_year = any(year in filename for year in ['2000', '2020', '2021', '2022', '2023', '2024'])
        if not has_year:
            return 'oil_final_consumption', 'oil_final_consumption.csv'

    # Check content as well
    if 'oil final consumption by product' in content_lower and len(content) > 1000:
        return 'oil_final_consumption', 'oil_final_consumption.csv'

    return None, None


def download_country_data(driver, country, output_dir):
    """
    Download oil final consumption data for a given country.

    Args:
        driver: Selenium webdriver instance
        country: Country name (URL slug format)
        output_dir: Directory to save downloaded files
    """
    url = f"https://www.iea.org/countries/{country}/oil"

    try:
        print(f"  Navigating to {url}")
        driver.get(url)

        # Wait for page to be ready
        wait_for_page_idle(driver)
        time.sleep(3)  # Initial load

        # Scroll slowly to trigger all chart renders
        scroll_positions = [0, 500, 1000, 1500, 2000, 2500, 3000, 4000, 5000]
        for pos in scroll_positions:
            driver.execute_script(f"window.scrollTo(0, {pos});")
            time.sleep(1.3)  # 1.3 seconds as specified

        # Scroll to bottom
        driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        time.sleep(3)  # 3 seconds between pages as specified

        # Scroll back up
        driver.execute_script("window.scrollTo(0, 0);")
        time.sleep(3)

        # Second pass to ensure all charts are rendered
        for pos in scroll_positions:
            driver.execute_script(f"window.scrollTo(0, {pos});")
            time.sleep(1.3)
        driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        time.sleep(3)
        driver.execute_script("window.scrollTo(0, 0);")
        time.sleep(3)

        # Find all CSV download links
        links = driver.find_elements(By.CSS_SELECTOR, 'a[download][href^="data:text/csv"]')

        if not links:
            print(f"  Warning: No CSV download links found for {country}")
            return False

        print(f"  Found {len(links)} CSV links")

        # Hover over download links to trigger data URL population
        print(f"  Triggering data URL population...")
        actions = ActionChains(driver)
        for link in links:
            try:
                download_name = link.get_attribute('download')
                if download_name and 'oil' in download_name.lower():
                    driver.execute_script("arguments[0].scrollIntoView(true);", link)
                    time.sleep(0.5)
                    actions.move_to_element(link).perform()
                    time.sleep(1)
            except:
                pass

        # Re-fetch links to get updated data URLs
        time.sleep(2)
        links = driver.find_elements(By.CSS_SELECTOR, 'a[download][href^="data:text/csv"]')
        print(f"  Processing {len(links)} CSV links...")

        # Collect all files
        files_to_save = {}

        for link in links:
            download_attr = link.get_attribute('download')
            data_url = link.get_attribute('href')

            if not download_attr or not data_url:
                continue

            # Extract CSV content
            csv_content = extract_csv_from_data_url(data_url)
            if not csv_content:
                continue

            # Classify the file
            file_type, standard_name = classify_file(download_attr, csv_content)

            if not file_type:
                continue  # Skip this file

            # Keep the largest version of each file type
            if file_type not in files_to_save or len(csv_content) > len(files_to_save[file_type]['content']):
                files_to_save[file_type] = {
                    'name': standard_name,
                    'content': csv_content,
                    'original_name': download_attr
                }

        # Save files
        if not files_to_save:
            print(f"  Warning: No valid data files found for {country}")
            return False

        country_dir = output_dir / country
        country_dir.mkdir(parents=True, exist_ok=True)

        for file_type, file_info in files_to_save.items():
            filepath = country_dir / file_info['name']

            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(file_info['content'])

            lines = file_info['content'].count('\n')
            print(f"    ✓ {file_info['name']} ({len(file_info['content']):,} bytes, {lines} lines)")

        return True

    except InvalidSessionIdException:
        print(f"  Session error for {country} - needs driver refresh")
        raise
    except Exception as e:
        print(f"  Error downloading {country}: {str(e)}")
        return False


def main():
    """Main function to scrape all OECD countries."""
    # Create output directory
    output_dir = Path('iea_oil_scraped')
    output_dir.mkdir(parents=True, exist_ok=True)

    # Log file
    log_file = output_dir / 'scraping_log.txt'
    progress_file = output_dir / 'progress.txt'

    driver = None
    successful = []
    failed = []
    start_time = datetime.now()

    # Check for existing progress
    start_idx = 0
    if progress_file.exists():
        with open(progress_file, 'r') as f:
            completed = [line.strip() for line in f.readlines()]
            start_idx = len(completed)
            successful = completed
            print(f"Resuming from country {start_idx + 1}/{len(OECD_COUNTRIES)}")

    try:
        for i in range(start_idx, len(OECD_COUNTRIES)):
            country = OECD_COUNTRIES[i]

            # Refresh driver every 5 countries to avoid session errors
            if i % 5 == 0:
                if driver:
                    driver.quit()
                print(f"\n{'='*70}")
                print(f"Initializing new driver (country {i+1}/{len(OECD_COUNTRIES)})")
                elapsed = (datetime.now() - start_time).total_seconds() / 60
                print(f"Elapsed time: {elapsed:.1f} minutes")
                print(f"{'='*70}")
                driver = init_driver()

            print(f"\n[{i+1}/{len(OECD_COUNTRIES)}] Processing {country}...")

            try:
                success = download_country_data(driver, country, output_dir)
                if success:
                    successful.append(country)
                    # Save progress
                    with open(progress_file, 'a') as f:
                        f.write(f"{country}\n")
                else:
                    failed.append(country)
            except InvalidSessionIdException:
                # Refresh driver and retry
                print(f"  Refreshing driver and retrying {country}...")
                driver.quit()
                driver = init_driver()
                try:
                    success = download_country_data(driver, country, output_dir)
                    if success:
                        successful.append(country)
                        with open(progress_file, 'a') as f:
                            f.write(f"{country}\n")
                    else:
                        failed.append(country)
                except Exception as e:
                    print(f"  Retry failed for {country}: {str(e)}")
                    failed.append(country)
            except Exception as e:
                print(f"  Unexpected error for {country}: {str(e)}")
                failed.append(country)

    finally:
        if driver:
            driver.quit()

    # Write final log
    end_time = datetime.now()
    duration = (end_time - start_time).total_seconds() / 60

    with open(log_file, 'w') as f:
        f.write(f"Scraping completed at {end_time}\n")
        f.write(f"Duration: {duration:.1f} minutes\n\n")
        f.write(f"Successful: {len(successful)}/{len(OECD_COUNTRIES)}\n")
        f.write(f"Failed: {len(failed)}/{len(OECD_COUNTRIES)}\n\n")

        f.write(f"Successful countries:\n")
        for country in successful:
            country_dir = output_dir / country
            if country_dir.exists():
                files = list(country_dir.glob('*.csv'))
                f.write(f"  ✓ {country} ({len(files)} files)\n")

        f.write(f"\nFailed countries:\n")
        for country in failed:
            f.write(f"  ✗ {country}\n")

    print(f"\n{'='*70}")
    print(f"Scraping completed!")
    print(f"{'='*70}")
    print(f"Duration: {duration:.1f} minutes")
    print(f"Successful: {len(successful)}/{len(OECD_COUNTRIES)}")
    print(f"Failed: {len(failed)}/{len(OECD_COUNTRIES)}")
    print(f"Log saved to: {log_file}")
    print(f"{'='*70}")


if __name__ == '__main__':
    main()
