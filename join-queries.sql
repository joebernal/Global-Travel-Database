-- 1. Find all cities with a population greater than 1 million
-- Purpose: Identify major metropolitan areas for potential tourism.
SELECT City.Name AS CityName, Country.Name AS CountryName, City.Population
FROM City
JOIN Country ON City.CountryCode = Country.Code
WHERE City.Population > 1000000;

-- 2. List the official languages spoken in each country along with their percentage
-- Purpose: Provides insights into languages officially used in countries, useful for clients’ language preferences.
SELECT Country.Name AS CountryName, CountryLanguage.Language, CountryLanguage.Percentage
FROM Country
JOIN CountryLanguage ON Country.Code = CountryLanguage.CountryCode
WHERE CountryLanguage.IsOfficial = 'T';

-- 3. Find countries with affordable fruit prices for vegetarian clients
-- Purpose: Recommends countries suitable for clients with dietary preferences and budget constraints.
SELECT Country.Name, CountryPrices.FruitPrice
FROM Country
JOIN CountryPrices ON Country.Code = CountryPrices.CountryCode
WHERE CountryPrices.FruitPrice < 100.0;

-- 4. List cities in countries with a high milk, cheese, and eggs price index
-- Purpose: Highlights regions where specific dietary goods are costly.
SELECT City.Name AS CityName, Country.Name AS CountryName, CountryPrices.MilkCheeseEggsPrice
FROM City
JOIN Country ON City.CountryCode = Country.Code
JOIN CountryPrices ON Country.Code = CountryPrices.CountryCode
WHERE CountryPrices.MilkCheeseEggsPrice > 150.0;

-- 5. Show the country, city, and primary language for families traveling with children
-- Purpose: Recommends family-friendly travel destinations based on language compatibility.
SELECT Clients.Name AS ClientName, 
       Country.Name AS CountryName, 
       City.Name AS CityName, 
       CountryLanguage.Language
FROM Clients
JOIN Country ON Clients.CountryCode = Country.Code
JOIN CountryLanguage ON Country.Code = CountryLanguage.CountryCode
JOIN City ON City.CountryCode = Country.Code
WHERE Clients.HasChildren = TRUE
  AND CountryLanguage.Language = Clients.PreferredLanguage;
