## Gehaelter im IT-Sektor

# setwd("IT")
IT <- read.csv("IT_Salary_Survey_2020.csv", na.strings = "")
Encoding(IT$City) <- "UTF-8"

alt <- c("Timestamp", "Age", "Gender", "City", "Position", "Experience", 
         "Experience_in_DE", "Seniority_Level", "Main_PL",
         "Other_PL", "Brutto", "Bonus", "Brutto_Same_Country", "Bonus_Same_Country",
         "Vacation_Days", "Employment_Status", "Contract_Duration", "Language_At_Work",
         "Company_Size", "Company_Type", "Corona_Job_Lost", "Corona_Shorter_Working_Week",
         "Corona_Monetary_Support")
names(IT) <- alt

### Negation von %in%
"%nin%" <- Negate("%in%")

IT$Timestamp <- strptime(IT$Timestamp, format = "%d/%m/%Y %H:%M:%S")


#bodensee und konstanz area wtf? welches land?
#bölingen in DE
# brunswick wahrscheinlihc nicht braunschweig sondern ausland
# prefer not to say nicht deutschland
# fr nicht deutschland
ausland <- c("London", "Vienna", "Moldova", "Moscow", "Warsaw", "Samara", "Riga, Latvia",
             "Zurich", "Helsinki", "Kiev", "Den Haag", "Amsterdam", "Cracovia", "Tallinn",
             "Prague", "Utrecht", "Stockholm", "Kyiv", "Malta", "Milan", "Salzburg",
             "Rome", "Wroclaw", "Cupertino", "Paris", "Dublin", "Barcelona", "Tampere (Finland)",
             "Bucharest", "Minsk", "Marseille", "Eindhoven", "France", "Warsaw, Poland",
             "City in Russia", "Cracow","Brunswick","Dublin ","Madrid","Lisbon","Sofia","Luttich",
             "Milano","Basel","NJ, USA","Istanbul","warsaw","Zürich", "Innsbruck", "Brussels" ,
             "Prefer not to say", "Fr","Cambridge" , "Brussels" ,
             "Copenhagen","Sevilla","Krakow" ,"Saint-Petersburg")

IT <- IT[IT$City %nin% ausland,]
## Auspraegung "Munich" als Muenchen
IT$City[IT$City == "Munich"] <- "München"
## Alle, die nicht München oder Berlin sind in Andere
IT$City[(IT$City != "Berlin") & (IT$City != "München")] <- "Andere"
L1 <- split(IT, IT$City)
Berlin <- L1$Berlin
Munich <- L1$München
Andere <- L1$Andere

## Auffaelligkeiten:
##  Teilweise Kommas als Dezimalzeichen
##  "1 (as QA Engineer) / 11 in total" -> Experience 11
##  "15, thereof 8 as CTO" -> Experience 15
##  "6 (not as a data scientist, but as a lab scientist)" -> Experience ?
##  "less than year" -> 0

IT$Experience[!is.na(IT$Experience) & 
                IT$Experience == "1 (as QA Engineer) / 11 in total"] <- 11
IT$Experience[!is.na(IT$Experience) & 
                IT$Experience == "15, thereof 8 as CTO"] <- 15
IT$Experience[!is.na(IT$Experience) & 
                IT$Experience == "6 (not as a data scientist, but as a lab scientist)"] <- 6
IT$Experience[!is.na(IT$Experience) & 
                IT$Experience == "less than year"] <- 0
IT$Experience <- gsub(",", ".", IT$Experience)
IT$Experience <- trunc(as.numeric(IT$Experience), digits = 0)
summary(IT$Experience)
