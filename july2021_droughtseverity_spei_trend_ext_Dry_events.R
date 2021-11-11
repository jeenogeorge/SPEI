library(raster)
library(sp)
library(rgdal)
library(maptools)
library(rgeos)
library(dplyr)
library(ggplot2)
#import the raster file of the climate 
spei <- stack(("X:/XXXX/spei01.tif")) 

#finding SPEI01
parent.folder <- "X:/XXXXX/cities"
sub.folders <- list.dirs(parent.folder, recursive=F)[1:N]

sub.folders

# Run scripts in sub-folders 
for(i in sub.folders) {
  setwd(i)
  work_direc <- getwd()
  city_name <- unlist(strsplit(work_direc, split = "/", fixed = T))[5]
  city_name
  

  
  avg_ext_wet <- 200
  ext_wet_num <- 200
  ext_wet_index <- 200
  avg_sev_wet <- 200
  sev_wet_num <- 200
  sev_wet_index <- 200
  avg_mod_wet <- 200
  mod_wet_num <- 200
  mod_wet_index <- 200
  avg_nor_wet <- 200
  nor_wet_num <- 200
  nor_wet_index <- 200
  avg_mod_drt <- 200
  mod_drt_num <- 200
  mod_drt_index <- 200
  avg_sev_drt <- 200
  sev_drt_num <- 200
  sev_drt_index <- 200
  avg_ext_drt <- 200
  ext_drt_num <- 200
  ext_drt_index <- 200

#import the study area

#study area
city_area <- readOGR(dsn = sprintf("XXXX/cities/%s",city_name), layer = "studyarea")

spei_crop <- crop(spei, city_area, snap = "near")

spei_crop[]
dim(spei_crop[])
plot(spei_crop)

spei_crop[][spei_crop[]<=-1.5]

nlayers(spei_crop)
spei_crop
time <- names(spei_crop)[spei_crop[]<=-1.5]
time <- na.omit(time)
time <- read.table(text = time, sep = ".", as.is = T)$V2
class(time)
t_51 <- sum(time[]<120)
t_61 <- sum(time[] >=120 & time[] < 240)
t_71 <- sum(time[] >=240 & time[] < 360)
t_81 <- sum(time[] >=360 & time[] < 480)
t_91 <- sum(time[] >=480 & time[] < 600)
t_01 <- sum(time[] >=600 & time[] < 720)
t_11 <- sum(time[] >=720 & time[] < 840)
t_21 <- sum(time[] >=840)

trend_db_dry_events <- data.frame(name = city_name, t_51 = t_51,
                       t_61 = t_61,
                       t_71 = t_71,
                       t_81 = t_81,
                       t_91 = t_91,
                       t_01 = t_01,
                       t_11 = t_11,
                       t_21 = t_21)
                    
write.table(trend_db_dry_events, file = 'X:/XXXX/trend_db_dry_events', 
            append = T, sep = '\t', row.names = F, col.names = F)
}
