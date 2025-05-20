# 🧪 COVID-19 Data Analytics & Tableau Dashboard Project (End-to-End)

## 📌 Project Overview

This end-to-end data analytics project explores global COVID-19 trends using **SQL for data analysis** and **Tableau for visualization**. It covers:

- 🔄 Data cleaning and transformation
- 📈 Analysis of infection, mortality, and vaccination rates
- 🌍 Comparison of infection rates to population across countries
- 📊 Visual storytelling using interactive dashboards

---

## 🛠 Tools & Technologies Used

- **SQL** (MySQL / PostgreSQL / SQL Server) – Data cleaning, transformation, and querying
- **Tableau** – Dashboard creation and data visualization
- **Excel** (optional) – Data exports and simple charts

---

## 📂 Dataset

Includes:

- ✅ Daily COVID-19 case and death statistics
- ✅ Country population data
- ✅ Vaccination data per country

---

## 🔍 Key SQL Queries & Insights

### ✅ Data Cleaning & Preparation
```sql
CREATE TABLE covid_deaths1 LIKE coviddeaths;
INSERT covid_deaths1 SELECT * FROM coviddeaths;
DELETE FROM covid_deaths1 WHERE continent = '';
