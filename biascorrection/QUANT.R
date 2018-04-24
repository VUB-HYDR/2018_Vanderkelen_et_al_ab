# Script to load evaluation data from matlab
# and to apply a bias correction

# Add package
library(MASS)
library(fitdistrplus)
library(survival)
library(qmap)


# set working directory
setwd("~/R/scripts/data")


# read csv files
E_wb_histobs <- read.csv("E_wb_histobs.csv", header=FALSE)   
P_wb_histobs <- read.csv("P_wb_histobs.csv", header=FALSE)   
Qin_wb_histobs <- read.csv("Qin_wb_histobs.csv", header=FALSE)   
E_wb_obs <- read.csv("E_wb_obs.csv", header=FALSE)   
P_wb_obs <- read.csv("P_wb_obs.csv", header=FALSE)   
Qin_wb_obs <- read.csv("Qin_wb_obs.csv", header=FALSE)   

#initialise bc data
bcdata <-E_wb_histobs

# initialise number of simulations
nm = ncol(P_wb_histobs)


# ---------------------------------------------------------------------------
# Precipitation

obsdata<- P_wb_obs
moddata <-P_wb_histobs

qm_P <- list()

for (i in 1:nm){
  obs<- obsdata[,1]
  mod <- moddata[,i]
  
  # Perform biascorrection
  
  qm.fit <- fitQmapQUANT(obs,mod,
                         qstep=0.1,nboot=1,wet.day=TRUE)
  qm.a <- doQmapQUANT(mod,qm.fit)
  
  bcdata[,i] <- qm.a
  
  # save qm object in list file
  qm_P[[i]]<-qm.fit
}

# wite bc data to csv
write.csv(bcdata, file = "QUANT/P_wb_histobs_bc.csv",row.names=FALSE,col.names=NULL)

# ---------------------------------------------------------------------------
# Evaporation

obsdata<- E_wb_obs
moddata <-E_wb_histobs

qm_E <- list()

for (i in 1:nm){
  obs<- obsdata[,1]
  mod <- moddata[,i]
  
  # Perform biascorrection
  
  qm.fit <- fitQmapQUANT(obs,mod,
                         qstep=0.1,nboot=1,wet.day=TRUE)
  qm.a <- doQmapQUANT(mod,qm.fit)
  
  bcdata[,i] <- qm.a
  qm_E[[i]]<-qm.fit
  
}

# wite bc data to csv
write.csv(bcdata, file = "QUANT/E_wb_histobs_bc.csv",row.names=FALSE,col.names=NULL)

# ---------------------------------------------------------------------------
# Inflow

qm_Qin <- list()

obsdata<- Qin_wb_obs
moddata <-Qin_wb_histobs

for (i in 1:nm){
  obs<- obsdata[,1]
  mod <- moddata[,i]
  
  
  # Perform biascorrection
  
  qm.fit <- fitQmapQUANT(obs,mod,
                         qstep=0.1,nboot=1,wet.day=TRUE)
  
  qm.a <- doQmapQUANT(mod,qm.fit)
  
  bcdata[,i] <- qm.a
  qm_Qin[[i]]<-qm.fit
  
}

# wite bc data to csv
write.csv(bcdata, file = "QUANT/Qin_wb_histobs_bc.csv",row.names=FALSE,col.names=NULL)

# --------------------------------------------------------------------------
# Load hist data 

E_wb_hist <- read.csv("E_wb_hist.csv", header=FALSE)   
P_wb_hist <- read.csv("P_wb_hist.csv", header=FALSE)   
Qin_wb_hist <- read.csv("Qin_wb_hist.csv", header=FALSE)   
# initialise bc data
bcdata <-E_wb_hist


# ---------------------------------------------------------------------------
# Precipitation

moddata <-P_wb_hist

for (i in 1:nm){
  mod <- moddata[,i]
  
  # Perform biascorrection
  qm.fit<-qm_P[[i]]
  qm.a <- doQmapQUANT(mod,qm.fit)
  
  bcdata[,i] <- qm.a
}

