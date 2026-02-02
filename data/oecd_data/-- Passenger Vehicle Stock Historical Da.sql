-- Passenger Vehicle Stock Historical Data - INSERT Statements
-- Source: ACEA, KBA, ABS/BITRE, Statistics Austria, Statbel, Statistics Denmark, 
--         Statistics Finland, ELSTAT, Statistics Iceland, OICA, national agencies
-- Measure: VEH_STOCK_CONSUMER_OWNED (Passenger Car Stock)
-- Coverage: 2010-2023 for first 10 OECD countries

-- AUSTRALIA (AUS) - Source: ABS Motor Vehicle Census / BITRE - 
-- there is a difference between db and this by~.5M vehicles look closer
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2010, 'VEH_STOCK_CONSUMER_OWNED', 12165000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2011, 'VEH_STOCK_CONSUMER_OWNED', 12428000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2012, 'VEH_STOCK_CONSUMER_OWNED', 12716000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2013, 'VEH_STOCK_CONSUMER_OWNED', 12994000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2014, 'VEH_STOCK_CONSUMER_OWNED', 13255000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2015, 'VEH_STOCK_CONSUMER_OWNED', 13513000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2016, 'VEH_STOCK_CONSUMER_OWNED', 13766000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2017, 'VEH_STOCK_CONSUMER_OWNED', 14004000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2018, 'VEH_STOCK_CONSUMER_OWNED', 14213000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2019, 'VEH_STOCK_CONSUMER_OWNED', 14395000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2020, 'VEH_STOCK_CONSUMER_OWNED', 14679249);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2021, 'VEH_STOCK_CONSUMER_OWNED', 14854000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2022, 'VEH_STOCK_CONSUMER_OWNED', 15095000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2023, 'VEH_STOCK_CONSUMER_OWNED', 15330000);

-- AUSTRIA (AUT) - Source: Statistics Austria / ACEA - 
-- db matches ai insert
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2010, 'VEH_STOCK_CONSUMER_OWNED', 4441027);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2011, 'VEH_STOCK_CONSUMER_OWNED', 4513421);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2012, 'VEH_STOCK_CONSUMER_OWNED', 4584202);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2013, 'VEH_STOCK_CONSUMER_OWNED', 4641308);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2014, 'VEH_STOCK_CONSUMER_OWNED', 4694921);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2015, 'VEH_STOCK_CONSUMER_OWNED', 4748048);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2016, 'VEH_STOCK_CONSUMER_OWNED', 4822024);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2017, 'VEH_STOCK_CONSUMER_OWNED', 4898578);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2018, 'VEH_STOCK_CONSUMER_OWNED', 4978852);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2019, 'VEH_STOCK_CONSUMER_OWNED', 5039548);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2020, 'VEH_STOCK_CONSUMER_OWNED', 5091827);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2021, 'VEH_STOCK_CONSUMER_OWNED', 5133836);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2022, 'VEH_STOCK_CONSUMER_OWNED', 5156000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2023, 'VEH_STOCK_CONSUMER_OWNED', 5185006);

-- BELGIUM (BEL) - Source: Statbel / ACEA
-- difference of ~30k between ai pull and db
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2010, 'VEH_STOCK_CONSUMER_OWNED', 5291813);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2011, 'VEH_STOCK_CONSUMER_OWNED', 5403831);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2012, 'VEH_STOCK_CONSUMER_OWNED', 5488967);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2013, 'VEH_STOCK_CONSUMER_OWNED', 5538098);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2014, 'VEH_STOCK_CONSUMER_OWNED', 5574572);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2015, 'VEH_STOCK_CONSUMER_OWNED', 5619080);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2016, 'VEH_STOCK_CONSUMER_OWNED', 5675176);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2017, 'VEH_STOCK_CONSUMER_OWNED', 5735280);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2018, 'VEH_STOCK_CONSUMER_OWNED', 5782684);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2019, 'VEH_STOCK_CONSUMER_OWNED', 5813771);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2020, 'VEH_STOCK_CONSUMER_OWNED', 5827195);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2021, 'VEH_STOCK_CONSUMER_OWNED', 5851682);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2022, 'VEH_STOCK_CONSUMER_OWNED', 5930000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2023, 'VEH_STOCK_CONSUMER_OWNED', 6047551);



-- DENMARK (DNK) - Source: Statistics Denmark / ACEA
-- out by ~40k from db
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2010, 'VEH_STOCK_CONSUMER_OWNED', 2126903);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2011, 'VEH_STOCK_CONSUMER_OWNED', 2168044);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2012, 'VEH_STOCK_CONSUMER_OWNED', 2209857);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2013, 'VEH_STOCK_CONSUMER_OWNED', 2245621);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2014, 'VEH_STOCK_CONSUMER_OWNED', 2301584);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2015, 'VEH_STOCK_CONSUMER_OWNED', 2378624);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2016, 'VEH_STOCK_CONSUMER_OWNED', 2453213);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2017, 'VEH_STOCK_CONSUMER_OWNED', 2529983);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2018, 'VEH_STOCK_CONSUMER_OWNED', 2593591);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2019, 'VEH_STOCK_CONSUMER_OWNED', 2650227);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2020, 'VEH_STOCK_CONSUMER_OWNED', 2720271);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2021, 'VEH_STOCK_CONSUMER_OWNED', 2781860);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2022, 'VEH_STOCK_CONSUMER_OWNED', 2812000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2023, 'VEH_STOCK_CONSUMER_OWNED', 2827864);

-- FINLAND (FIN) - Source: Statistics Finland / ACEA
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2010, 'VEH_STOCK_CONSUMER_OWNED', 2538915);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2011, 'VEH_STOCK_CONSUMER_OWNED', 2573974);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2012, 'VEH_STOCK_CONSUMER_OWNED', 2606093);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2013, 'VEH_STOCK_CONSUMER_OWNED', 2632139);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2014, 'VEH_STOCK_CONSUMER_OWNED', 2645605);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2015, 'VEH_STOCK_CONSUMER_OWNED', 2653350);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2016, 'VEH_STOCK_CONSUMER_OWNED', 2668103);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2017, 'VEH_STOCK_CONSUMER_OWNED', 2668930);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2018, 'VEH_STOCK_CONSUMER_OWNED', 2696334);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2019, 'VEH_STOCK_CONSUMER_OWNED', 2720307);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2020, 'VEH_STOCK_CONSUMER_OWNED', 2748448);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2021, 'VEH_STOCK_CONSUMER_OWNED', 2755349);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2022, 'VEH_STOCK_CONSUMER_OWNED', 2720000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2023, 'VEH_STOCK_CONSUMER_OWNED', 2740000);

-- GERMANY (DEU) - Source: KBA (Kraftfahrt-Bundesamt)
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2010, 'VEH_STOCK_CONSUMER_OWNED', 41737627);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2011, 'VEH_STOCK_CONSUMER_OWNED', 42301563);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2012, 'VEH_STOCK_CONSUMER_OWNED', 42927647);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2013, 'VEH_STOCK_CONSUMER_OWNED', 43431124);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2014, 'VEH_STOCK_CONSUMER_OWNED', 43851230);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2015, 'VEH_STOCK_CONSUMER_OWNED', 44403124);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2016, 'VEH_STOCK_CONSUMER_OWNED', 45071209);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2017, 'VEH_STOCK_CONSUMER_OWNED', 45803560);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2018, 'VEH_STOCK_CONSUMER_OWNED', 46474594);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2019, 'VEH_STOCK_CONSUMER_OWNED', 47095784);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2020, 'VEH_STOCK_CONSUMER_OWNED', 47715977);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2021, 'VEH_STOCK_CONSUMER_OWNED', 48248584);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2022, 'VEH_STOCK_CONSUMER_OWNED', 48540878);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2023, 'VEH_STOCK_CONSUMER_OWNED', 48763036);

-- GREECE (GRC) - Source: ELSTAT / ACEA
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2010, 'VEH_STOCK_CONSUMER_OWNED', 5216581);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2011, 'VEH_STOCK_CONSUMER_OWNED', 5196654);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2012, 'VEH_STOCK_CONSUMER_OWNED', 5151621);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2013, 'VEH_STOCK_CONSUMER_OWNED', 5124000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2014, 'VEH_STOCK_CONSUMER_OWNED', 5112000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2015, 'VEH_STOCK_CONSUMER_OWNED', 5105000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2016, 'VEH_STOCK_CONSUMER_OWNED', 5110000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2017, 'VEH_STOCK_CONSUMER_OWNED', 5169026);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2018, 'VEH_STOCK_CONSUMER_OWNED', 5164183);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2019, 'VEH_STOCK_CONSUMER_OWNED', 5247295);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2020, 'VEH_STOCK_CONSUMER_OWNED', 5315875);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2021, 'VEH_STOCK_CONSUMER_OWNED', 5408149);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2022, 'VEH_STOCK_CONSUMER_OWNED', 5580000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2023, 'VEH_STOCK_CONSUMER_OWNED', 5877759);

-- ICELAND (ISL) - Source: Statistics Iceland / ACEA
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2010, 'VEH_STOCK_CONSUMER_OWNED', 181127);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2011, 'VEH_STOCK_CONSUMER_OWNED', 183244);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2012, 'VEH_STOCK_CONSUMER_OWNED', 186532);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2013, 'VEH_STOCK_CONSUMER_OWNED', 189645);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2014, 'VEH_STOCK_CONSUMER_OWNED', 194892);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2015, 'VEH_STOCK_CONSUMER_OWNED', 201543);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2016, 'VEH_STOCK_CONSUMER_OWNED', 207835);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2017, 'VEH_STOCK_CONSUMER_OWNED', 214045);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2018, 'VEH_STOCK_CONSUMER_OWNED', 222729);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2019, 'VEH_STOCK_CONSUMER_OWNED', 223999);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2020, 'VEH_STOCK_CONSUMER_OWNED', 219628);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2021, 'VEH_STOCK_CONSUMER_OWNED', 227801);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2022, 'VEH_STOCK_CONSUMER_OWNED', 242000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2023, 'VEH_STOCK_CONSUMER_OWNED', 256000);

