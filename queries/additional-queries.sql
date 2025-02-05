-- 1. List top 5 countries by population
-- Purpose: Highlights major population centers.
SELECT Name, Population
FROM Country
ORDER BY Population DESC
LIMIT 5;

-- 2. Find the average population of cities in each country
-- Purpose: Helps understand urban density.
SELECT CountryCode, AVG(Population) AS AvgCityPopulation
FROM City
GROUP BY CountryCode;

-- 3. List countries with a high percentage of official language usage
-- Purpose: Suggests countries with strong linguistic consistency.
SELECT CountryCode, Percentage
FROM CountryLanguage
WHERE Percentage > 90;

-- 4. Count the number of clients interested in English-speaking countries
-- Purpose: Evaluates demand for English-speaking locations.
SELECT PreferredLanguage, COUNT(*)
FROM Clients
WHERE PreferredLanguage = 'English';

-- 5. List continents with the highest average GNP per country
-- Purpose: Highlights economically strong continents for luxury travelers.
SELECT Continent, AVG(GNP) AS AvgGNP
FROM Country
GROUP BY Continent
ORDER BY AvgGNP DESC;