# wite bc data to csv
write.csv(bcdata, file = "QUANT/P_wb_hist_bc.csv",row.names=FALSE,col.names=NULL)

# ---------------------------------------------------------------------------
# Evaporation

moddata <-E_wb_hist


for (i in 1:nm){
  mod <- moddata[,i]
  qm.fit<-qm_E[[i]]
  
  # Perform biascorrection
  qm.a <- doQmapQUANT(mod,qm.fit)  
  bcdata[,i] <- qm.a
}

# wite bc data to csv
write.csv(bcdata, file = "QUANT/E_wb_hist_bc.csv",row.names=FALSE,col.names=NULL)

# ---------------------------------------------------------------------------
# Inflow

moddata <-Qin_wb_hist

for (i in 1:nm){
  mod <- moddata[,i]
  qm.fit<-qm_Qin[[i]]
  
  qm.a <- doQmapQUANT(mod,qm.fit)  
  bcdata[,i] <- qm.a
}

# wite bc data to csv
write.csv(bcdata, file = "QUANT/Qin_wb_hist_bc.csv",row.names=FALSE,col.names=NULL)

# --------------------------------------------------------------------------
# Load rcp data 

# rcp26 -------------------------------------------------------------------
E_wb_rcp26 <- read.csv("E_wb_rcp26.csv", header=FALSE)   
P_wb_rcp26 <- read.csv("P_wb_rcp26.csv", header=FALSE)   
Qin_wb_rcp26 <- read.csv("Qin_wb_rcp26.csv", header=FALSE)   
id_rcp26<-c(9,16,15,13,17,18,20,21,23,24,25)

# initialise bc data
bcdata <-E_wb_rcp26
# initialise number of simulations
nm = ncol(P_wb_rcp26)

# ---------------------------------------------------------------------------
# Precipitation

moddata <-P_wb_rcp26
nm = ncol(P_wb_rcp26)

for (i in 1:nm){
  mod <- moddata[,i]
  
  # Perform biascorrection
  qm.fit<-qm_P[[id_rcp26[i]]]
  qm.a <- doQmapQUANT(mod,qm.fit)  
  bcdata[,i] <- qm.a
}

# wite bc data to csv
write.csv(bcdata, file = "QUANT/P_wb_rcp26_bc.csv",row.names=FALSE,col.names=NULL)

# ---------------------------------------------------------------------------
# Evaporation

moddata <-E_wb_rcp26


for (i in 1:nm){
  mod <- moddata[,i]
  
  # Perform biascorrection
  qm.fit<-qm_E[[id_rcp26[i]]]
  
  qm.a <- doQmapQUANT(mod,qm.fit)  
  bcdata[,i] <- qm.a
}

# wite bc data to csv
write.csv(bcdata, file = "QUANT/E_wb_rcp26_bc.csv",row.names=FALSE,col.names=NULL)

# ---------------------------------------------------------------------------
# Inflow

moddata <-Qin_wb_rcp26

for (i in 1:nm){
  mod <- moddata[,i]
  qm.fit<-qm_Qin[[id_rcp26[i]]]
  
  qm.a <- doQmapQUANT(mod,qm.fit)  
  bcdata[,i] <- qm.a
}

# wite bc data to csv
write.csv(bcdata, file = "QUANT/Qin_wb_rcp26_bc.csv",row.names=FALSE,col.names=NULL)




# RCP 45 ------------------------------------------------------------------------

E_wb_rcp45 <- read.csv("E_wb_rcp45.csv", header=FALSE)   
P_wb_rcp45 <- read.csv("P_wb_rcp45.csv", header=FALSE)   
Qin_wb_rcp45 <- read.csv("Qin_wb_rcp45.csv", header=FALSE)   
id_rcp45 <- c(1,	2,	3,	4,	5, 6, 7, 8,9,	10,	11,	12,	13,	14,	15,	16,	17,	18,	19,	21,22)