-- IRELAND (IRL) - Source: ACEA / Department of Transport Ireland
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2010, 'VEH_STOCK_CONSUMER_OWNED', 1887800);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2011, 'VEH_STOCK_CONSUMER_OWNED', 1887914);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2012, 'VEH_STOCK_CONSUMER_OWNED', 1881806);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2013, 'VEH_STOCK_CONSUMER_OWNED', 1904920);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2014, 'VEH_STOCK_CONSUMER_OWNED', 1946065);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2015, 'VEH_STOCK_CONSUMER_OWNED', 1978485);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2016, 'VEH_STOCK_CONSUMER_OWNED', 2022995);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2017, 'VEH_STOCK_CONSUMER_OWNED', 2064020);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2018, 'VEH_STOCK_CONSUMER_OWNED', 2104060);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2019, 'VEH_STOCK_CONSUMER_OWNED', 2172098);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2020, 'VEH_STOCK_CONSUMER_OWNED', 2215127);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2021, 'VEH_STOCK_CONSUMER_OWNED', 2266479);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2022, 'VEH_STOCK_CONSUMER_OWNED', 2350000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2023, 'VEH_STOCK_CONSUMER_OWNED', 2432000);

-- ITALY (ITA) - Source: ACI / ACEA
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2010, 'VEH_STOCK_CONSUMER_OWNED', 36751831);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2011, 'VEH_STOCK_CONSUMER_OWNED', 37113274);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2012, 'VEH_STOCK_CONSUMER_OWNED', 37078274);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2013, 'VEH_STOCK_CONSUMER_OWNED', 36962694);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2014, 'VEH_STOCK_CONSUMER_OWNED', 37080753);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2015, 'VEH_STOCK_CONSUMER_OWNED', 37351233);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2016, 'VEH_STOCK_CONSUMER_OWNED', 37876138);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2017, 'VEH_STOCK_CONSUMER_OWNED', 38520321);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2018, 'VEH_STOCK_CONSUMER_OWNED', 39018170);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2019, 'VEH_STOCK_CONSUMER_OWNED', 39545232);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2020, 'VEH_STOCK_CONSUMER_OWNED', 39717874);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2021, 'VEH_STOCK_CONSUMER_OWNED', 39822723);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2022, 'VEH_STOCK_CONSUMER_OWNED', 40210000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2023, 'VEH_STOCK_CONSUMER_OWNED', 40839000);


-- LATVIA (LVA) - Source: ACEA / Eurostat
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2010, 'VEH_STOCK_CONSUMER_OWNED', 523245);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2011, 'VEH_STOCK_CONSUMER_OWNED', 548372);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2012, 'VEH_STOCK_CONSUMER_OWNED', 566723);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2013, 'VEH_STOCK_CONSUMER_OWNED', 590424);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2014, 'VEH_STOCK_CONSUMER_OWNED', 616238);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2015, 'VEH_STOCK_CONSUMER_OWNED', 641565);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2016, 'VEH_STOCK_CONSUMER_OWNED', 665198);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2017, 'VEH_STOCK_CONSUMER_OWNED', 688617);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2018, 'VEH_STOCK_CONSUMER_OWNED', 707559);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2019, 'VEH_STOCK_CONSUMER_OWNED', 726501);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2020, 'VEH_STOCK_CONSUMER_OWNED', 736953);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2021, 'VEH_STOCK_CONSUMER_OWNED', 757821);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2022, 'VEH_STOCK_CONSUMER_OWNED', 780000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2023, 'VEH_STOCK_CONSUMER_OWNED', 805000);

-- LUXEMBOURG (LUX) - Source: ACEA / Eurostat
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2010, 'VEH_STOCK_CONSUMER_OWNED', 330400);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2011, 'VEH_STOCK_CONSUMER_OWNED', 343800);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2012, 'VEH_STOCK_CONSUMER_OWNED', 357300);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2013, 'VEH_STOCK_CONSUMER_OWNED', 368300);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2014, 'VEH_STOCK_CONSUMER_OWNED', 378100);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2015, 'VEH_STOCK_CONSUMER_OWNED', 389100);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2016, 'VEH_STOCK_CONSUMER_OWNED', 396587);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2017, 'VEH_STOCK_CONSUMER_OWNED', 403258);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2018, 'VEH_STOCK_CONSUMER_OWNED', 415128);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2019, 'VEH_STOCK_CONSUMER_OWNED', 426324);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2020, 'VEH_STOCK_CONSUMER_OWNED', 435989);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2021, 'VEH_STOCK_CONSUMER_OWNED', 443301);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2022, 'VEH_STOCK_CONSUMER_OWNED', 452000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2023, 'VEH_STOCK_CONSUMER_OWNED', 459842);

-- NORWAY (NOR) - Source: Statistics Norway / ACEA
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2010, 'VEH_STOCK_CONSUMER_OWNED', 2308930);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2011, 'VEH_STOCK_CONSUMER_OWNED', 2378591);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2012, 'VEH_STOCK_CONSUMER_OWNED', 2436785);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2013, 'VEH_STOCK_CONSUMER_OWNED', 2496000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2014, 'VEH_STOCK_CONSUMER_OWNED', 2556432);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2015, 'VEH_STOCK_CONSUMER_OWNED', 2612613);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2016, 'VEH_STOCK_CONSUMER_OWNED', 2662920);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2017, 'VEH_STOCK_CONSUMER_OWNED', 2693021);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2018, 'VEH_STOCK_CONSUMER_OWNED', 2720013);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2019, 'VEH_STOCK_CONSUMER_OWNED', 2768990);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2020, 'VEH_STOCK_CONSUMER_OWNED', 2794457);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2021, 'VEH_STOCK_CONSUMER_OWNED', 2802246);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2022, 'VEH_STOCK_CONSUMER_OWNED', 2830000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2023, 'VEH_STOCK_CONSUMER_OWNED', 2860000);

-- PORTUGAL (PRT) - Source: ACEA / Eurostat
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2010, 'VEH_STOCK_CONSUMER_OWNED', 4480000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2011, 'VEH_STOCK_CONSUMER_OWNED', 4540000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2012, 'VEH_STOCK_CONSUMER_OWNED', 4540000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2013, 'VEH_STOCK_CONSUMER_OWNED', 4495000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2014, 'VEH_STOCK_CONSUMER_OWNED', 4548000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2015, 'VEH_STOCK_CONSUMER_OWNED', 4667000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2016, 'VEH_STOCK_CONSUMER_OWNED', 4730000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2017, 'VEH_STOCK_CONSUMER_OWNED', 4800000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2018, 'VEH_STOCK_CONSUMER_OWNED', 5015000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2019, 'VEH_STOCK_CONSUMER_OWNED', 5205000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2020, 'VEH_STOCK_CONSUMER_OWNED', 5300000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2021, 'VEH_STOCK_CONSUMER_OWNED', 5410000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2022, 'VEH_STOCK_CONSUMER_OWNED', 5540000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2023, 'VEH_STOCK_CONSUMER_OWNED', 5720000);

-- SLOVENIA (SVN) - Source: ACEA / Eurostat
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2010, 'VEH_STOCK_CONSUMER_OWNED', 1057592);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2011, 'VEH_STOCK_CONSUMER_OWNED', 1070990);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2012, 'VEH_STOCK_CONSUMER_OWNED', 1083750);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2013, 'VEH_STOCK_CONSUMER_OWNED', 1090521);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2014, 'VEH_STOCK_CONSUMER_OWNED', 1101000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2015, 'VEH_STOCK_CONSUMER_OWNED', 1126000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2016, 'VEH_STOCK_CONSUMER_OWNED', 1158000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2017, 'VEH_STOCK_CONSUMER_OWNED', 1192358);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2018, 'VEH_STOCK_CONSUMER_OWNED', 1220814);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2019, 'VEH_STOCK_CONSUMER_OWNED', 1249364);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2020, 'VEH_STOCK_CONSUMER_OWNED', 1253984);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2021, 'VEH_STOCK_CONSUMER_OWNED', 1202547);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2022, 'VEH_STOCK_CONSUMER_OWNED', 1218000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2023, 'VEH_STOCK_CONSUMER_OWNED', 1240000);
-- NEW ZEALAND (NZL) - Source: NZ Transport Agency / Ministry of Transport
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2010, 'VEH_STOCK_CONSUMER_OWNED', 2509000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2011, 'VEH_STOCK_CONSUMER_OWNED', 2560000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2012, 'VEH_STOCK_CONSUMER_OWNED', 2618000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2013, 'VEH_STOCK_CONSUMER_OWNED', 2680000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2014, 'VEH_STOCK_CONSUMER_OWNED', 2761000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2015, 'VEH_STOCK_CONSUMER_OWNED', 2858000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2016, 'VEH_STOCK_CONSUMER_OWNED', 2978000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2017, 'VEH_STOCK_CONSUMER_OWNED', 3105000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2018, 'VEH_STOCK_CONSUMER_OWNED', 3230000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2019, 'VEH_STOCK_CONSUMER_OWNED', 3360000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2020, 'VEH_STOCK_CONSUMER_OWNED', 3438000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2021, 'VEH_STOCK_CONSUMER_OWNED', 3515000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2022, 'VEH_STOCK_CONSUMER_OWNED', 3610000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2023, 'VEH_STOCK_CONSUMER_OWNED', 3695000);

INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2017, 'VEH_STOCK_TOTAL', 5383312);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2018, 'VEH_STOCK_TOTAL', 5484120);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2019, 'VEH_STOCK_TOTAL', 5563614);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2020, 'VEH_STOCK_TOTAL', 5633522);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2021, 'VEH_STOCK_TOTAL', 5711832);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2017, 'VEH_STOCK_TOTAL', 6627292);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2018, 'VEH_STOCK_TOTAL', 6705944);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2019, 'VEH_STOCK_TOTAL', 6768239);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2020, 'VEH_STOCK_TOTAL', 6811338);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2021, 'VEH_STOCK_TOTAL', 6868243);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('HRV', 'Croatia', 2017, 'VEH_STOCK_TOTAL', 1737689);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('HRV', 'Croatia', 2018, 'VEH_STOCK_TOTAL', 1852052);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('HRV', 'Croatia', 2019, 'VEH_STOCK_TOTAL', 1928307);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('HRV', 'Croatia', 2020, 'VEH_STOCK_TOTAL', 1940098);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('HRV', 'Croatia', 2021, 'VEH_STOCK_TOTAL', 2013204);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CYP', 'Cyprus', 2017, 'VEH_STOCK_TOTAL', 637353);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CYP', 'Cyprus', 2018, 'VEH_STOCK_TOTAL', 664821);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CYP', 'Cyprus', 2019, 'VEH_STOCK_TOTAL', 690196);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CYP', 'Cyprus', 2020, 'VEH_STOCK_TOTAL', 697093);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CYP', 'Cyprus', 2021, 'VEH_STOCK_TOTAL', 712856);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CZE', 'Czech Republic', 2017, 'VEH_STOCK_TOTAL', 6360831);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CZE', 'Czech Republic', 2018, 'VEH_STOCK_TOTAL', 6586168);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CZE', 'Czech Republic', 2019, 'VEH_STOCK_TOTAL', 6785310);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CZE', 'Czech Republic', 2020, 'VEH_STOCK_TOTAL', 6931618);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CZE', 'Czech Republic', 2021, 'VEH_STOCK_TOTAL', 7110924);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2017, 'VEH_STOCK_TOTAL', 2977075);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2018, 'VEH_STOCK_TOTAL', 3034662);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2019, 'VEH_STOCK_TOTAL', 3081746);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2020, 'VEH_STOCK_TOTAL', 3147319);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2021, 'VEH_STOCK_TOTAL', 3207038);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('EST', 'Estonia', 2017, 'VEH_STOCK_TOTAL', 845660);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('EST', 'Estonia', 2018, 'VEH_STOCK_TOTAL', 872655);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('EST', 'Estonia', 2019, 'VEH_STOCK_TOTAL', 931261);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('EST', 'Estonia', 2020, 'VEH_STOCK_TOTAL', 949276);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('EST', 'Estonia', 2021, 'VEH_STOCK_TOTAL', 971371);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2017, 'VEH_STOCK_TOTAL', 3096961);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2018, 'VEH_STOCK_TOTAL', 3130640);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2019, 'VEH_STOCK_TOTAL', 3158696);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2020, 'VEH_STOCK_TOTAL', 3191483);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2021, 'VEH_STOCK_TOTAL', 3204523);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FRA', 'France', 2017, 'VEH_STOCK_TOTAL', 45053898);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FRA', 'France', 2018, 'VEH_STOCK_TOTAL', 45247196);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FRA', 'France', 2019, 'VEH_STOCK_TOTAL', 45404223);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FRA', 'France', 2020, 'VEH_STOCK_TOTAL', 45438712);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FRA', 'France', 2021, 'VEH_STOCK_TOTAL', 45728717);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2017, 'VEH_STOCK_TOTAL', 50092489);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2018, 'VEH_STOCK_TOTAL', 50847627);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2019, 'VEH_STOCK_TOTAL', 51605498);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2020, 'VEH_STOCK_TOTAL', 52275833);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2021, 'VEH_STOCK_TOTAL', 52727442);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2017, 'VEH_STOCK_TOTAL', 6288455);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2018, 'VEH_STOCK_TOTAL', 6311567);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2019, 'VEH_STOCK_TOTAL', 6408994);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2020, 'VEH_STOCK_TOTAL', 6491063);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2021, 'VEH_STOCK_TOTAL', 6606062);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('HUN', 'Hungary', 2017, 'VEH_STOCK_TOTAL', 4003461);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('HUN', 'Hungary', 2018, 'VEH_STOCK_TOTAL', 4199078);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('HUN', 'Hungary', 2019, 'VEH_STOCK_TOTAL', 4395683);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('HUN', 'Hungary', 2020, 'VEH_STOCK_TOTAL', 4515769);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('HUN', 'Hungary', 2021, 'VEH_STOCK_TOTAL', 4632814);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2017, 'VEH_STOCK_TOTAL', 2494141);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2018, 'VEH_STOCK_TOTAL', 2542573);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2019, 'VEH_STOCK_TOTAL', 2626732);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2020, 'VEH_STOCK_TOTAL', 2666506);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2021, 'VEH_STOCK_TOTAL', 2725916);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2017, 'VEH_STOCK_TOTAL', 43597915);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2018, 'VEH_STOCK_TOTAL', 44168726);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2019, 'VEH_STOCK_TOTAL', 44764756);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2020, 'VEH_STOCK_TOTAL', 45028334);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2021, 'VEH_STOCK_TOTAL', 45202046);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2017, 'VEH_STOCK_TOTAL', 781682);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2018, 'VEH_STOCK_TOTAL', 802687);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2019, 'VEH_STOCK_TOTAL', 823675);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2020, 'VEH_STOCK_TOTAL', 834284);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2021, 'VEH_STOCK_TOTAL', 857884);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LTU', 'Lithuania', 2017, 'VEH_STOCK_TOTAL', 1329361);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LTU', 'Lithuania', 2018, 'VEH_STOCK_TOTAL', 1361208);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LTU', 'Lithuania', 2019, 'VEH_STOCK_TOTAL', 1389469);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LTU', 'Lithuania', 2020, 'VEH_STOCK_TOTAL', 1416467);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LTU', 'Lithuania', 2021, 'VEH_STOCK_TOTAL', 1463346);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2017, 'VEH_STOCK_TOTAL', 451781);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2018, 'VEH_STOCK_TOTAL', 465749);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2019, 'VEH_STOCK_TOTAL', 479146);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2020, 'VEH_STOCK_TOTAL', 490900);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2021, 'VEH_STOCK_TOTAL', 500356);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NLD', 'Netherlands', 2017, 'VEH_STOCK_TOTAL', 9716156);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NLD', 'Netherlands', 2018, 'VEH_STOCK_TOTAL', 9951532);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NLD', 'Netherlands', 2019, 'VEH_STOCK_TOTAL', 10130437);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NLD', 'Netherlands', 2020, 'VEH_STOCK_TOTAL', 10248381);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NLD', 'Netherlands', 2021, 'VEH_STOCK_TOTAL', 10366785);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('POL', 'Poland', 2017, 'VEH_STOCK_TOTAL', 26258652);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('POL', 'Poland', 2018, 'VEH_STOCK_TOTAL', 27306660);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('POL', 'Poland', 2019, 'VEH_STOCK_TOTAL', 28366267);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('POL', 'Poland', 2020, 'VEH_STOCK_TOTAL', 29237555);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('POL', 'Poland', 2021, 'VEH_STOCK_TOTAL', 30136156);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2017, 'VEH_STOCK_TOTAL', 6041200);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2018, 'VEH_STOCK_TOTAL', 6281200);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2019, 'VEH_STOCK_TOTAL', 6489300);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2020, 'VEH_STOCK_TOTAL', 6591000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2021, 'VEH_STOCK_TOTAL', 6712300);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ROU', 'Romania', 2017, 'VEH_STOCK_TOTAL', 7021160);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ROU', 'Romania', 2018, 'VEH_STOCK_TOTAL', 7547827);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ROU', 'Romania', 2019, 'VEH_STOCK_TOTAL', 8061740);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ROU', 'Romania', 2020, 'VEH_STOCK_TOTAL', 8526807);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ROU', 'Romania', 2021, 'VEH_STOCK_TOTAL', 8853408);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVK', 'Slovakia', 2017, 'VEH_STOCK_TOTAL', 2573459);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVK', 'Slovakia', 2018, 'VEH_STOCK_TOTAL', 2680735);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVK', 'Slovakia', 2019, 'VEH_STOCK_TOTAL', 2745280);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVK', 'Slovakia', 2020, 'VEH_STOCK_TOTAL', 2799302);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVK', 'Slovakia', 2021, 'VEH_STOCK_TOTAL', 3023268);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2017, 'VEH_STOCK_TOTAL', 1307410);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2018, 'VEH_STOCK_TOTAL', 1343248);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2019, 'VEH_STOCK_TOTAL', 1377915);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2020, 'VEH_STOCK_TOTAL', 1385371);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2021, 'VEH_STOCK_TOTAL', 1337850);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ESP', 'Spain', 2017, 'VEH_STOCK_TOTAL', 28115002);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ESP', 'Spain', 2018, 'VEH_STOCK_TOTAL', 28836817);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ESP', 'Spain', 2019, 'VEH_STOCK_TOTAL', 29463309);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ESP', 'Spain', 2020, 'VEH_STOCK_TOTAL', 29584928);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ESP', 'Spain', 2021, 'VEH_STOCK_TOTAL', 29875896);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SWE', 'Sweden', 2017, 'VEH_STOCK_TOTAL', 5498418);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SWE', 'Sweden', 2018, 'VEH_STOCK_TOTAL', 5541213);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SWE', 'Sweden', 2019, 'VEH_STOCK_TOTAL', 5572062);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SWE', 'Sweden', 2020, 'VEH_STOCK_TOTAL', 5637469);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SWE', 'Sweden', 2021, 'VEH_STOCK_TOTAL', 5691566);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2017, 'VEH_STOCK_TOTAL', 245068);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2018, 'VEH_STOCK_TOTAL', 255164);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2019, 'VEH_STOCK_TOTAL', 257047);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2020, 'VEH_STOCK_TOTAL', 251540);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2021, 'VEH_STOCK_TOTAL', 261559);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2017, 'VEH_STOCK_TOTAL', 3300009);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2018, 'VEH_STOCK_TOTAL', 3330928);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2019, 'VEH_STOCK_TOTAL', 3392652);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2020, 'VEH_STOCK_TOTAL', 3426887);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2021, 'VEH_STOCK_TOTAL', 3441395);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CHE', 'Switzerland', 2017, 'VEH_STOCK_TOTAL', 5065798);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CHE', 'Switzerland', 2018, 'VEH_STOCK_TOTAL', 5126732);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CHE', 'Switzerland', 2019, 'VEH_STOCK_TOTAL', 5037061);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CHE', 'Switzerland', 2020, 'VEH_STOCK_TOTAL', 5215771);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CHE', 'Switzerland', 2021, 'VEH_STOCK_TOTAL', 5276228);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GBR', 'United Kingdom', 2017, 'VEH_STOCK_TOTAL', 39675562);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GBR', 'United Kingdom', 2018, 'VEH_STOCK_TOTAL', 39985260);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GBR', 'United Kingdom', 2019, 'VEH_STOCK_TOTAL', 40386429);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GBR', 'United Kingdom', 2020, 'VEH_STOCK_TOTAL', 42403988);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GBR', 'United Kingdom', 2021, 'VEH_STOCK_TOTAL', 42874124);

INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('KOR', 'South Korea', 2015, 'VEH_STOCK_TOTAL', 20989885);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('KOR', 'South Korea', 2016, 'VEH_STOCK_TOTAL', 21803351);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('KOR', 'South Korea', 2017, 'VEH_STOCK_TOTAL', 22528295);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('KOR', 'South Korea', 2018, 'VEH_STOCK_TOTAL', 23202555);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('KOR', 'South Korea', 2019, 'VEH_STOCK_TOTAL', 23677366);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('KOR', 'South Korea', 2020, 'VEH_STOCK_TOTAL', 24365979);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('KOR', 'South Korea', 2021, 'VEH_STOCK_TOTAL', 24911101);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('KOR', 'South Korea', 2022, 'VEH_STOCK_TOTAL', 25503078);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('KOR', 'South Korea', 2023, 'VEH_STOCK_TOTAL', 25949201);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('KOR', 'South Korea', 2024, 'VEH_STOCK_TOTAL', 26297919);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('KOR', 'South Korea', 2025, 'VEH_STOCK_TOTAL', 26514873);

INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('USA', 'United States', 2013, 'VEH_STOCK_TOTAL', 255876822);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('USA', 'United States', 2017, 'VEH_STOCK_TOTAL', 272429803);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('USA', 'United States', 2018, 'VEH_STOCK_TOTAL', 273595656);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('USA', 'United States', 2019, 'VEH_STOCK_TOTAL', 276491174);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('USA', 'United States', 2020, 'VEH_STOCK_TOTAL', 275936367);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('USA', 'United States', 2021, 'VEH_STOCK_TOTAL', 281185492);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('USA', 'United States', 2022, 'VEH_STOCK_TOTAL', 282174766);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('USA', 'United States', 2023, 'VEH_STOCK_TOTAL', 284614269);



INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('JPN', 'Japan', 2015, 'VEH_STOCK_TOTAL', 77404331);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('JPN', 'Japan', 2016, 'VEH_STOCK_TOTAL', 77739882);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('JPN', 'Japan', 2017, 'VEH_STOCK_TOTAL', 78100000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('JPN', 'Japan', 2018, 'VEH_STOCK_TOTAL', 78300000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('JPN', 'Japan', 2019, 'VEH_STOCK_TOTAL', 78440000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('JPN', 'Japan', 2020, 'VEH_STOCK_TOTAL', 76702773);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('JPN', 'Japan', 2021, 'VEH_STOCK_TOTAL', 78200000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('JPN', 'Japan', 2022, 'VEH_STOCK_TOTAL', 78500000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('JPN', 'Japan', 2023, 'VEH_STOCK_TOTAL', 78755861);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('JPN', 'Japan', 2024, 'VEH_STOCK_TOTAL', 78743110);

-- =====================================================
-- AUSTRALIA - Total Motor Vehicles (ABS/BITRE data)
-- =====================================================
-- Source: ABS Motor Vehicle Census (2015-2021), BITRE Road Vehicles Australia (2022+)

INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2015, 'VEH_STOCK_TOTAL', 18400000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2016, 'VEH_STOCK_TOTAL', 18800000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2017, 'VEH_STOCK_TOTAL', 19200000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2018, 'VEH_STOCK_TOTAL', 19500000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2019, 'VEH_STOCK_TOTAL', 19800000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2020, 'VEH_STOCK_TOTAL', 19229139);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2021, 'VEH_STOCK_TOTAL', 20267832);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2022, 'VEH_STOCK_TOTAL', 20687047);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2023, 'VEH_STOCK_TOTAL', 21168462);

-- =====================================================
-- NEW ZEALAND - Total Motor Vehicles (NZTA/CEIC data)
-- =====================================================
-- Source: NZ Transport Agency Motor Vehicle Register, Ministry of Transport Fleet Statistics

INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2015, 'VEH_STOCK_TOTAL', 3610000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2016, 'VEH_STOCK_TOTAL', 3750000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2017, 'VEH_STOCK_TOTAL', 3890000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2018, 'VEH_STOCK_TOTAL', 4030000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2019, 'VEH_STOCK_TOTAL', 4170000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2020, 'VEH_STOCK_TOTAL', 4300000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2021, 'VEH_STOCK_TOTAL', 4520000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2022, 'VEH_STOCK_TOTAL', 4590000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2023, 'VEH_STOCK_TOTAL', 4646350);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2024, 'VEH_STOCK_TOTAL', 4712629);

-- =====================================================
-- MEXICO - Total Motor Vehicles (INEGI data)
-- =====================================================
-- Source: INEGI Registered Motor Vehicles in Circulation

INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('MEX', 'Mexico', 2015, 'VEH_STOCK_TOTAL', 37353594);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('MEX', 'Mexico', 2016, 'VEH_STOCK_TOTAL', 40500000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('MEX', 'Mexico', 2017, 'VEH_STOCK_TOTAL', 43200000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('MEX', 'Mexico', 2018, 'VEH_STOCK_TOTAL', 45800000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('MEX', 'Mexico', 2019, 'VEH_STOCK_TOTAL', 48200000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('MEX', 'Mexico', 2020, 'VEH_STOCK_TOTAL', 45086615);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('MEX', 'Mexico', 2021, 'VEH_STOCK_TOTAL', 53100000);
INSERT INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('MEX', 'Mexico', 2022, 'VEH_STOCK_TOTAL', 55200000);


-- Passenger Vehicle Stock Historical Data - INSERT OR REPLACE Statements
-- Source: ACEA, KBA, ABS/BITRE, Statistics Austria, Statbel, Statistics Denmark, 
--         Statistics Finland, ELSTAT, Statistics Iceland, OICA, national agencies
-- Measure: VEH_STOCK_TOTAL (Passenger Car Stock)
-- Coverage: 2010-2023 for first 10 OECD countries

-- AUSTRALIA (AUS) - Source: ABS Motor Vehicle Census / BITRE
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2010, 'VEH_STOCK_TOTAL', 12165000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2011, 'VEH_STOCK_TOTAL', 12428000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2012, 'VEH_STOCK_TOTAL', 12716000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2013, 'VEH_STOCK_TOTAL', 12994000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2014, 'VEH_STOCK_TOTAL', 13255000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2015, 'VEH_STOCK_TOTAL', 13513000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2016, 'VEH_STOCK_TOTAL', 13766000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2017, 'VEH_STOCK_TOTAL', 14004000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2018, 'VEH_STOCK_TOTAL', 14213000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2019, 'VEH_STOCK_TOTAL', 14395000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2020, 'VEH_STOCK_TOTAL', 14679249);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2021, 'VEH_STOCK_TOTAL', 14854000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2022, 'VEH_STOCK_TOTAL', 15095000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2023, 'VEH_STOCK_TOTAL', 15330000);

-- AUSTRIA (AUT) - Source: Statistics Austria / ACEA
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2010, 'VEH_STOCK_TOTAL', 4441027);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2011, 'VEH_STOCK_TOTAL', 4513421);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2012, 'VEH_STOCK_TOTAL', 4584202);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2013, 'VEH_STOCK_TOTAL', 4641308);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2014, 'VEH_STOCK_TOTAL', 4694921);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2015, 'VEH_STOCK_TOTAL', 4748048);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2016, 'VEH_STOCK_TOTAL', 4822024);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2017, 'VEH_STOCK_TOTAL', 4898578);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2018, 'VEH_STOCK_TOTAL', 4978852);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2019, 'VEH_STOCK_TOTAL', 5039548);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2020, 'VEH_STOCK_TOTAL', 5091827);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2021, 'VEH_STOCK_TOTAL', 5133836);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2022, 'VEH_STOCK_TOTAL', 5156000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2023, 'VEH_STOCK_TOTAL', 5185006);

-- BELGIUM (BEL) - Source: Statbel / ACEA
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2010, 'VEH_STOCK_TOTAL', 5291813);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2011, 'VEH_STOCK_TOTAL', 5403831);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2012, 'VEH_STOCK_TOTAL', 5488967);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2013, 'VEH_STOCK_TOTAL', 5538098);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2014, 'VEH_STOCK_TOTAL', 5574572);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2015, 'VEH_STOCK_TOTAL', 5619080);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2016, 'VEH_STOCK_TOTAL', 5675176);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2017, 'VEH_STOCK_TOTAL', 5735280);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2018, 'VEH_STOCK_TOTAL', 5782684);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2019, 'VEH_STOCK_TOTAL', 5813771);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2020, 'VEH_STOCK_TOTAL', 5827195);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2021, 'VEH_STOCK_TOTAL', 5851682);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2022, 'VEH_STOCK_TOTAL', 5930000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2023, 'VEH_STOCK_TOTAL', 6047551);



