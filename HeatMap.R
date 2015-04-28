library(maps)
library(ggmap)
library(ggplot2)

## Read in motor vehicle theft data
mvt <- read.csv("mvt.csv", stringsAsFactors=FALSE)

## Retrieve Chicago map for the base of the heat map
chicago <- get_map(location = "chicago", zoom=11)

## Generate new data frame from the table of Latitude and Longitude (both rounded
## to 2 decimal places) by Frequency
LatLonCounts <- as.data.frame(table(round(mvt$Longitude,2), 
     round(mvt$Latitude, 2)))

## Coerce long and lat variables from LatLonCounts dataframe to numeric
LatLonCounts$Long <- as.numeric(as.character(LatLonCounts$Var1))
LatLonCounts$Lat <- as.numeric(as.character(LatLonCounts$Var2))

## Remove coordinates where Freq = 0
LatLonCounts <- subset(LatLonCounts, Freq > 0)

## Generate heat map using ggmap overlayed with geom_tile
ChicagoCarTheftHeatMap <- ggmap(chicago) + geom_tile(data=LatLonCounts, 
       aes(x = Long, y = Lat, alpha = Freq), fill="red"

## Store heat map as a pdf
pdf("Chicago Car Theft Heat Map")
print(ChicagoCarTheftHeatMap)
dev.off()
