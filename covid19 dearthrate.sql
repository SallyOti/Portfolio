SELECT * FROM covid19_deathrate.`covid deaths`
WHERE continent IS NOT NULL
Order by 3,4;

--select the data that we are going to be using


SELECT location,date,new_cases,total_deaths,population FROM covid19_deathrate.`covid deaths`
Order by 1,2;

-- total cases VS total deaths
--shows the likelihood of dying if you contract covid in your country

SELECT location,total_cases,total_deaths, (total_deaths/total_cases)*100 AS deathpercentage
FROM `covid deaths`
WHERE location LIKE '%america%' AND continent IS NOT NUll
Order by 1,2;


-- Total cases vs population

SELECT location,total_cases,population, (total_cases/population)*100 AS casepercentage
FROM`covid deaths`
WHERE continent IS NOT NULL
Order by 1,2;

--Countries with the highest infection rate compared to population

SELECT location,population, MAX(total_cases) AS Highestinfection,MAX((total_cases/population)*100 )AS Infectionpercentage
FROM`covid deaths`
GROUP BY location,population
Order by Infectionpercentage DESC;

--showing countries with the highest deathcount per population

SELECT location, MAX(total_deaths) AS highestdeath,MAX((total_deaths/population)*100 )AS deathpercentage
FROM`covid deaths`
WHERE continent IS NOT NULL
GROUP BY location
Order by deathpercentage DESC;

-- BREAK THINGS down by continent
-- showing the continents with the highestdeathcounts

SELECT continent, MAX(total_deaths) AS highestdeath,MAX((total_deaths/population)*100 )AS deathpercentage
FROM`covid deaths`
WHERE continent IS NOT NULL
GROUP BY continent
Order by deathpercentage DESC;



--GLOBAL NUMBERS

SELECT date,SUM(new_cases) total_cases,SUM(new_deaths) total_deaths, (SUM(new_deaths)/SUM(new_cases))*100 percentagenewdeaths
FROM `covid deaths`
WHERE continent IS NOT NULL
GROUP BY date
Order by percentagenewdeaths DESC;


SELECT SUM(new_cases) total_cases,SUM(new_deaths) total_deaths, (SUM(new_deaths)/SUM(new_cases))*100 percentagenewdeaths
FROM `covid deaths`
WHERE continent IS NOT NULL
Order by percentagenewdeaths DESC;

--Looking at total population VS Vaccination

SELECT dea.continent,dea.location,dea.date,dea.population,Vac.new_vaccinations,SUM(Vac.new_vaccinations)OVER (Partition by dea.location order by dea.location,dea.date) as Rollingpeoplevaccinated
FROM `covid deaths` as dea JOIN `covid vaccination` as Vac ON dea.location=Vac.location 
 AND dea.date=Vac.date
 WHERE dea.continent IS NOT NULL
 Order by 2,3;
 
 
 
 --USE CTE
 
WITH PopsVSvac(continent,location,date,population,new_vaccinations,rollingpeoplevaccinated)
  as (SELECT dea.continent,dea.location,dea.date,dea.population,Vac.new_vaccinations,SUM(Vac.new_vaccinations)OVER (Partition by dea.location order by dea.location,dea.date) as Rollingpeoplevaccinated
FROM `covid deaths` as dea JOIN `covid vaccination` as Vac ON dea.location=Vac.location 
 AND dea.date=Vac.date)
 SELECT *,(rollingpeoplevaccinated/population)*100
 FROM popVSvac;
 
 --TEMP TABLE
 
 DROP TABLE IF exists Popvsvac
 CREATE TABLE Popvsvac
 (continent text,
 location text,
 date datetime,
 population numeric,
 new_vaccinations numeric,
 rollingpeoplevaccinated numeric)
 INSERT INTO Popvsvac
 SELECT dea.continent,dea.location,dea.date,dea.population,Vac.new_vaccinations,SUM(Vac.new_vaccinations)OVER (Partition by dea.location order by dea.location,dea.date) as Rollingpeoplevaccinated
FROM `covid deaths` as dea JOIN `covid vaccination` as Vac ON dea.location=Vac.location 
 AND dea.date=Vac.date;
 
 SELECT *
 FROM Popvsvac;
 
----CREATING VIEW

CREATE VIEW percentagepopulation as
SELECT dea.continent,dea.location,dea.date,dea.population,Vac.new_vaccinations,SUM(Vac.new_vaccinations)OVER (Partition by dea.location order by dea.location,dea.date) as Rollingpeoplevaccinated
FROM `covid deaths` as dea JOIN `covid vaccination` as Vac ON dea.location=Vac.location 
 AND dea.date=Vac.date
 WHERE dea.continent IS NOT NULL;


CREATE VIEW deathpercentage as SELECT continent, MAX(total_deaths) AS highestdeath,MAX((total_deaths/population)*100 )AS deathpercentage
FROM`covid deaths`
WHERE continent IS NOT NULL
GROUP BY continent
Order by deathpercentage DESC;












