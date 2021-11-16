## Gehaelter im IT-Sektor

# setwd("IT")
IT <- read.csv("IT_Salary_Survey_2020.csv", na.strings = "")

alt <- c("Timestamp", "Age", "Gender", "City", "Position", "Experience", 
         "Experience_in_DE", "Seniority_Level", "Main_PL",
         "Other_PL", "Brutto", "Bonus", "Brutto_Same_Country", "Bonus_Same_Country",
         "Vacation_Days", "Employment_Status", "Contract_Duration", "Language_At_Work",
         "Company_Size", "Company_Type", "Corona_Job_Lost", "Corona_Shorter_Working_Week",
         "Corona_Monetary_Support")
names(IT) <- alt

