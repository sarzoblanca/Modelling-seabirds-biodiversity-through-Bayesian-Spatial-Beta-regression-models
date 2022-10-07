
#Read libraries
library(raster)
library(rgdal)
library(sdmpredictors)
library(leaflet)

#####################################
# Environmental variables          
######################################

setwd("~/AATo_COPY/Collaborations/Med_mia/Blanca/Environmental_variables")

# rugosity2 = raster("rugosity.asc")

## Otra opcion (el raster parece corrupto)
bathy <- load_layers("BO_bathymean")

rugosity <- terrain(bathy[[1]],opt="roughness",unit="degrees",neighbors = 8)

# list layer codes for Bio-ORACLE and MARSPEC
# Paquete para descargarte variables 
list_layers(c("Bio-ORACLE","MARSPEC"))$layer_code

calcite<- load_layers("BO_calcite") 
calcite <- crop(calcite, med2)
calcite=crop(calcite, rugosity)
calcite=resample(calcite, rugosity)
calcite=mask(calcite, rugosity)

par<-load_layers("BO_parmean")#Photosynt. Avail. Radiation	E.m-2.day-1
par=crop(par, rugosity)
par=resample(par, rugosity)
par=mask(par, rugosity)

ph<-load_layers("BO_ph")
ph=crop(ph, rugosity)
ph=resample(ph, rugosity)
ph=mask(ph, rugosity)

chl_ss<- load_layers("BO2_chlomean_ss")#clorofila superficial
chl_ss=crop(chl_ss, rugosity)
chl_ss=resample(chl_ss, rugosity)
chl_ss=mask(chl_ss, rugosity)


chl_bot<- load_layers("BO2_chlomean_bdmean")#clorofila del fondo
chl_bot=crop(chl_bot, rugosity)
chl_bot=resample(chl_bot, rugosity)
chl_bot=mask(chl_bot, rugosity)

pp_ss <- load_layers("BO2_ppmean_ss") #producion primaria superficial in	g.m-3.day-1
pp_ss=crop(pp_ss, rugosity)
pp_ss=resample(pp_ss, rugosity)
pp_ss=mask(pp_ss, rugosity)

pp_bot <- load_layers("BO2_pprange_bdmean") #producion primaria del fondo in 	g.m-3.day-1
pp_bot=crop(pp_bot, rugosity)
pp_bot=resample(pp_bot, rugosity)
pp_bot=mask(pp_bot, rugosity)


oxig_ss<-load_layers("BO_dissox")#oxigeno disol superficial in	mol.m-3
oxig_ss=crop(oxig_ss, rugosity)
oxig_ss=resample(oxig_ss, rugosity)
oxig_ss=mask(oxig_ss, rugosity)


oxig_bot<-load_layers("BO2_dissoxmean_bdmean")#oxigeno disol del fondo in	mol.m-3
oxig_bot=crop(oxig_bot, rugosity)
oxig_bot=resample(oxig_bot, rugosity)
oxig_bot=mask(oxig_bot, rugosity)

nitrate_ss<-load_layers("BO2_nitratemean_ss")#nitratos superficilaes in 	mol.m-3
nitrate_ss=crop(nitrate_ss, rugosity)
nitrate_ss=resample(nitrate_ss, rugosity)
nitrate_ss=mask(nitrate_ss, rugosity)

nitrate_bot<-load_layers("BO2_nitratemean_bdmean")#nitratos del fondo in 	mol.m-3
nitrate_bot=crop(nitrate_bot, rugosity)
nitrate_bot=resample(nitrate_bot, rugosity)
nitrate_bot=mask(nitrate_bot, rugosity)

phosphate_ss<-load_layers("BO2_phosphatemean_ss")#fosfatos superficilaes in mol.m-3
phosphate_ss=crop(phosphate_ss, rugosity)
phosphate_ss=resample(phosphate_ss, rugosity)
phosphate_ss=mask(phosphate_ss, rugosity)

phosphate_bot <-load_layers("BO2_phosphatemean_bdmean")#fosfatos del fondo in mol.m-3
phosphate_bot=crop(phosphate_bot, rugosity)
phosphate_bot=resample(phosphate_bot, rugosity)
phosphate_bot=mask(phosphate_bot, rugosity)

sss<-load_layers("BO_salinity")#salinidad superficial in PSS
sss=crop(sss, rugosity)
sss=resample(sss, rugosity)
sss=mask(sss, rugosity)

sbt<-load_layers("BO2_salinitymean_bdmean")#salinidad del fondo in ?PSS
sbt=crop(sbt, rugosity)
sbt=resample(sbt, rugosity)
sbt=mask(sbt, rugosity)

#iron_ss<-load_layers("BO2_ironmean_ss" )#hierro superficial
#iron_ss=crop(iron_ss, rugosity)
#iron_ss=resample(iron_ss, rugosity)
#iron_ss=mask(iron_ss, rugosity)

iron_bot<-load_layers("BO2_ironmean_bdmean") #hierro del fondo
iron_bot=crop(iron_bot, rugosity)
iron_bot=resample(iron_bot, rugosity)
iron_bot=mask(iron_bot, rugosity)

silicate_ss<-load_layers("BO2_silicatemean_ss")
silicate_ss=crop(silicate_ss, rugosity)
silicate_ss=resample(silicate_ss, rugosity)
silicate_ss=mask(silicate_ss, rugosity)

