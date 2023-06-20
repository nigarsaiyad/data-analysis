use portfolioprojects;

select * from coviddeaths order by 3,4;

select * from coronavaccinations order by 3,4;

select location ,date,total_cases,new_cases,total_deaths,population_density 
from coviddeaths 
order by 1,2;

----total_cases vs total_deaths-----------

select location ,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as deathpercentage
from coviddeaths 
order by 1,2;

----------looking at population_density affecting total_deaths--------------------------


select location ,date,total_cases,total_deaths,(total_deaths/population_density)  as  persquareareapopulationinfected
from coviddeaths 
order by 1,2;

 alter table coviddeaths alter column total_deaths float ;

  alter table coviddeaths alter column total_cases float;

  
select location ,date,total_cases,total_deaths,population_density,(total_deaths/total_cases)*100 as deathpercentage
from coviddeaths 
where location like '%india%'
order by 1,2;

select location ,date,total_cases,total_deaths,(total_deaths/population_density)*100 as persquareareapopulationinfected
from coviddeaths 
where location like '%india%'
order by 1,2;

-------------countries with highestinfectioncount with respect to populationdensity---------------

select location,population_density,max(total_cases) as highestinfectioncount,
max((total_cases/population_density)) as persquareareapopulationinfected
from coviddeaths
group by location, population_density
order by persquareareapopulationinfected desc;

----------------looking at countries with highest deathcounts-------------

select location, max(total_deaths) as totaldeathcount from coviddeaths 
where continent is not null
group by location 
order by totaldeathcount desc;

-----------breaking down things by  continent----------

select continent, max(total_deaths) as totaldeathcount from coviddeaths 
where continent is not null
group by continent
order by totaldeathcount desc;

------------globalnumbers---------

select sum(new_cases) as totalcases,sum(new_deaths) as totaldeaths, nullif(sum(new_deaths),0)/ nullif(sum(new_cases),0)*100 as deathpercentage
from coviddeaths 
 where continent is not null
order by 1,2;

--------joining both tables on location and date------------

select * from coviddeaths dea
join coronavaccinations vac
on
dea.location=vac.location
and dea.date=vac.date;

--------LOOKING AT TOTALPOPULATION VS VACCINATION USING CTE--------------------------

with popvsvac  (continent,location,date,population,new_vaccinations,rollingpplvaccinated)
as
(select dea.continent,dea.location,dea.date,vac.population,vac.new_vaccinations,
sum(cast(vac.new_vaccinations as int) )over( partition by dea.location order by dea.location,dea.date) as rollingpplvaccinated
from coviddeaths dea
join coronavaccinations vac
on
dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null
)
select*,(rollingpplvaccinated/population)*100
from popvsvac;

---temp table------------------


drop table if exists percentpopvaccinated;

create table percentpopvaccinated
(continent nvarchar (255),location nvarchar(255),
date datetime,population numeric ,new_vaccinations numeric,
rollingpplvaccinated numeric);

insert into percentpopvaccinated
select dea.continent,dea.location,dea.date,vac.population,vac.new_vaccinations,
sum(cast(vac.new_vaccinations as int) )over( partition by dea.location order by dea.location,dea.date) as rollingpplvaccinated
from coviddeaths dea
join coronavaccinations vac
on
dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null

select*,(rollingpplvaccinated/population)*100
from percentpopvaccinated;

----creating view to store data for later visualization--------

create view 
percentpopvaccinated as
select dea.continent,dea.location,dea.date,vac.population,vac.new_vaccinations,
sum(cast(vac.new_vaccinations as int) )over( partition by dea.location order by dea.location,dea.date) as rollingpplvaccinated
from coviddeaths dea
join coronavaccinations vac
on
dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null;