#!/usr/bin/env python3
"""
Unit test for IEA oil scraper - validates that we can download oil final consumption data for Canada.
Expected file:
1. oil_final_consumption.csv - oil final consumption by product (LPG/Ethane, Naphtha, Motor gasoline, Gas/Diesel, Jet kerosene, Other kerosene, Fuel oil, Other oil products)
"""

import time
from pathlib import Path
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.action_chains import ActionChains
import urllib.parse
import sys


def init_driver(headless=True):
    """Initialize Selenium webdriver."""
    options = webdriver.ChromeOptions()
    if headless:
        options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    options.add_argument('--window-size=1920,1080')
    return webdriver.Chrome(options=options)


def extract_csv_from_data_url(data_url):
    """Extract CSV content from a data URL."""
    if not data_url or not data_url.startswith('data:text/csv'):
        return None
    content = data_url.split(',', 1)[1]
    return urllib.parse.unquote(content)


def test_canada_downloads():
    """Test downloading oil final consumption data for Canada."""
    print("Testing IEA oil scraper with Canada data...")
    print("="*70)

    driver = init_driver()
    test_dir = Path('test_output')
    test_dir.mkdir(parents=True, exist_ok=True)

    try:
        url = "https://www.iea.org/countries/canada/oil"
        print(f"\n1. Navigating to: {url}")
        driver.get(url)

        # Wait and scroll
        print("2. Waiting for page to load...")
        time.sleep(5)

        print("3. Scrolling slowly to load all content...")
        # Scroll to specific positions to trigger chart renders
        scroll_positions = [0, 500, 1000, 1500, 2000, 2500, 3000, 4000, 5000]
        for pos in scroll_positions:
            driver.execute_script(f"window.scrollTo(0, {pos});")
            time.sleep(1.5)

        # Scroll to bottom
        driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        time.sleep(4)

        # Scroll back up
        driver.execute_script("window.scrollTo(0, 0);")
        time.sleep(4)

        # Scroll through again to ensure everything is loaded
        print("4. Second pass - ensuring all charts are rendered...")
        for pos in scroll_positions:
            driver.execute_script(f"window.scrollTo(0, {pos});")
            time.sleep(2)
        driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        time.sleep(5)
        driver.execute_script("window.scrollTo(0, 0);")
        time.sleep(5)

        # Try to find and hover over charts to ensure they're interactive
        print("5. Checking for charts and ensuring they're fully loaded...")
        charts = driver.find_elements(By.CSS_SELECTOR, '.chart, [class*="chart"], .highcharts-container')
        print(f"   Found {len(charts)} chart elements")
        time.sleep(3)

        # Find all CSV download links
        print("6. Finding CSV download links...")
        links = driver.find_elements(By.CSS_SELECTOR, 'a[download][href^="data:text/csv"]')
        print(f"   Found {len(links)} total CSV links")

        print("7. Waiting for data URLs to fully populate...")
        time.sleep(5)  # Give data URLs time to populate with full data

        print("8. Trying to trigger data URL population by hovering over download buttons...")
        links_to_hover = driver.find_elements(By.CSS_SELECTOR, 'a[download][href^="data:text/csv"]')
        actions = ActionChains(driver)
        for i, link in enumerate(links_to_hover):
            try:
                download_name = link.get_attribute('download')
                if download_name and 'oil' in download_name.lower():
                    # Scroll to element and hover over it
                    driver.execute_script("arguments[0].scrollIntoView(true);", link)
                    time.sleep(0.5)
                    actions.move_to_element(link).perform()
                    time.sleep(1)
            except:
                pass

        print("9. Re-fetching links to get updated data URLs...")
        links = driver.find_elements(By.CSS_SELECTOR, 'a[download][href^="data:text/csv"]')
        print(f"   Found {len(links)} CSV links after refresh")

        # Collect all data
        files_found = {}
        all_files = []

        for link in links:
            download_attr = link.get_attribute('download')
            data_url = link.get_attribute('href')

            if not download_attr or not data_url:
                continue

            csv_content = extract_csv_from_data_url(data_url)
            if not csv_content:
                continue

            filename_lower = download_attr.lower()
            content_lower = csv_content.lower()
            lines = csv_content.count('\n')
            size = len(csv_content)

            # Debug: print info about oil final consumption files
            if 'oil final consumption' in filename_lower and 'product' in filename_lower:
                print(f"\n   DEBUG: Found target file")
                print(f"     Filename: {download_attr}")
                print(f"     Size: {size} bytes")
                print(f"     Data URL length: {len(data_url)}")
                print(f"     Data URL prefix: {data_url[:100]}")

            # Store info about all files for debugging
            all_files.append({
                'filename': download_attr,
                'size': size,
                'lines': lines,
                'first_line': csv_content.split('\n')[0][:100] if csv_content else ''
            })

            # Classify files by looking at filename and content
            file_type = None

            # Looking for oil final consumption by product
            # Note: looking for files with "product" not "sector"
            # Prefer files WITHOUT year in the name (those have full time series)
            if 'oil final consumption' in filename_lower and 'product' in filename_lower:
                # Skip snapshot files that have a specific year in the name
                has_year = any(year in download_attr for year in ['2000', '2020', '2021', '2022', '2023', '2024'])
                if not has_year:
                    file_type = 'oil_final_consumption'
            # Check content as well
            elif 'oil final consumption by product' in content_lower:
                file_type = 'oil_final_consumption'

            if file_type:
                # Keep the largest version of each file type
                if file_type not in files_found or size > len(files_found[file_type]['content']):
                    files_found[file_type] = {
                        'filename': download_attr,
                        'content': csv_content,
                        'size': size,
                        'lines': lines
                    }

        # Print all files found for debugging
        print("\n  All CSV files found:")
        for f in all_files:
            print(f"    - {f['filename'][:60]:60s} ({f['size']:6,} bytes, {f['lines']:4} lines)")
            print(f"      First line: {f['first_line']}")
        print()

        # Print results
        print("\n9. Results:")
        print("="*70)

        expected_files = ['oil_final_consumption']
        all_passed = True

        for file_type in expected_files:
            if file_type in files_found:
                info = files_found[file_type]
                print(f"   ✓ {file_type:30s} {info['size']:6,} bytes, {info['lines']:4} lines")

                # Save file
                filepath = test_dir / f"canada_{file_type}.csv"
                with open(filepath, 'w', encoding='utf-8') as f:
                    f.write(info['content'])

                # Show first few lines
                first_lines = info['content'].split('\n')[:5]
                for line in first_lines:
                    print(f"      {line[:80]}")

                # If file is too small, print full content for debugging
                if size < 500:
                    print(f"\n      WARNING: File is only {size} bytes (expected ~6,314)")
                    print("      Full content:")
                    for line in info['content'].split('\n')[:20]:
                        print(f"        {line}")
                print()
            else:
                print(f"   ✗ {file_type:30s} NOT FOUND")
                all_passed = False

        print("="*70)
        if all_passed:
            print("✓ TEST PASSED - Oil final consumption data downloaded successfully")
            print(f"Files saved to: {test_dir}")

            # Compare with reference file
            print("\nComparing with reference file...")
            ref_file = Path('../International Energy Agency - oil final consumption by product in Canada.csv')
            if ref_file.exists():
                with open(ref_file, 'r', encoding='utf-8') as f:
                    ref_content = f.read()
                if ref_content.strip() == info['content'].strip():
                    print("✓ Content matches reference file exactly!")
                else:
                    print("⚠ Content differs from reference file (this may be expected if IEA updated data)")
                    print(f"  Reference file size: {len(ref_content):,} bytes")
                    print(f"  Downloaded file size: {len(info['content']):,} bytes")

            return 0
        else:
            print("✗ TEST FAILED - Oil final consumption data not found")
            return 1

    finally:
        driver.quit()


if __name__ == '__main__':
    sys.exit(test_canada_downloads())
