# SQL | Power BI
# COVID’19 Data Exploration and Analysis
## Introduction
This project explores and analyzes the COVID-19 infection, death and vaccination rates all around the world using SQL and Power BI dashboard.
## Dataset
Covid-19 data from January 01, 2020, to January 30, 2023 from https://ourworldindata.org/covid-deaths
## Skills and Tools Used
SQL, MS SQL Server, Power Query Editor, Power BI, DAX
## Objectives
This was my first project and its main goal was to practice and showcase all the concepts I have learned so far in SQL and Power BI. I have answered the following questions in this project:

•	What are the global number of total Covid-19 cases and deaths, death percentage and percentage of fully vaccinated population?

•	What is the percentage of infected population per country?

•	What is the total number of deaths per continent and top 10 countries with the highest number of deaths?

•	Number of people fully vaccinated in comparison to the total population.

•	Which are the top 10 countries with highest number of people fully vaccinated?

## Development of the project

I imported the dataset into MS SQL and created three views containing the pertinent information on Covid deaths, vaccinations and the location. Then, these three views are imported into Power BI Desktop (PBI) and ETL process was done via Power Query.

To get the correct values about the covid deaths and vaccinations, I made use of  calculated columns and quick measures. At the end, I was able to create the dashboard answering the question presented above.
After completing the dashboard, I returned to SQL and created queries to answer the same questions in order to compare the results obtained in Power BI, which also served the purpose of developing my SQL skills.

## Findings (as of Jan 30, 2023)
•	Total Covid-19 cases across the world are 670 million and the total number of deaths is 7 million which makes the death percentage to be 1.02% i.e. there is a 1% percentage for someone to die if he/she catches Covid-19.

•	Among continents, Europe experienced the highest number of total infections as well as total deaths. The United States has the highest maximum number of deaths among all the countries followed by the United Kingdom, Russia, Peru, and Mexico, respectively.

•	The fully vaccinated rate of the world is 63.88% and Asia has the maximum percent of the population fully vaccinated at 72.58%. The top countries with fully vaccinated populations are China, India, and the United States.


