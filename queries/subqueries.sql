-- 1. Find countries where the population is above the average global population
-- Purpose: Identifies populous countries that might have extensive tourist attractions.
SELECT Name, Population
FROM Country
WHERE Population > (SELECT AVG(Population) FROM Country);

-- 2. Find the official languages spoken in countries with a population under 1 million
-- Purpose: Suggests languages in less populous countries for off-the-beaten-path travelers.
SELECT Language, CountryCode
FROM CountryLanguage
WHERE CountryCode IN (SELECT Code FROM Country WHERE Population < 1000000);

-- 3. Match clients with a country that officially speaks their preferred language
-- Purpose: Makes it easier for clients to explore without tour guides.
SELECT Name AS ClientName, PreferredLanguage, 
       (SELECT Country.Name
        FROM Country
        JOIN CountryLanguage 
        ON Country.Code = CountryLanguage.CountryCode
        WHERE CountryLanguage.Language = Clients.PreferredLanguage
        AND CountryLanguage.IsOfficial = 'T'
        LIMIT 1) AS MatchingCountry
FROM Clients;

-- 4. Find countries with high life expectancy and low population density
-- Purpose: Identifies serene and healthy environments for tourists.
SELECT Name
FROM Country
WHERE LifeExpectancy > 75 AND (Population / SurfaceArea) < 50;

-- 5. Get the countries with low seafood prices
-- Purpose: Provides country recommendations for pescatarians that want cheap food.
SELECT Name AS CountryName
FROM Country 
WHERE Code IN (
    SELECT CountryCode 
    FROM CountryPrices 
    WHERE FishSeafoodPrice < 75.00
);

-- 6. Find countries with the most official languages
-- Purpose: Highlights multilingual countries for cultural diversity enthusiasts.
SELECT CountryCode, LanguageCount
FROM (
    SELECT CountryCode, COUNT(Language) AS LanguageCount
    FROM CountryLanguage
    GROUP BY CountryCode
) AS LanguageSummary
ORDER BY LanguageCount DESC;

-- 7. Get cities in countries with GNP higher than the global average
-- Purpose: Recommends economically prosperous regions.
SELECT CountryCode, Name
FROM City
WHERE CountryCode IN (SELECT Code FROM Country WHERE GNP > (SELECT AVG(GNP) FROM Country));

-- 8. Find clients interested in vegetarian or vegan diets
-- Purpose: Identifies a niche group of travelers.
SELECT Name, DietPreference
FROM Clients
WHERE DietPreference IN (
    SELECT DISTINCT DietPreference
    FROM Clients
    WHERE DietPreference IN ('Vegetarian', 'Vegan')
);

-- 9. Find countries with a low homicide rate and high life expectancy
-- Purpose: Recommends safe and healthy travel destinations.
SELECT Name
FROM Country
WHERE Code IN (SELECT CountryCode FROM CountryCrime WHERE HomicideRate < 5) 
AND LifeExpectancy > 75;

-- 10. Find countries in Europe with affordable fish prices
-- Purpose: Suggests European destinations for pescatarian clients on a budget.
SELECT Name
FROM Country
WHERE Code IN (SELECT CountryCode FROM CountryPrices WHERE FishSeafoodPrice < 100) 
AND Continent = 'Europe';