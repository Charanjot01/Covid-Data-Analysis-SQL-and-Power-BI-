Use CovidData


--Creating views those will be used in Power BI to create visualizations

--1. Important figures about the deaths from Covid'19 all over the world

CREATE VIEW DeathFigures AS
SELECT iso_code,
	   date,
	   total_cases,
	   new_cases,
	   total_deaths,
	   new_deaths,
	   hosp_patients
FROM Covid_deaths

SELECT *
FROM DeathFigures
ORDER BY 1,2

--2. Important figures about the covid vaccinations all around the world

CREATE VIEW VaccinationsFigures AS
SELECT iso_code, 
	   date, 
	   total_tests, 
	   new_tests, 
	   positive_rate, 
	   tests_units, 
	   total_vaccinations, 
	   people_vaccinated, 
	   people_fully_vaccinated, 
	   median_age, 
	   aged_65_older, 
	   aged_70_older
FROM Covid_vaccinations

SELECT *
FROM VaccinationsFigures
ORDER BY 1,2

--3 Information regarding the countries and locations included in my data

CREATE VIEW LocationInformation AS
SELECT iso_code, 
	continent, 
	location, 
	population
FROM Covid_deaths

SELECT *
FROM LocationInformation
ORDER BY 1,3


-- Queries to compare results with the Power BI report

--1. Total cases, deaths and fully vaccinated people for each country

Drop Table if exists Global_table
Select dea.Continent, dea.Location, dea.Population, MAX(CAST(dea.total_cases AS bigint)) AS Total_cases,
	   MAX(CAST(dea.total_deaths AS bigint)) AS Total_deaths,
	   MAX(CAST(vac.people_fully_vaccinated AS bigint)) AS Total_people_fully_vaccinated
INTO Global_table
From Covid_deaths dea
Join Covid_vaccinations vac
	On dea.location=vac.location
	And  dea.date=vac.date
Where dea.continent is not NULL
Group by dea.Continent, dea.Location, dea.Population


--Visualizing above table in the descending order of total cases per country

Select * 
From Global_table
Order by 4 desc


--2. Global figures

With cte 
AS
(
SELECT SUM(Total_cases) AS Total_Cases_Global, 
	   SUM(Total_deaths) AS Total_Deaths_Global,
	   SUM(Total_people_fully_vaccinated) AS Total_people_fully_vaccinated_globally,
	   SUM(Population) AS Population
From Global_table
)
Select Total_Cases_Global,
	   Total_Deaths_Global,
	   ROUND((CAST(Total_Deaths_Global AS FLOAT)/(CAST(Total_Cases_Global AS FLOAT)))*100,2) AS Death_Percentage_Global,
	   (Total_people_fully_vaccinated_globally/Population)*100 AS Percent_Population_Fully_Vaccinated
From cte


--3. Total deaths due to covid-19 by continent in descending order

SELECT Continent, 
	   SUM(Total_Deaths) AS TotalDeathCount
FROM Global_table
WHERE Continent IS NOT NULL
GROUP BY Continent
ORDER BY TotalDeathCount DESC


--4. Total cases Vs. Total population (Percenatge of population got covid)

SELECT Location, 
	MAX(population) AS Population, 
	MAX(total_cases) AS Total_Cases_Count, 
	ROUND((MAX(total_cases)/MAX(population))*100, 2) AS Percentage_Population_Infected
FROM Covid_deaths
WHERE continent IS NOT NULL
GROUP BY Location
ORDER BY 4 DESC


--5. This query summarizes the Total Number of Deaths due to Covid by Country in Descending order

SELECT location, 
	   MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM Covid_deaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC


--6. Perecnt population fully vaccinated of each country ordering by the number of people fully vaccinated

Select Continent, Location, MAX(Population) AS Population, MAX(Total_people_fully_vaccinated) AS Total_people_fully_vaccinated,
	   ROUND(MAX(Total_people_fully_vaccinated)/MAX(Population)*100,2) AS Percent_population_vaccinated
From Global_table
Where Continent is not NULL
Group by Continent, Location
Order by Total_people_fully_vaccinated desc


-- 7.Total Cases vs Total Deaths (the likelihood of dying if you get Covid in each Country)

SELECT Location, 
	MAX(cast(total_cases as bigint)) AS TotalCasesCount, 
	MAX(CAST(total_deaths AS bigint)) AS TotalDeathCount, 
	MAX(ROUND(CAST(total_deaths AS bigint)/(total_cases)*100, 2)) AS DeathPercentage
FROM Covid_deaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY 4 DESC

