install.packages("readr")
install.packages("ggmap")
install.packages("plotly")
install.packages("gmapsdistance")

library(readr)
library(dplyr)
library(ggmap)
library(ggplot2)
library(tidyverse)
library(stringi)
library(ggtern)
library(plotly)


#wczytywanie plikow
options(stringsAsFactors = FALSE) 
setwd("D:/OneDrive - Szkoła Główna Handlowa w Warszawie/Polibuda/semestr2/pdu/praca3/202204-citibike-tripdata.csv")
df1 <- read.csv("202203-citibike-tripdata.csv")
df2 <- read.csv("202204-citibike-tripdata.csv")
df3 <- read.csv("202202-citibike-tripdata.csv")
crime <- read.csv("NYPD_Complaint_Data_Current__Year_To_Date_.csv")

#pobranie danych z ramki danych crime które dotyczyły kradzieżt roweróW
larceny <- crime[crime$PD_DESC == "LARCENY,PETIT OF BICYCLE" | crime$PD_DESC == "LARCENY,GRAND OF BICYCLE" ,]
larceny <- larceny[, c("PD_DESC", "Latitude", "Longitude" )]
larceny <- larceny[sample(nrow(larceny),500),] #losowe 500 wierszy
rownames(larceny) <- NULL


#laczenie danych z ostanich trzech miesiecy
df <- full_join(df1,df2)
df <- full_join(df, df3)

#tworzenie ramki danbych ze stacjami z których znikają rowery
znikajace <- df[df$end_station_name == "" & df$start_station_name != '',]
znikajace <- znikajace[,c("start_station_name", "start_lng", "start_lat")]
nawiedzone_stacje <- count(znikajace, start_station_name) 
nawiedzone_stacje <- arrange(nawiedzone_stacje, desc(n))
polaczenie <- inner_join(nawiedzone_stacje, znikajace,  by = "start_station_name", keep = FALSE)
polaczenie <- arrange(polaczenie, desc(n))
top50 <- unique.data.frame(polaczenie, incomparables = FALSE)
top50 <- top50[1:50,] #top20 stacji z których po wystartowaniu znikają rowery 

bbox <- make_bbox(Longitude, Latitude, data = larceny)



#mapa miejsc w których dokonano kradzieży roweróW 
mapa <- ggmap(get_stamenmap(bbox, zoom = 10, maptype = "toner-lite", color = 'color')) +
  geom_point(data = larceny, aes(x=Longitude, y=Latitude),color = "blue", size = 1)+
  # Od tego miejsca ci dodałem kilka rzeczy do tej mapy-Mikołajk
  stat_density2d( data = larceny, aes(x=Longitude, y=Latitude,fill=after_stat(level),alpha=0.1),
      geom = "polygon") +scale_fill_continuous(type = "viridis")+
  geom_point(data = top50, aes(x=start_lng, y=start_lat, size = n), color = "red")+
  scale_size(range = c(0,5))+labs(n="Ilość skradzionych rowerów")+ guides(alpha="none",level="none")
mapa
scale_fill_continuous()

#rózny rozmiar tych punktóW z ktorych najczesciej znikają 
mapa3 <- ggmap(get_stamenmap(bbox, zoom = 10, maptype = 'terrain', color = "color")) +
  geom_point(data = top50, aes(x=start_lng, y=start_lat, size = n), color = "red")+
  scale_size(range = c(0,5))
mapa3

#różny kolor tych punktow z ktorychb najczęsciej znikają 
mapa4 <- ggmap(get_stamenmap(bbox, zoom = 10, maptype = 'terrain', color = "color")) +
  geom_point(data = top50, aes(x=start_lng, y=start_lat, color = n), size = 2)+
  scale_color_gradient(high = "red", low = "green")
mapa4