-- DENMARK (DNK) - Source: Statistics Denmark / ACEA
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2010, 'VEH_STOCK_TOTAL', 2126903);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2011, 'VEH_STOCK_TOTAL', 2168044);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2012, 'VEH_STOCK_TOTAL', 2209857);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2013, 'VEH_STOCK_TOTAL', 2245621);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2014, 'VEH_STOCK_TOTAL', 2301584);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2015, 'VEH_STOCK_TOTAL', 2378624);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2016, 'VEH_STOCK_TOTAL', 2453213);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2017, 'VEH_STOCK_TOTAL', 2529983);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2018, 'VEH_STOCK_TOTAL', 2593591);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2019, 'VEH_STOCK_TOTAL', 2650227);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2020, 'VEH_STOCK_TOTAL', 2720271);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2021, 'VEH_STOCK_TOTAL', 2781860);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2022, 'VEH_STOCK_TOTAL', 2812000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2023, 'VEH_STOCK_TOTAL', 2827864);

-- FINLAND (FIN) - Source: Statistics Finland / ACEA
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2010, 'VEH_STOCK_TOTAL', 2538915);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2011, 'VEH_STOCK_TOTAL', 2573974);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2012, 'VEH_STOCK_TOTAL', 2606093);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2013, 'VEH_STOCK_TOTAL', 2632139);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2014, 'VEH_STOCK_TOTAL', 2645605);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2015, 'VEH_STOCK_TOTAL', 2653350);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2016, 'VEH_STOCK_TOTAL', 2668103);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2017, 'VEH_STOCK_TOTAL', 2668930);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2018, 'VEH_STOCK_TOTAL', 2696334);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2019, 'VEH_STOCK_TOTAL', 2720307);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2020, 'VEH_STOCK_TOTAL', 2748448);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2021, 'VEH_STOCK_TOTAL', 2755349);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2022, 'VEH_STOCK_TOTAL', 2720000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2023, 'VEH_STOCK_TOTAL', 2740000);

-- GERMANY (DEU) - Source: KBA (Kraftfahrt-Bundesamt)
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2010, 'VEH_STOCK_TOTAL', 41737627);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2011, 'VEH_STOCK_TOTAL', 42301563);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2012, 'VEH_STOCK_TOTAL', 42927647);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2013, 'VEH_STOCK_TOTAL', 43431124);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2014, 'VEH_STOCK_TOTAL', 43851230);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2015, 'VEH_STOCK_TOTAL', 44403124);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2016, 'VEH_STOCK_TOTAL', 45071209);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2017, 'VEH_STOCK_TOTAL', 45803560);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2018, 'VEH_STOCK_TOTAL', 46474594);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2019, 'VEH_STOCK_TOTAL', 47095784);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2020, 'VEH_STOCK_TOTAL', 47715977);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2021, 'VEH_STOCK_TOTAL', 48248584);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2022, 'VEH_STOCK_TOTAL', 48540878);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2023, 'VEH_STOCK_TOTAL', 48763036);

-- GREECE (GRC) - Source: ELSTAT / ACEA
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2010, 'VEH_STOCK_TOTAL', 5216581);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2011, 'VEH_STOCK_TOTAL', 5196654);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2012, 'VEH_STOCK_TOTAL', 5151621);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2013, 'VEH_STOCK_TOTAL', 5124000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2014, 'VEH_STOCK_TOTAL', 5112000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2015, 'VEH_STOCK_TOTAL', 5105000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2016, 'VEH_STOCK_TOTAL', 5110000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2017, 'VEH_STOCK_TOTAL', 5169026);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2018, 'VEH_STOCK_TOTAL', 5164183);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2019, 'VEH_STOCK_TOTAL', 5247295);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2020, 'VEH_STOCK_TOTAL', 5315875);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2021, 'VEH_STOCK_TOTAL', 5408149);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2022, 'VEH_STOCK_TOTAL', 5580000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2023, 'VEH_STOCK_TOTAL', 5877759);

-- ICELAND (ISL) - Source: Statistics Iceland / ACEA
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2010, 'VEH_STOCK_TOTAL', 181127);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2011, 'VEH_STOCK_TOTAL', 183244);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2012, 'VEH_STOCK_TOTAL', 186532);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2013, 'VEH_STOCK_TOTAL', 189645);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2014, 'VEH_STOCK_TOTAL', 194892);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2015, 'VEH_STOCK_TOTAL', 201543);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2016, 'VEH_STOCK_TOTAL', 207835);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2017, 'VEH_STOCK_TOTAL', 214045);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2018, 'VEH_STOCK_TOTAL', 222729);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2019, 'VEH_STOCK_TOTAL', 223999);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2020, 'VEH_STOCK_TOTAL', 219628);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2021, 'VEH_STOCK_TOTAL', 227801);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2022, 'VEH_STOCK_TOTAL', 242000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2023, 'VEH_STOCK_TOTAL', 256000);

-- Passenger Vehicle Stock Historical Data - INSERT OR REPLACE Statements
-- Countries 11-20: Ireland, Italy, Japan, Korea, Latvia, Luxembourg, New Zealand, Norway, Portugal, Slovenia
-- Source: ACEA, Eurostat, JAMA, KAMA, Statistics Norway, NZ Transport Agency, national agencies
-- Measure: VEH_STOCK_PASS (Passenger Car Stock)
-- Coverage: 2010-2023

-- IRELAND (IRL) - Source: ACEA / Department of Transport Ireland
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2010, 'VEH_STOCK_PASS', 1887800);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2011, 'VEH_STOCK_PASS', 1887914);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2012, 'VEH_STOCK_PASS', 1881806);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2013, 'VEH_STOCK_PASS', 1904920);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2014, 'VEH_STOCK_PASS', 1946065);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2015, 'VEH_STOCK_PASS', 1978485);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2016, 'VEH_STOCK_PASS', 2022995);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2017, 'VEH_STOCK_PASS', 2064020);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2018, 'VEH_STOCK_PASS', 2104060);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2019, 'VEH_STOCK_PASS', 2172098);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2020, 'VEH_STOCK_PASS', 2215127);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2021, 'VEH_STOCK_PASS', 2266479);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2022, 'VEH_STOCK_PASS', 2350000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2023, 'VEH_STOCK_PASS', 2432000);

-- ITALY (ITA) - Source: ACI / ACEA
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2010, 'VEH_STOCK_PASS', 36751831);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2011, 'VEH_STOCK_PASS', 37113274);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2012, 'VEH_STOCK_PASS', 37078274);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2013, 'VEH_STOCK_PASS', 36962694);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2014, 'VEH_STOCK_PASS', 37080753);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2015, 'VEH_STOCK_PASS', 37351233);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2016, 'VEH_STOCK_PASS', 37876138);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2017, 'VEH_STOCK_PASS', 38520321);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2018, 'VEH_STOCK_PASS', 39018170);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2019, 'VEH_STOCK_PASS', 39545232);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2020, 'VEH_STOCK_PASS', 39717874);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2021, 'VEH_STOCK_PASS', 39822723);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2022, 'VEH_STOCK_PASS', 40210000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2023, 'VEH_STOCK_PASS', 40839000);

-- JAPAN (JPN) - Source: JAMA (Japan Automobile Manufacturers Association)
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('JPN', 'Japan', 2010, 'VEH_STOCK_PASS', 58347000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('JPN', 'Japan', 2011, 'VEH_STOCK_PASS', 58654000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('JPN', 'Japan', 2012, 'VEH_STOCK_PASS', 59357000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('JPN', 'Japan', 2013, 'VEH_STOCK_PASS', 59870000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('JPN', 'Japan', 2014, 'VEH_STOCK_PASS', 60420000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('JPN', 'Japan', 2015, 'VEH_STOCK_PASS', 60865000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('JPN', 'Japan', 2016, 'VEH_STOCK_PASS', 61204000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('JPN', 'Japan', 2017, 'VEH_STOCK_PASS', 61512000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('JPN', 'Japan', 2018, 'VEH_STOCK_PASS', 61980000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('JPN', 'Japan', 2019, 'VEH_STOCK_PASS', 62186000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('JPN', 'Japan', 2020, 'VEH_STOCK_PASS', 62136000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('JPN', 'Japan', 2021, 'VEH_STOCK_PASS', 62100000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('JPN', 'Japan', 2022, 'VEH_STOCK_PASS', 62050000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('JPN', 'Japan', 2023, 'VEH_STOCK_PASS', 62000000);

-- KOREA (KOR) - Source: KAMA / Statistics Korea
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('KOR', 'Korea', 2010, 'VEH_STOCK_PASS', 13632000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('KOR', 'Korea', 2011, 'VEH_STOCK_PASS', 14136000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('KOR', 'Korea', 2012, 'VEH_STOCK_PASS', 14577000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('KOR', 'Korea', 2013, 'VEH_STOCK_PASS', 14936000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('KOR', 'Korea', 2014, 'VEH_STOCK_PASS', 15338000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('KOR', 'Korea', 2015, 'VEH_STOCK_PASS', 15618000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('KOR', 'Korea', 2016, 'VEH_STOCK_PASS', 16066000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('KOR', 'Korea', 2017, 'VEH_STOCK_PASS', 16529000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('KOR', 'Korea', 2018, 'VEH_STOCK_PASS', 17049000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('KOR', 'Korea', 2019, 'VEH_STOCK_PASS', 17539000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('KOR', 'Korea', 2020, 'VEH_STOCK_PASS', 18094000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('KOR', 'Korea', 2021, 'VEH_STOCK_PASS', 18527000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('KOR', 'Korea', 2022, 'VEH_STOCK_PASS', 18848000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('KOR', 'Korea', 2023, 'VEH_STOCK_PASS', 19150000);

-- LATVIA (LVA) - Source: ACEA / Eurostat
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2010, 'VEH_STOCK_PASS', 523245);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2011, 'VEH_STOCK_PASS', 548372);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2012, 'VEH_STOCK_PASS', 566723);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2013, 'VEH_STOCK_PASS', 590424);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2014, 'VEH_STOCK_PASS', 616238);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2015, 'VEH_STOCK_PASS', 641565);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2016, 'VEH_STOCK_PASS', 665198);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2017, 'VEH_STOCK_PASS', 688617);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2018, 'VEH_STOCK_PASS', 707559);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2019, 'VEH_STOCK_PASS', 726501);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2020, 'VEH_STOCK_PASS', 736953);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2021, 'VEH_STOCK_PASS', 757821);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2022, 'VEH_STOCK_PASS', 780000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2023, 'VEH_STOCK_PASS', 805000);

-- LUXEMBOURG (LUX) - Source: ACEA / Eurostat
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2010, 'VEH_STOCK_PASS', 330400);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2011, 'VEH_STOCK_PASS', 343800);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2012, 'VEH_STOCK_PASS', 357300);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2013, 'VEH_STOCK_PASS', 368300);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2014, 'VEH_STOCK_PASS', 378100);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2015, 'VEH_STOCK_PASS', 389100);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2016, 'VEH_STOCK_PASS', 396587);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2017, 'VEH_STOCK_PASS', 403258);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2018, 'VEH_STOCK_PASS', 415128);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2019, 'VEH_STOCK_PASS', 426324);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2020, 'VEH_STOCK_PASS', 435989);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2021, 'VEH_STOCK_PASS', 443301);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2022, 'VEH_STOCK_PASS', 452000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2023, 'VEH_STOCK_PASS', 459842);

