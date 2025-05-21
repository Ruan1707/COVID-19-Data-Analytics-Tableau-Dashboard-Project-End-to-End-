# 🧪 COVID-19 Data Analytics & Power BI Dashboard Project (End-to-End)

## 📌 Project Overview

This end-to-end data analytics project explores global COVID-19 trends using **SQL for data analysis** and **Power BI for visualization**. It covers:

- 🔄 Data cleaning and transformation
- 📈 Analysis of infection, mortality, and vaccination rates
- 🌍 Comparison of infection rates to population across countries
- 📊 Visual storytelling using interactive dashboards

---

## 🛠 Tools & Technologies Used

- **SQL** (MySQL / PostgreSQL / SQL Server) – Data cleaning, transformation, and querying
- **Power BI** – Dashboard creation and data visualization
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

## 📊 Power BI Dashboard

Key visualizations include:
- 🌍 Global infection and death trends over time
- 📌 Countries with the highest infection and death rates
- 💉 Vaccination progress by country
- 🧮 Comparison of infection % vs population and vaccination %

> 📸 *(Optional)*:  
> ![Dashboard Preview](visuals/Covid-DashBoard-Project-1.jpg)

---

## 📌 Conclusion

This project provides end-to-end insights into:
- The spread and severity of COVID-19 globally
- Country-level comparisons of cases, deaths, and population impact
- Progress and effectiveness of vaccination campaigns

It showcases the power of SQL for deep data exploration and Tableau for effective visual communication.

---

## 📜 Author & Acknowledgements

👤 **Created by:** [Ruan Badenhorsty]  
📚 **Inspired by:** [Alex The Analyst](https://www.youtube.com/c/AlexTheAnalyst) – SQL & Data Analytics Project Series  
💻 **Tools Used:** MySQL, Tableau, Excel  
🔗 Connect with me on [LinkedIn](https://www.linkedin.com) *(http://linkedin.com/in/ruan-badenhorst-rb17)* or explore more on my [Portfolio](https://ruan1707.github.io/RuanBadenhorst.github.io/)

---

