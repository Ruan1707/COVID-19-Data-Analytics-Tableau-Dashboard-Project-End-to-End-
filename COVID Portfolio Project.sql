SELECT *
FROM coviddeaths
WHERE continent IS NOT NULL;

CREATE TABLE covid_deaths1
LIKE coviddeaths;

INSERT covid_deaths1
SELECT *
FROM coviddeaths;

SELECT *
FROM covid_deaths1
WHERE continent IS NOT NULL;

DELETE FROM covid_deaths1
WHERE continent = '';

-- Looking at total cases vs total deaths

SELECT Location, `date`, total_cases , total_deaths , total_deaths*100/total_cases AS percentage_deathstocases
FROM covid_deaths1 
WHERE Location LIKE 'South Africa'; 

-- Looking at total cases vs population

SELECT Location, `date`, total_cases ,population, total_deaths , total_cases*100/population AS percentage_casesperpopulation
FROM covid_deaths1
WHERE Location LIKE 'South Africa'; 

-- Looking at countries with highest infection rate compared to population
SELECT Location, population, MAX(CAST(total_cases AS DECIMAL)) as HighestInfCount
FROM covid_deaths1
GROUP BY Location, population
ORDER BY HighestInfCount DESC; 

SELECT Location, population,`date`, MAX(total_cases) as HighestInfCount, MAX((total_cases*100/population)) AS percentage_populationinfection
FROM covid_deaths1
GROUP BY Location, population, `date`
ORDER BY percentage_populationinfection DESC; 

-- Showing countries with the highest death count per population

SELECT *
FROM covid_deaths1;

SELECT Location, population, MAX(CAST(total_deaths AS DECIMAL)) as HighestdeathCount
FROM covid_deaths1
WHERE continent IS NOT NULL
GROUP BY Location, population
ORDER BY HighestdeathCount DESC; 

SELECT Location, population, MAX(CAST(total_deaths AS DECIMAL)) as HighestdeathCount, MAX((total_deaths*100/population)) AS percentage_populationdeaths
FROM covid_deaths1
WHERE continent IS NOT NULL
GROUP BY Location, population
ORDER BY percentage_populationdeaths DESC; 

-- SUBTRACTING DEATHS FROM POPULATION

SELECT continent, location , `date`, population, total_deaths
, SUM(CAST(total_deaths as decimal)) OVER (PARTITION BY location ORDER by location, `date`) as rolling_death
FROM covid_deaths1
WHERE continent IS NOT NULL
ORDER BY 2,3;

-- USE CTE as rolling_death can not be determined in the same query where rolling_vac is created

WITH population_calc (continent, Location , `date`, Population, total_deaths, rolling_death)
as
(
SELECT continent, location , `date`, population, total_deaths
, SUM(CAST(total_deaths as decimal)) OVER (PARTITION BY location ORDER by location, `date`) as rolling_death
FROM covid_deaths1 
WHERE continent IS NOT NULL
)
SELECT *, (population - rolling_death) as new_population
FROM population_calc ;

-- Breaking the data up per continent
-- Showing the continents with the highest death count per population

SELECT continent, MAX(CAST(total_deaths AS DECIMAL)) as HighestdeathCount
FROM covid_deaths1
WHERE continent IS NOT NULL AND continent <> ' '
GROUP BY continent 
ORDER BY HighestdeathCount DESC; 

-- GLOBAL Numbers

SELECT `date`, SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)*100/SUM(new_cases) as death_percentage
FROM covid_deaths1 
WHERE Continent is not null
GROUP BY `date`
ORDER BY 1,2;

SELECT SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)*100/SUM(new_cases) as death_percentage
FROM covid_deaths1 
WHERE Continent is not null
ORDER BY 1,2;

-- Bring covidvaccinations table into project

SELECT COUNT(*)
FROM `covid_portfolio`.`covidvaccinations - copy`;

SELECT *
FROM `covid_portfolio`.`covidvaccinations - copy`;

CREATE TABLE covid_vaccinations1
LIKE `covidvaccinations - copy`;

INSERT covid_vaccinations1
SELECT *
FROM `covidvaccinations - copy`;

-- JOINING TABLES to look at total population vs vaccinations

SELECT dea.continent, dea.location , dea.`date`, dea.population, vac.new_vaccinations
, SUM(CAST(vac.new_vaccinations as decimal)) OVER (PARTITION BY dea.location ORDER by dea.location, dea.`date`) as rolling_vac
-- , rolling_vac*100/population
FROM covid_deaths1 as dea
JOIN covid_vaccinations1 as vac
	ON dea.location = vac.location
    and dea.`date` =  vac.`date`
WHERE dea.continent IS NOT NULL
ORDER BY 2,3;

-- USE CTE as rolling_vac*100/population can not be determined in the same query where rolling_vac is created

WITH PopvsVac(continent, Location , `date`, new_vaccinations, Population, rolling_vac)
as
(
SELECT dea.continent, dea.location , dea.`date`, vac.new_vaccinations, dea.population
, SUM(CAST(vac.new_vaccinations as decimal)) OVER (PARTITION BY dea.location ORDER by dea.location, dea.`date`) as rolling_vac
-- , rolling_vac*100/population
FROM covid_deaths1 as dea
JOIN covid_vaccinations1 as vac
	ON dea.location = vac.location
    and dea.`date` =  vac.`date`
WHERE dea.continent IS NOT NULL
)
SELECT *, rolling_vac*100/population as percentagepopvac
FROM PopvsVac ;

-- TEMP Table

-- DROP Table if exists PERCENTPOPOLATIONVACCINATED;
-- CREATE TABLE PERCENTPOPOLATIONVACCINATED
-- (
-- continent varchar(255),
-- Location varchar(255),
-- `date` datetime,
-- Population BIGINT default 0,
-- new_vaccinations decimal (10,2) default 0.00,
-- rolling_vac decimal (10,2) default 0.00
-- );

-- INSERT into PERCENTPOPOLATIONVACCINATED
-- SELECT dea.continent, dea.location , dea.`date`, vac.new_vaccinations, dea.population, SUM(new_vaccinations) 
-- 	OVER (PARTITION BY dea.location ORDER by dea.location, dea.`date`) as rolling_vac
-- , rolling_vac*100/population
-- FROM covid_deaths1 as dea
-- JOIN covid_vaccinations1 as vac
-- 	ON dea.location = vac.location
--     and dea.`date` =  vac.`date`
-- WHERE dea.continent IS NOT NULL;

-- SELECT *, rolling_vac*100/population as percentagepopvac
-- FROM PERCENTPOPOLATIONVACCINATED ;



-- Creating View to store data for later visualization
CREATE VIEW VIEWPERCENTPOPOLATIONVACCINATED as
SELECT dea.continent, dea.location , dea.`date`, dea.population, vac.new_vaccinations
, SUM(CAST(vac.new_vaccinations as decimal)) OVER (PARTITION BY dea.location ORDER by dea.location, dea.`date`) as rolling_vac
FROM covid_deaths1 as dea
JOIN covid_vaccinations1 as vac
	ON dea.location = vac.location
    and dea.`date` =  vac.`date`
WHERE dea.continent IS NOT NULL;

SELECT *
FROM VIEWPERCENTPOPOLATIONVACCINATED;