-- NEW ZEALAND (NZL) - Source: NZ Transport Agency / Ministry of Transport
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2010, 'VEH_STOCK_TOTAL', 2509000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2011, 'VEH_STOCK_TOTAL', 2560000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2012, 'VEH_STOCK_TOTAL', 2618000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2013, 'VEH_STOCK_TOTAL', 2680000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2014, 'VEH_STOCK_TOTAL', 2761000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2015, 'VEH_STOCK_TOTAL', 2858000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2016, 'VEH_STOCK_TOTAL', 2978000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2017, 'VEH_STOCK_TOTAL', 3105000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2018, 'VEH_STOCK_TOTAL', 3230000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2019, 'VEH_STOCK_TOTAL', 3360000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2020, 'VEH_STOCK_TOTAL', 3438000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2021, 'VEH_STOCK_TOTAL', 3515000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2022, 'VEH_STOCK_TOTAL', 3610000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2023, 'VEH_STOCK_TOTAL', 3695000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2019, 'VEH_STOCK_PASS', 3360000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2020, 'VEH_STOCK_PASS', 3438000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2021, 'VEH_STOCK_PASS', 3515000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2022, 'VEH_STOCK_PASS', 3610000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2023, 'VEH_STOCK_PASS', 3695000);

-- NORWAY (NOR) - Source: Statistics Norway / ACEA
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2010, 'VEH_STOCK_PASS', 2308930);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2011, 'VEH_STOCK_PASS', 2378591);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2012, 'VEH_STOCK_PASS', 2436785);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2013, 'VEH_STOCK_PASS', 2496000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2014, 'VEH_STOCK_PASS', 2556432);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2015, 'VEH_STOCK_PASS', 2612613);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2016, 'VEH_STOCK_PASS', 2662920);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2017, 'VEH_STOCK_PASS', 2693021);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2018, 'VEH_STOCK_PASS', 2720013);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2019, 'VEH_STOCK_PASS', 2768990);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2020, 'VEH_STOCK_PASS', 2794457);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2021, 'VEH_STOCK_PASS', 2802246);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2022, 'VEH_STOCK_PASS', 2830000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2023, 'VEH_STOCK_PASS', 2860000);

-- PORTUGAL (PRT) - Source: ACEA / Eurostat
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2010, 'VEH_STOCK_PASS', 4480000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2011, 'VEH_STOCK_PASS', 4540000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2012, 'VEH_STOCK_PASS', 4540000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2013, 'VEH_STOCK_PASS', 4495000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2014, 'VEH_STOCK_PASS', 4548000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2015, 'VEH_STOCK_PASS', 4667000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2016, 'VEH_STOCK_PASS', 4730000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2017, 'VEH_STOCK_PASS', 4800000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2018, 'VEH_STOCK_PASS', 5015000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2019, 'VEH_STOCK_PASS', 5205000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2020, 'VEH_STOCK_PASS', 5300000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2021, 'VEH_STOCK_PASS', 5410000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2022, 'VEH_STOCK_PASS', 5540000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2023, 'VEH_STOCK_PASS', 5720000);

-- SLOVENIA (SVN) - Source: ACEA / Eurostat
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2010, 'VEH_STOCK_PASS', 1057592);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2011, 'VEH_STOCK_PASS', 1070990);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2012, 'VEH_STOCK_PASS', 1083750);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2013, 'VEH_STOCK_PASS', 1090521);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2014, 'VEH_STOCK_PASS', 1101000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2015, 'VEH_STOCK_PASS', 1126000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2016, 'VEH_STOCK_PASS', 1158000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2017, 'VEH_STOCK_PASS', 1192358);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2018, 'VEH_STOCK_PASS', 1220814);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2019, 'VEH_STOCK_PASS', 1249364);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2020, 'VEH_STOCK_PASS', 1253984);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2021, 'VEH_STOCK_PASS', 1202547);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2022, 'VEH_STOCK_PASS', 1218000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2023, 'VEH_STOCK_PASS', 1240000);

-- Electric Vehicle Stock Data by Country (OECD Members Only)
-- Sources: IEA Global EV Outlook 2025, ACEA, EV Volumes, CleanTechnica, WRI
-- Data reflects EV stock (vehicles in use on roads), not just annual sales
-- Note: The OECD data showing 1% for Norway is incorrect - actual data shows ~30%+ EV stock share

-- VEH_STOCK_EV = Electric vehicles in stock (on the road)
-- Data is for plug-in electric vehicles (BEV + PHEV) unless otherwise noted

-- ===========================================
-- NORWAY - World leader in EV adoption
-- Source: ACEA 2024, Norwegian Road Authority (OFV), Wikipedia
-- 28% BEV fleet share in 2024 per ACEA, 31.78% total EV fleet share by Dec 2025
-- Total car fleet ~2.8 million
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2018, 'VEH_STOCK_EV', 260000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2019, 'VEH_STOCK_EV', 340000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2020, 'VEH_STOCK_EV', 450000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2021, 'VEH_STOCK_EV', 590000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2022, 'VEH_STOCK_EV', 700000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2023, 'VEH_STOCK_EV', 790000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NOR', 'Norway', 2024, 'VEH_STOCK_EV', 890000);

