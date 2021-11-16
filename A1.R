
## Aufgabe 1 + nicht deutsche Städte

Sys.setlocale("LC_CTYPE", "german")

Encoding(IT$City) <- "UTF-8"

IT <- read.csv2("Mappe7.csv", na.strings = "", dec = ",")
names(IT)

sort(unique(IT$City))

### Negation von %in%
"%nin%" <- Negate("%in%")

str(IT)
anyNA(IT$Gender)
unique(IT$Gender)

andere_all <- IT$City[IT$City %nin% c("Berlin", "Munich")] 


#bodensee und konstanz area wtf? welches land?
#bölingen in DE
# brunswick wahrscheinlihc nicht braunschweig sondern ausland
# prefer not to say nicht deutschland
# fr nicht deutschland
unique(andere_all)
ausland <- c("London", "Vienna", "Moldova", "Moscow", "Warsaw", "Samara", "Riga, Latvia",
             "Zurich", "Helsinki", "Kiev", "Den Haag", "Amsterdam", "Cracovia", "Tallinn",
             "Prague", "Utrecht", "Stockholm", "Kyiv", "Malta", "Milan", "Salzburg",
             "Rome", "Wroclaw", "Cupertino", "Paris", "Dublin", "Barcelona", "Tampere (Finland)",
             "Bucharest", "Minsk", "Marseille", "Eindhoven", "France", "Warsaw, Poland",
             "City in Russia", "Cracow","Brunswick","Dublin ","Madrid","Lisbon","Sofia","Luttich",
             "Milano","Basel","NJ, USA","Istanbul","warsaw","Zürich", "Innsbruck", "Brussels" ,
             "Prefer not to say", "Fr","Cambridge" , "Brussels" ,
             "Copenhagen","Sevilla","Krakow" ,"Saint-Petersburg")

andere_DE <- andere_all[andere_all %nin% ausland]
andere_ausland  <- andere_all[andere_all %in% ausland]

unique(andere_DE)              

IT_city = IT

IT_city$City[IT_city$City %in% andere_ausland] <- "ausland"
IT_city$City[IT_city$City %in% andere_DE] <- "andere"
unique(IT_city$City)

IT_city$Brutto <- as.numeric(IT_city$Brutto)

city_split <- split(IT_city, IT_city$City)

city_Berlin <- city_split$Berlin
city_Munich <- city_split$Munich
city_andere <- city_split$andere

brutto_Berlin <- city_Berlin$Brutto
brutto_Munich <- city_Munich$Brutto
brutto_andere <- city_andere$Brutto

shapiro.test(brutto_Berlin)