silicate_bot<-load_layers("BO2_silicatemean_bdmean")
silicate_bot=crop(silicate_bot, rugosity)
silicate_bot=resample(silicate_bot, rugosity)
silicate_bot=mask(silicate_bot, rugosity)


sst<-load_layers("BO2_tempmean_ss")#temperatura superficial in 	?C
sst=crop(sst, rugosity)
sst=resample(sst, rugosity)
sst=mask(sst, rugosity)

sbt<- load_layers("BO2_tempmean_bdmean") #temperatura del fondo in 	?C
sbt=crop(sbt, rugosity)
sbt=resample(sbt, rugosity)
sbt=mask(sbt, rugosity)

phyt_ss<- load_layers("BO2_carbonphytomean_ss")#Phytoplankton superficial	in umol.m-3
phyt_ss=crop(phyt_ss, rugosity)
phyt_ss=resample(phyt_ss, rugosity)
phyt_ss=mask(phyt_ss, rugosity)

phyt_bot<- load_layers("BO2_carbonphytomean_bdmean")
phyt_bot=crop(phyt_bot, rugosity)
phyt_bot=resample(phyt_bot, rugosity)
phyt_bot=mask(phyt_bot, rugosity)


#fisicas
bathy<-load_layers("BO_bathymean")
bathy=crop(bathy, rugosity)
bathy=resample(bathy, rugosity)
bathy=mask(bathy, rugosity)

aspE<-load_layers("MS_biogeo01_aspect_EW_5m")
aspE=crop(aspE, rugosity)
aspE=resample(aspE, rugosity)
aspE=mask(aspE, rugosity)

aspN<-load_layers("MS_biogeo02_aspect_NS_5m")
aspN=crop(aspN, rugosity)
aspN=resample(aspN, rugosity)
aspN=mask(aspN, rugosity)

curv<-load_layers("MS_biogeo03_plan_curvature_5m")
curv=crop(curv, rugosity)
curv=resample(curv, rugosity)
curv=mask(curv, rugosity)

dist<-load_layers("MS_biogeo05_dist_shore_5m")
dist=crop(dist, rugosity)
dist=resample(dist, rugosity)
dist=mask(dist, rugosity)

slope<-load_layers("MS_biogeo06_bathy_slope_5m")
slope=crop(slope, rugosity)
slope=resample(slope, rugosity)
slope=mask(slope, rugosity)

concavity<-load_layers("MS_biogeo07_concavity_5m")
concavity=crop(concavity, rugosity)
concavity=resample(concavity, rugosity)
concavity=mask(concavity, rugosity)


predictors=stack(calcite,par, ph, chl_ss, chl_bot, pp_ss,pp_bot,oxig_ss, oxig_bot,nitrate_ss, nitrate_bot,
                 phosphate_ss,phosphate_bot,sss,sbt,iron_bot,silicate_ss,silicate_bot,sst,sbt,phyt_ss,phyt_bot,
                bathy,aspE,aspN,curv,dist,slope,concavity, rugosity)
names(predictors)=c("calcite","par","ph","chl_ss","chl_bot","pp_ss","pp_bot","oxig_ss", "oxig_bot","nitrate_ss", "nitrate_bot",
                    "phosphate_ss","phosphate_bot","sss","sbt","iron_bot","silicate_ss","silicate_bot",
                    "sst","sbt","phyt_ss","phyt_bot","bathy","aspE","aspN",
                    "curv","dist","slope","concavity", "rugosity")

# Generate a nice color ramp and plot the map 
# my.colors = colorRampPalette(c("#5E85B8","#EDF0C0","#C13127")) 
# plot(predictors,col=my.colors(1000),axes=FALSE, box=FALSE) 

#Read explicative antropological variables
# Se las pasa Marta
AIS= raster("~/MEGA/MEGAsync/Med_mia/Blanca/Antropological_variables/ais.asc")#from jrc
costal_impact=raster("~/MEGA/MEGAsync/Med_mia/Blanca/Antropological_variables/costal_impact.asc")
climate_changes=raster("~/MEGA/MEGAsync/Med_mia/Blanca/Antropological_variables/climate_changes.asc")
exploited_fisheries=raster("~/MEGA/MEGAsync/Med_mia/Blanca/Antropological_variables/exploited_fisheries.asc")
marine_activities=raster("~/MEGA/MEGAsync/Med_mia/Blanca/Antropological_variables/marine_activities.asc")
pollution=raster("~/MEGA/MEGAsync/Med_mia/Blanca/Antropological_variables/pollution.asc")
trawling=raster("~/MEGA/MEGAsync/Med_mia/Blanca/Antropological_variables/trawling.asc")

impacts=stack(costal_impact, climate_changes, exploited_fisheries, marine_activities, pollution, trawling, AIS)

# Generate a nice color ramp and plot the map 
# my.colors = colorRampPalette(c("#5E85B8","#EDF0C0","#C13127")) 
# plot(impacts,col=my.colors(1000),axes=FALSE, box=FALSE) 


#read response variable
#setwd("C:/Users/grazia.pennino/Dropbox/MedBiodiversity2012/nativefish_noexotic/nativefish_noexotic")
#data <- readOGR(dsn = ".", layer = "grid_cleaned")
#data
#data=as.data.frame(data)
#write.csv(data,"data.csv")