# initialise bc data
bcdata <-E_wb_rcp45
# initialise number of simulations
nm = ncol(P_wb_rcp45)

# ---------------------------------------------------------------------------
# Precipitation

moddata <-P_wb_rcp45
nm = ncol(P_wb_rcp45)

for (i in 1:nm){
  mod <- moddata[,i]
  qm.fit<-qm_P[[id_rcp45[i]]]
  
  # Perform biascorrection
  
  qm.a <- doQmapQUANT(mod,qm.fit)  
  bcdata[,i] <- qm.a
}

# wite bc data to csv
write.csv(bcdata, file = "QUANT/P_wb_rcp45_bc.csv",row.names=FALSE,col.names=NULL)

# ---------------------------------------------------------------------------
# Evaporation

moddata <-E_wb_rcp45


for (i in 1:nm){
  mod <- moddata[,i]
  qm.fit<-qm_E[[id_rcp45[i]]]
  
  # Perform biascorrection
  qm.a <- doQmapQUANT(mod,qm.fit)  
  bcdata[,i] <- qm.a
}

# wite bc data to csv
write.csv(bcdata, file = "QUANT/E_wb_rcp45_bc.csv",row.names=FALSE,col.names=NULL)

# ---------------------------------------------------------------------------
# Inflow

moddata <-Qin_wb_rcp45

for (i in 1:nm){
  mod <- moddata[,i]
  qm.fit<-qm_Qin[[id_rcp45[i]]]
  
  qm.a <- doQmapQUANT(mod,qm.fit)  
  bcdata[,i] <- qm.a
}

# wite bc data to csv
write.csv(bcdata, file = "QUANT/Qin_wb_rcp45_bc.csv",row.names=FALSE,col.names=NULL)

# RCP 85 ---------------------------------------------------------------------------------------

E_wb_rcp85 <- read.csv("E_wb_rcp85.csv", header=FALSE)   
P_wb_rcp85 <- read.csv("P_wb_rcp85.csv", header=FALSE)   
Qin_wb_rcp85 <- read.csv("Qin_wb_rcp85.csv", header=FALSE)

id_rcp85<-c(1,2,3,	4,	5,	9,	10,	11,	12,	13,	14,	15,	16,	17,	18,19,	21,	22,	23)
# initialise bc data
bcdata <-E_wb_rcp85
# initialise number of simulations
nm = ncol(P_wb_rcp85)

# ---------------------------------------------------------------------------
# Precipitation

moddata <-P_wb_rcp85
nm = ncol(P_wb_rcp85)

for (i in 1:nm){
  mod <- moddata[,i]
  qm.fit<-qm_P[[id_rcp85[i]]]
  
  # Perform biascorrection
  
  qm.a <- doQmapQUANT(mod,qm.fit)  
  bcdata[,i] <- qm.a
}

# wite bc data to csv
write.csv(bcdata, file = "QUANT/P_wb_rcp85_bc.csv",row.names=FALSE,col.names=NULL)

# ---------------------------------------------------------------------------
# Evaporation

moddata <-E_wb_rcp85


for (i in 1:nm){
  mod <- moddata[,i]
  qm.fit<-qm_E[[id_rcp85[i]]]
  
  # Perform biascorrection
  qm.a <- doQmapQUANT(mod,qm.fit)  
  bcdata[,i] <- qm.a
}

# wite bc data to csv
write.csv(bcdata, file = "QUANT/E_wb_rcp85_bc.csv",row.names=FALSE,col.names=NULL)

# ---------------------------------------------------------------------------
# Inflow

moddata <-Qin_wb_rcp85

for (i in 1:nm){
  mod <- moddata[,i]
  qm.fit<-qm_Qin[[id_rcp85[i]]]
  
  qm.a <- doQmapQUANT(mod,qm.fit)  
  bcdata[,i] <- qm.a
}

# wite bc data to csv
write.csv(bcdata, file = "QUANT/Qin_wb_rcp85_bc.csv",row.names=FALSE,col.names=NULL)