-- ===========================================
-- UNITED STATES
-- Source: IEA Global EV Outlook 2025
-- Fleet reached ~3 million in 2022, growing steadily
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('USA', 'United States', 2018, 'VEH_STOCK_EV', 1100000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('USA', 'United States', 2019, 'VEH_STOCK_EV', 1450000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('USA', 'United States', 2020, 'VEH_STOCK_EV', 1800000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('USA', 'United States', 2021, 'VEH_STOCK_EV', 2100000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('USA', 'United States', 2022, 'VEH_STOCK_EV', 3000000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('USA', 'United States', 2023, 'VEH_STOCK_EV', 4400000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('USA', 'United States', 2024, 'VEH_STOCK_EV', 6000000);

-- ===========================================
-- GERMANY
-- Source: ACEA, EAFO
-- 3.3% BEV share of fleet in 2024, fleet of ~2 million EVs
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2018, 'VEH_STOCK_EV', 200000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2019, 'VEH_STOCK_EV', 300000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2020, 'VEH_STOCK_EV', 500000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2021, 'VEH_STOCK_EV', 850000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2022, 'VEH_STOCK_EV', 1300000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2023, 'VEH_STOCK_EV', 1700000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DEU', 'Germany', 2024, 'VEH_STOCK_EV', 2000000);

-- ===========================================
-- FRANCE
-- Source: ACEA, EAFO
-- Over 2.5 million electrified vehicles by Dec 2025
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FRA', 'France', 2018, 'VEH_STOCK_EV', 170000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FRA', 'France', 2019, 'VEH_STOCK_EV', 260000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FRA', 'France', 2020, 'VEH_STOCK_EV', 450000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FRA', 'France', 2021, 'VEH_STOCK_EV', 730000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FRA', 'France', 2022, 'VEH_STOCK_EV', 1050000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FRA', 'France', 2023, 'VEH_STOCK_EV', 1400000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FRA', 'France', 2024, 'VEH_STOCK_EV', 1850000);

-- ===========================================
-- UNITED KINGDOM
-- Source: IEA, ICCT
-- 30% EV sales share in 2024
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GBR', 'United Kingdom', 2018, 'VEH_STOCK_EV', 200000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GBR', 'United Kingdom', 2019, 'VEH_STOCK_EV', 300000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GBR', 'United Kingdom', 2020, 'VEH_STOCK_EV', 480000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GBR', 'United Kingdom', 2021, 'VEH_STOCK_EV', 750000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GBR', 'United Kingdom', 2022, 'VEH_STOCK_EV', 1070000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GBR', 'United Kingdom', 2023, 'VEH_STOCK_EV', 1450000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GBR', 'United Kingdom', 2024, 'VEH_STOCK_EV', 2000000);

-- ===========================================
-- NETHERLANDS
-- Source: ACEA, Wikipedia
-- 6.1% BEV fleet share in 2024, ~390,000+ EVs as of end 2021
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NLD', 'Netherlands', 2018, 'VEH_STOCK_EV', 145000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NLD', 'Netherlands', 2019, 'VEH_STOCK_EV', 190000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NLD', 'Netherlands', 2020, 'VEH_STOCK_EV', 280000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NLD', 'Netherlands', 2021, 'VEH_STOCK_EV', 390000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NLD', 'Netherlands', 2022, 'VEH_STOCK_EV', 480000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NLD', 'Netherlands', 2023, 'VEH_STOCK_EV', 570000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NLD', 'Netherlands', 2024, 'VEH_STOCK_EV', 680000);

-- ===========================================
-- SWEDEN
-- Source: ACEA, ICCT
-- 7.2% BEV fleet share in 2024, 58% sales share
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SWE', 'Sweden', 2018, 'VEH_STOCK_EV', 60000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SWE', 'Sweden', 2019, 'VEH_STOCK_EV', 95000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SWE', 'Sweden', 2020, 'VEH_STOCK_EV', 150000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SWE', 'Sweden', 2021, 'VEH_STOCK_EV', 260000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SWE', 'Sweden', 2022, 'VEH_STOCK_EV', 380000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SWE', 'Sweden', 2023, 'VEH_STOCK_EV', 480000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SWE', 'Sweden', 2024, 'VEH_STOCK_EV', 570000);

-- ===========================================
-- DENMARK
-- Source: ACEA, EEA
-- 12.1% BEV fleet share in 2024, 56% sales share
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2018, 'VEH_STOCK_EV', 20000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2019, 'VEH_STOCK_EV', 30000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2020, 'VEH_STOCK_EV', 55000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2021, 'VEH_STOCK_EV', 95000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2022, 'VEH_STOCK_EV', 150000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2023, 'VEH_STOCK_EV', 220000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('DNK', 'Denmark', 2024, 'VEH_STOCK_EV', 320000);

-- ===========================================
-- FINLAND
-- Source: ICCT, IEA
-- 50% EV sales share in 2024
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2018, 'VEH_STOCK_EV', 15000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2019, 'VEH_STOCK_EV', 25000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2020, 'VEH_STOCK_EV', 45000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2021, 'VEH_STOCK_EV', 80000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2022, 'VEH_STOCK_EV', 130000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2023, 'VEH_STOCK_EV', 185000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('FIN', 'Finland', 2024, 'VEH_STOCK_EV', 250000);

-- ===========================================
-- BELGIUM
-- Source: ACEA
-- 5.1% BEV fleet share in 2024, 43% sales share
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2018, 'VEH_STOCK_EV', 40000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2019, 'VEH_STOCK_EV', 60000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2020, 'VEH_STOCK_EV', 100000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2021, 'VEH_STOCK_EV', 170000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2022, 'VEH_STOCK_EV', 270000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2023, 'VEH_STOCK_EV', 380000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('BEL', 'Belgium', 2024, 'VEH_STOCK_EV', 500000);

-- ===========================================
-- ICELAND
-- Source: ACEA
-- 12.1% BEV fleet share in 2024
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2018, 'VEH_STOCK_EV', 4000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2019, 'VEH_STOCK_EV', 8000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2020, 'VEH_STOCK_EV', 14000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2021, 'VEH_STOCK_EV', 22000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2022, 'VEH_STOCK_EV', 30000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2023, 'VEH_STOCK_EV', 38000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISL', 'Iceland', 2024, 'VEH_STOCK_EV', 48000);

-- ===========================================
-- SWITZERLAND
-- Source: ACEA
-- 8.2% electric bus adoption, strong EV market
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CHE', 'Switzerland', 2018, 'VEH_STOCK_EV', 35000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CHE', 'Switzerland', 2019, 'VEH_STOCK_EV', 55000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CHE', 'Switzerland', 2020, 'VEH_STOCK_EV', 90000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CHE', 'Switzerland', 2021, 'VEH_STOCK_EV', 140000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CHE', 'Switzerland', 2022, 'VEH_STOCK_EV', 200000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CHE', 'Switzerland', 2023, 'VEH_STOCK_EV', 280000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CHE', 'Switzerland', 2024, 'VEH_STOCK_EV', 370000);

-- ===========================================
-- JAPAN
-- Source: IEA
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('JPN', 'Japan', 2018, 'VEH_STOCK_EV', 250000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('JPN', 'Japan', 2019, 'VEH_STOCK_EV', 300000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('JPN', 'Japan', 2020, 'VEH_STOCK_EV', 350000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('JPN', 'Japan', 2021, 'VEH_STOCK_EV', 400000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('JPN', 'Japan', 2022, 'VEH_STOCK_EV', 500000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('JPN', 'Japan', 2023, 'VEH_STOCK_EV', 650000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('JPN', 'Japan', 2024, 'VEH_STOCK_EV', 800000);

-- ===========================================
-- SOUTH KOREA
-- Source: IEA
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('KOR', 'South Korea', 2018, 'VEH_STOCK_EV', 70000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('KOR', 'South Korea', 2019, 'VEH_STOCK_EV', 130000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('KOR', 'South Korea', 2020, 'VEH_STOCK_EV', 200000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('KOR', 'South Korea', 2021, 'VEH_STOCK_EV', 330000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('KOR', 'South Korea', 2022, 'VEH_STOCK_EV', 500000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('KOR', 'South Korea', 2023, 'VEH_STOCK_EV', 700000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('KOR', 'South Korea', 2024, 'VEH_STOCK_EV', 950000);

-- ===========================================
-- CANADA
-- Source: IEA
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CAN', 'Canada', 2018, 'VEH_STOCK_EV', 100000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CAN', 'Canada', 2019, 'VEH_STOCK_EV', 150000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CAN', 'Canada', 2020, 'VEH_STOCK_EV', 200000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CAN', 'Canada', 2021, 'VEH_STOCK_EV', 280000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CAN', 'Canada', 2022, 'VEH_STOCK_EV', 400000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CAN', 'Canada', 2023, 'VEH_STOCK_EV', 560000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CAN', 'Canada', 2024, 'VEH_STOCK_EV', 750000);

-- ===========================================
-- AUSTRALIA
-- Source: IEA, EV Volumes
-- 93,000 EV sales in 2023, +141% YoY
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2018, 'VEH_STOCK_EV', 15000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2019, 'VEH_STOCK_EV', 25000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2020, 'VEH_STOCK_EV', 40000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2021, 'VEH_STOCK_EV', 60000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2022, 'VEH_STOCK_EV', 100000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2023, 'VEH_STOCK_EV', 200000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUS', 'Australia', 2024, 'VEH_STOCK_EV', 350000);

-- ===========================================
-- NEW ZEALAND
-- Source: IEA, Wikipedia
-- 14% EV sales share in 2023
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2018, 'VEH_STOCK_EV', 12000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2019, 'VEH_STOCK_EV', 20000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2020, 'VEH_STOCK_EV', 30000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2021, 'VEH_STOCK_EV', 45000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2022, 'VEH_STOCK_EV', 75000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2023, 'VEH_STOCK_EV', 120000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('NZL', 'New Zealand', 2024, 'VEH_STOCK_EV', 170000);

-- ===========================================
-- ITALY
-- Source: ACEA, EAFO
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2018, 'VEH_STOCK_EV', 25000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2019, 'VEH_STOCK_EV', 45000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2020, 'VEH_STOCK_EV', 80000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2021, 'VEH_STOCK_EV', 150000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2022, 'VEH_STOCK_EV', 230000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2023, 'VEH_STOCK_EV', 320000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ITA', 'Italy', 2024, 'VEH_STOCK_EV', 420000);

-- ===========================================
-- SPAIN
-- Source: ACEA, EAFO
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ESP', 'Spain', 2018, 'VEH_STOCK_EV', 35000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ESP', 'Spain', 2019, 'VEH_STOCK_EV', 55000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ESP', 'Spain', 2020, 'VEH_STOCK_EV', 85000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ESP', 'Spain', 2021, 'VEH_STOCK_EV', 140000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ESP', 'Spain', 2022, 'VEH_STOCK_EV', 210000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ESP', 'Spain', 2023, 'VEH_STOCK_EV', 290000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ESP', 'Spain', 2024, 'VEH_STOCK_EV', 400000);

-- ===========================================
-- AUSTRIA
-- Source: ACEA
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2018, 'VEH_STOCK_EV', 25000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2019, 'VEH_STOCK_EV', 40000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2020, 'VEH_STOCK_EV', 65000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2021, 'VEH_STOCK_EV', 110000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2022, 'VEH_STOCK_EV', 170000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2023, 'VEH_STOCK_EV', 240000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('AUT', 'Austria', 2024, 'VEH_STOCK_EV', 320000);

-- ===========================================
-- PORTUGAL
-- Source: IEA, ACEA
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2018, 'VEH_STOCK_EV', 20000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2019, 'VEH_STOCK_EV', 35000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2020, 'VEH_STOCK_EV', 55000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2021, 'VEH_STOCK_EV', 90000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2022, 'VEH_STOCK_EV', 140000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2023, 'VEH_STOCK_EV', 190000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('PRT', 'Portugal', 2024, 'VEH_STOCK_EV', 260000);

-- ===========================================
-- POLAND
-- Source: ICCT
-- <5% EV sales share in 2024
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('POL', 'Poland', 2018, 'VEH_STOCK_EV', 8000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('POL', 'Poland', 2019, 'VEH_STOCK_EV', 15000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('POL', 'Poland', 2020, 'VEH_STOCK_EV', 25000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('POL', 'Poland', 2021, 'VEH_STOCK_EV', 45000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('POL', 'Poland', 2022, 'VEH_STOCK_EV', 70000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('POL', 'Poland', 2023, 'VEH_STOCK_EV', 100000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('POL', 'Poland', 2024, 'VEH_STOCK_EV', 150000);

-- ===========================================
-- IRELAND
-- Source: Wikipedia
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2018, 'VEH_STOCK_EV', 8000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2019, 'VEH_STOCK_EV', 15000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2020, 'VEH_STOCK_EV', 30000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2021, 'VEH_STOCK_EV', 55000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2022, 'VEH_STOCK_EV', 85000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2023, 'VEH_STOCK_EV', 130000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('IRL', 'Ireland', 2024, 'VEH_STOCK_EV', 180000);

-- ===========================================
-- CZECH REPUBLIC (CZECHIA)
-- Source: ACEA
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CZE', 'Czech Republic', 2018, 'VEH_STOCK_EV', 3000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CZE', 'Czech Republic', 2019, 'VEH_STOCK_EV', 6000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CZE', 'Czech Republic', 2020, 'VEH_STOCK_EV', 12000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CZE', 'Czech Republic', 2021, 'VEH_STOCK_EV', 22000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CZE', 'Czech Republic', 2022, 'VEH_STOCK_EV', 35000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CZE', 'Czech Republic', 2023, 'VEH_STOCK_EV', 55000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CZE', 'Czech Republic', 2024, 'VEH_STOCK_EV', 80000);

-- ===========================================
-- HUNGARY
-- Source: ACEA
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('HUN', 'Hungary', 2018, 'VEH_STOCK_EV', 4000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('HUN', 'Hungary', 2019, 'VEH_STOCK_EV', 8000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('HUN', 'Hungary', 2020, 'VEH_STOCK_EV', 15000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('HUN', 'Hungary', 2021, 'VEH_STOCK_EV', 28000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('HUN', 'Hungary', 2022, 'VEH_STOCK_EV', 45000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('HUN', 'Hungary', 2023, 'VEH_STOCK_EV', 65000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('HUN', 'Hungary', 2024, 'VEH_STOCK_EV', 90000);

-- ===========================================
-- SLOVAKIA
-- Source: ACEA, ICCT
-- <5% EV sales share in 2024
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVK', 'Slovakia', 2018, 'VEH_STOCK_EV', 1500);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVK', 'Slovakia', 2019, 'VEH_STOCK_EV', 3000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVK', 'Slovakia', 2020, 'VEH_STOCK_EV', 5000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVK', 'Slovakia', 2021, 'VEH_STOCK_EV', 9000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVK', 'Slovakia', 2022, 'VEH_STOCK_EV', 15000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVK', 'Slovakia', 2023, 'VEH_STOCK_EV', 22000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVK', 'Slovakia', 2024, 'VEH_STOCK_EV', 32000);

-- ===========================================
-- SLOVENIA
-- Source: ACEA
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2018, 'VEH_STOCK_EV', 2000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2019, 'VEH_STOCK_EV', 4000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2020, 'VEH_STOCK_EV', 7000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2021, 'VEH_STOCK_EV', 12000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2022, 'VEH_STOCK_EV', 18000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2023, 'VEH_STOCK_EV', 26000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('SVN', 'Slovenia', 2024, 'VEH_STOCK_EV', 36000);

-- ===========================================
-- ESTONIA
-- Source: ACEA
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('EST', 'Estonia', 2018, 'VEH_STOCK_EV', 1500);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('EST', 'Estonia', 2019, 'VEH_STOCK_EV', 2500);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('EST', 'Estonia', 2020, 'VEH_STOCK_EV', 4000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('EST', 'Estonia', 2021, 'VEH_STOCK_EV', 7000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('EST', 'Estonia', 2022, 'VEH_STOCK_EV', 11000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('EST', 'Estonia', 2023, 'VEH_STOCK_EV', 16000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('EST', 'Estonia', 2024, 'VEH_STOCK_EV', 23000);

-- ===========================================
-- LATVIA
-- Source: ACEA
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2018, 'VEH_STOCK_EV', 800);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2019, 'VEH_STOCK_EV', 1500);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2020, 'VEH_STOCK_EV', 2500);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2021, 'VEH_STOCK_EV', 4500);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2022, 'VEH_STOCK_EV', 7000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2023, 'VEH_STOCK_EV', 10000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LVA', 'Latvia', 2024, 'VEH_STOCK_EV', 14000);

-- ===========================================
-- LITHUANIA
-- Source: ACEA
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LTU', 'Lithuania', 2018, 'VEH_STOCK_EV', 1000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LTU', 'Lithuania', 2019, 'VEH_STOCK_EV', 2000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LTU', 'Lithuania', 2020, 'VEH_STOCK_EV', 4000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LTU', 'Lithuania', 2021, 'VEH_STOCK_EV', 8000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LTU', 'Lithuania', 2022, 'VEH_STOCK_EV', 14000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LTU', 'Lithuania', 2023, 'VEH_STOCK_EV', 22000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LTU', 'Lithuania', 2024, 'VEH_STOCK_EV', 32000);

-- ===========================================
-- LUXEMBOURG
-- Source: ACEA
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2018, 'VEH_STOCK_EV', 3000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2019, 'VEH_STOCK_EV', 5000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2020, 'VEH_STOCK_EV', 10000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2021, 'VEH_STOCK_EV', 18000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2022, 'VEH_STOCK_EV', 28000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2023, 'VEH_STOCK_EV', 40000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('LUX', 'Luxembourg', 2024, 'VEH_STOCK_EV', 55000);

-- ===========================================
-- GREECE
-- Source: ACEA
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2018, 'VEH_STOCK_EV', 1500);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2019, 'VEH_STOCK_EV', 3000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2020, 'VEH_STOCK_EV', 6000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2021, 'VEH_STOCK_EV', 12000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2022, 'VEH_STOCK_EV', 22000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2023, 'VEH_STOCK_EV', 38000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('GRC', 'Greece', 2024, 'VEH_STOCK_EV', 60000);

-- ===========================================
-- ISRAEL
-- Source: IEA
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISR', 'Israel', 2018, 'VEH_STOCK_EV', 5000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISR', 'Israel', 2019, 'VEH_STOCK_EV', 10000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISR', 'Israel', 2020, 'VEH_STOCK_EV', 20000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISR', 'Israel', 2021, 'VEH_STOCK_EV', 45000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISR', 'Israel', 2022, 'VEH_STOCK_EV', 90000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISR', 'Israel', 2023, 'VEH_STOCK_EV', 150000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('ISR', 'Israel', 2024, 'VEH_STOCK_EV', 220000);

-- ===========================================
-- TURKEY (TURKIYE)
-- Source: EV Volumes
-- 86,600 units in 2023, +805% YoY
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('TUR', 'Turkey', 2018, 'VEH_STOCK_EV', 2000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('TUR', 'Turkey', 2019, 'VEH_STOCK_EV', 4000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('TUR', 'Turkey', 2020, 'VEH_STOCK_EV', 8000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('TUR', 'Turkey', 2021, 'VEH_STOCK_EV', 15000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('TUR', 'Turkey', 2022, 'VEH_STOCK_EV', 25000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('TUR', 'Turkey', 2023, 'VEH_STOCK_EV', 110000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('TUR', 'Turkey', 2024, 'VEH_STOCK_EV', 200000);

-- ===========================================
-- MEXICO
-- Source: IEA
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('MEX', 'Mexico', 2018, 'VEH_STOCK_EV', 8000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('MEX', 'Mexico', 2019, 'VEH_STOCK_EV', 15000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('MEX', 'Mexico', 2020, 'VEH_STOCK_EV', 25000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('MEX', 'Mexico', 2021, 'VEH_STOCK_EV', 40000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('MEX', 'Mexico', 2022, 'VEH_STOCK_EV', 65000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('MEX', 'Mexico', 2023, 'VEH_STOCK_EV', 100000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('MEX', 'Mexico', 2024, 'VEH_STOCK_EV', 150000);

-- ===========================================
-- CHILE
-- Source: IEA
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CHL', 'Chile', 2018, 'VEH_STOCK_EV', 1000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CHL', 'Chile', 2019, 'VEH_STOCK_EV', 2500);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CHL', 'Chile', 2020, 'VEH_STOCK_EV', 5000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CHL', 'Chile', 2021, 'VEH_STOCK_EV', 10000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CHL', 'Chile', 2022, 'VEH_STOCK_EV', 18000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CHL', 'Chile', 2023, 'VEH_STOCK_EV', 30000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CHL', 'Chile', 2024, 'VEH_STOCK_EV', 50000);

-- ===========================================
-- COLOMBIA
-- Source: IEA
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('COL', 'Colombia', 2018, 'VEH_STOCK_EV', 500);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('COL', 'Colombia', 2019, 'VEH_STOCK_EV', 1500);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('COL', 'Colombia', 2020, 'VEH_STOCK_EV', 3500);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('COL', 'Colombia', 2021, 'VEH_STOCK_EV', 7000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('COL', 'Colombia', 2022, 'VEH_STOCK_EV', 14000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('COL', 'Colombia', 2023, 'VEH_STOCK_EV', 25000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('COL', 'Colombia', 2024, 'VEH_STOCK_EV', 40000);

-- ===========================================
-- COSTA RICA
-- Source: Wikipedia
-- 11.6% sales share in 2023, 9,345 stock at end of 2023
-- ===========================================
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CRI', 'Costa Rica', 2018, 'VEH_STOCK_EV', 377);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CRI', 'Costa Rica', 2019, 'VEH_STOCK_EV', 700);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CRI', 'Costa Rica', 2020, 'VEH_STOCK_EV', 1446);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CRI', 'Costa Rica', 2021, 'VEH_STOCK_EV', 2800);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CRI', 'Costa Rica', 2022, 'VEH_STOCK_EV', 5000);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CRI', 'Costa Rica', 2023, 'VEH_STOCK_EV', 9345);
INSERT OR REPLACE INTO cars_data (country_code, country_name, year, measure, vehicles) VALUES ('CRI', 'Costa Rica', 2024, 'VEH_STOCK_EV', 16000);