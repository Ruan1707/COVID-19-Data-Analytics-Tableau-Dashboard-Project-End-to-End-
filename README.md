COVID-19 Data Exploration Project
📌 Project Overview
This project involves data exploration using SQL to analyze COVID-19 data. It covers:
✅ Data cleaning and transformation
✅ Analyzing infection and mortality rates
✅ Comparing infections to population
✅ Examining global and country-specific trends
✅ Evaluating vaccination progress

🛠 Tools Used
SQL (MySQL / PostgreSQL / SQL Server) – Data cleaning & analysis

Excel / Tableau / Power BI – Data visualization (optional)

📂 Dataset
The dataset contains COVID-19 case statistics, including:
✅ Daily infection and death counts
✅ Population details by country
✅ Vaccination data

📥 Download the dataset (if applicable, provide a link)

🔍 Key SQL Queries & Insights
1️⃣ Data Preparation
Before analysis, a duplicate table covid_deaths1 was created to ensure data integrity:

sql
Copy
Edit
CREATE TABLE covid_deaths1 LIKE coviddeaths;
INSERT covid_deaths1 SELECT * FROM coviddeaths;
DELETE FROM covid_deaths1 WHERE continent = '';
📌 Insight: A clean dataset ensures accurate analysis.

2️⃣ Total Cases vs. Total Deaths
sql
Copy
Edit
SELECT Location, `date`, total_cases, total_deaths, 
       total_deaths * 100 / total_cases AS percentage_deathstocases
FROM covid_deaths1 
WHERE Location LIKE 'South Africa';
📌 Insight: Helps determine how deadly the virus was in South Africa.

3️⃣ Total Cases vs. Population
sql
Copy
Edit
SELECT Location, `date`, total_cases, population, total_deaths, 
       total_cases * 100 / population AS percentage_casesperpopulation
FROM covid_deaths1
WHERE Location LIKE 'South Africa';
📌 Insight: Assesses the percentage of the population infected over time.

4️⃣ Countries with the Highest Infection Rates
sql
Copy
Edit
SELECT Location, population, MAX(CAST(total_cases AS DECIMAL)) AS HighestInfCount
FROM covid_deaths1
GROUP BY Location, population
ORDER BY HighestInfCount DESC;
📌 Insight: Identifies which countries had the highest number of infections.

5️⃣ Countries with the Highest Death Count per Population
sql
Copy
Edit
SELECT Location, population, 
       MAX(CAST(total_deaths AS DECIMAL)) AS HighestdeathCount, 
       MAX((total_deaths * 100 / population)) AS percentage_populationdeaths
FROM covid_deaths1
WHERE continent IS NOT NULL
GROUP BY Location, population
ORDER BY percentage_populationdeaths DESC;
📌 Insight: Highlights the countries with the highest mortality rates.

6️⃣ Global Daily COVID-19 Trends
sql
Copy
Edit
SELECT `date`, SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, 
       SUM(new_deaths) * 100 / SUM(new_cases) AS death_percentage
FROM covid_deaths1 
WHERE Continent IS NOT NULL
GROUP BY `date`
ORDER BY `date`;
📌 Insight: Shows the overall trend of cases and deaths over time.

7️⃣ Population Adjustment (Subtracting Deaths)
sql
Copy
Edit
WITH population_calc AS (
    SELECT continent, location, `date`, population, total_deaths, 
           SUM(CAST(total_deaths AS DECIMAL)) OVER (PARTITION BY location ORDER BY location, `date`) AS rolling_death
    FROM covid_deaths1 
    WHERE continent IS NOT NULL
)
SELECT *, (population - rolling_death) AS new_population
FROM population_calc;
📌 Insight: Adjusts the population count based on recorded deaths.

8️⃣ Vaccination Progress Analysis
sql
Copy
Edit
WITH PopvsVac AS (
    SELECT dea.continent, dea.location, dea.`date`, vac.new_vaccinations, dea.population, 
           SUM(CAST(vac.new_vaccinations AS DECIMAL)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.`date`) AS rolling_vac
    FROM covid_deaths1 AS dea
    JOIN covid_vaccinations1 AS vac
    ON dea.location = vac.location AND dea.`date` = vac.`date`
    WHERE dea.continent IS NOT NULL
)
SELECT *, rolling_vac * 100 / population AS percentagepopvac
FROM PopvsVac;
📌 Insight: Tracks the percentage of the population vaccinated over time.

9️⃣ Creating a View for Future Use
sql
Copy
Edit
CREATE VIEW VIEWPERCENTPOPOLATIONVACCINATED AS
SELECT dea.continent, dea.location, dea.`date`, dea.population, vac.new_vaccinations, 
       SUM(CAST(vac.new_vaccinations AS DECIMAL)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.`date`) AS rolling_vac
FROM covid_deaths1 AS dea
JOIN covid_vaccinations1 AS vac
ON dea.location = vac.location AND dea.`date` = vac.`date`
WHERE dea.continent IS NOT NULL;
📌 Insight: Creates a view to store vaccination data for easy future analysis.

📊 Dashboard & Visuals
🖼 Tableau/Power BI Dashboard (Insert a link if available)
Key visualizations:
✅ Global infection trends
✅ Countries with the highest death rates
✅ Vaccination progress analysis

🚀 How to Use This Project
1️⃣ Run the SQL queries in MySQL/PostgreSQL/SQL Server.
2️⃣ Analyze trends using the query outputs.
3️⃣ Use the view VIEWPERCENTPOPOLATIONVACCINATED for easier data visualization.
4️⃣ Create visualizations in Tableau, Power BI, or Excel.

📌 Conclusion
The analysis provides valuable insights into COVID-19 trends and vaccine distribution.

Countries with high infection and mortality rates are identified for further investigation.

Vaccination data helps assess global progress and policy effectiveness.

📜 Author & Acknowledgments
👤 Alex the Analyst (Adapted from Alex’s Project Series)
