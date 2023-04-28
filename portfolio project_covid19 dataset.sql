Select *
FROM [portfolio project].[dbo].['covid deaths$']
Where continent is not null 
order by 3,4

Select Location, date, total_cases, new_cases, total_deaths, population
FROM [portfolio project].[dbo].['covid deaths$']
Where continent is not null 
order by 1,2



ALTER TABLE PortfolioProject..CovidDeaths
ALTER COLUMN total_cases INT;
ALTER COLUMN total_deaths INT;
Select cd.Location, cd.date, total_cases,total_deaths, ((total_deaths / total_cases) * 100 )as DeathPercentage
FROM [portfolio project].[dbo].['covid deaths$'] as cd,[portfolio project].[dbo].['covid vaccs$'] as cv
Where cd.location like '%states%'
and cd.continent is not null 
order by 1,2

SELECT 
    Location, 
    Date, 
    total_cases, 
    total_deaths, 
    (CAST(total_deaths AS float) / CAST(total_cases AS float)) * 100 as DeathPercentage 
FROM [portfolio project].[dbo].['covid deaths$']

WHERE 
    Location LIKE '%states%' 
   -- AND continent IS NOT NULL 
ORDER BY 
    Location, 
    Date;


Select Location, date, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
FROM [portfolio project].[dbo].['covid deaths$']
--Where location like '%states%'
order by 1,2


Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
FROM [portfolio project].[dbo].['covid deaths$']
--Where location like '%states%'
Group by Location, Population
order by PercentPopulationInfected desc


Select Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
FROM [portfolio project].[dbo].['covid deaths$']
--Where location like '%states%'
Where continent is not null 
Group by Location
order by TotalDeathCount desc


Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
FROM [portfolio project].[dbo].['covid deaths$']
--Where location like '%states%'
Where continent is not null 
Group by continent
order by TotalDeathCount desc

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
FROM [portfolio project].[dbo].['covid deaths$']
--Where location like '%states%'
where continent is not null 
--Group By date
order by 1,2



Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
FROM [portfolio project].[dbo].['covid deaths$'] dea
Join [portfolio project].[dbo].['covid vaccs$'] vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3

ALTER TABLE [portfolio project].[dbo].['covid vaccs$'] ADD new_vaccinations INT;



Create View PercentPopulationVaccinated1 as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
FROM [portfolio project].[dbo].['covid deaths$'] dea
Join [portfolio project].[dbo].['covid vaccs$'] vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null


select * from PercentPopulationVaccinated1