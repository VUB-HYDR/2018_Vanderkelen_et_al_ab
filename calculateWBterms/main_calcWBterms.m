% -----------------------------------------------------------------------
% main script to calculate WB terms for historical, and future CORDEX
% simulations according to RCP 2.6, RCP 4.5 and RCP 8.5
% -----------------------------------------------------------------------

clear all
clc

% Load variables (independent from main) 
flag_run = 5;

load mask_basin
load mask_lake
load CN

% load RCMsimulation names
if flag_run == 3 % historical
RCM(:,1) = [{'CCLM4-8-17_'}; {'CCLM4-8-17_'}; {'CCLM4-8-17_'}; {'CCLM4-8-17_'};  {'CRCM5_'}     ; {'CRCM5_'} ;  {'HIRHAM5_'} ; {'RACMO22T_'}; {'RACMO22T_'} ;  {'RCA4_'}  ; {'RCA4_'}  ; {'RCA4_'}   ; {'RCA4_'}   ; {'RCA4_'}     ; {'RCA4_'}     ; {'RCA4_'} ; {'RCA4_'}     ; {'RCA4_'}     ; {'RCA4_'}         ; {'REMO2009_'}  ; {'REMO2009_'}  ; {'REMO2009_'} ; {'REMO2009_'} ; {'REMO2009_'}  ; {'REMO2009_'}];
GCM(:,1) = [{'CNRM-CM5'}   ; {'EC-EARTH'}   ; {'HadGEM2-ES'} ; {'MPI-ESM-LR'} ;  {'MPI-ESM-LR'} ; {'CanESM2'};  {'EC-EARTH'} ; {'EC-EARTH'} ; {'HadGEM2-ES'};  {'CanESM2'}; {'CM5A-MR'}; {'CNRM-CM5'}; {'EC-EARTH'}; {'GFDL-ESM2M'}; {'HadGEM2-ES'}; {'MIROC5'}; {'MPI-ESM-LR'}; {'NorESM1-M'} ; {'CSIRO-Mk3-6-0'}; {'HadGEM2-ES'} ; {'MPI-ESM-LR'} ; {'EC-EARTH'}  ; {'CM5A-LR'}   ; {'GFDL-ESM2G'} ;  {'MIROC5'}  ];

elseif flag_run == 4 % rcp 2.6

RCM(:,1) = [ {'RACMO22T_'} ; {'RCA4_'}  ; {'RCA4_'}      ; {'RCA4_'}   ;  {'RCA4_'}     ; {'RCA4_'}     ; {'REMO2009_'}  ; {'REMO2009_'}  ;  {'REMO2009_'} ; {'REMO2009_'}  ; {'REMO2009_'}];
GCM(:,1) = [ {'HadGEM2-ES'}; {'MIROC5'} ; {'HadGEM2-ES'} ; {'EC-EARTH'};  {'MPI-ESM-LR'}; {'NorESM1-M'} ; {'HadGEM2-ES'} ; {'MPI-ESM-LR'} ;  {'CM5A-LR'}   ; {'GFDL-ESM2G'} ;  {'MIROC5'}  ];

elseif flag_run == 5 % rcp 45
RCM(:,1) = [{'CCLM4-8-17_'}; {'CCLM4-8-17_'}; {'CCLM4-8-17_'}; {'CCLM4-8-17_'};  {'HIRHAM5_'} ;  {'CRCM5_'}     ; {'CRCM5_'} ; {'RACMO22T_'} ; {'RACMO22T_'} ;  {'RCA4_'}  ; {'RCA4_'}  ; {'RCA4_'}   ; {'RCA4_'}   ; {'RCA4_'}     ; {'RCA4_'}     ; {'RCA4_'} ; {'RCA4_'}     ; {'RCA4_'}     ; {'RCA4_'}        ; {'REMO2009_'}  ; {'REMO2009_'} ];
GCM(:,1) = [{'CNRM-CM5'}   ; {'EC-EARTH'}   ; {'HadGEM2-ES'} ; {'MPI-ESM-LR'} ;  {'EC-EARTH'} ;  {'MPI-ESM-LR'} ; {'CanESM2'};  {'EC-EARTH'}   ; {'HadGEM2-ES'};  {'CanESM2'}; {'CM5A-MR'}; {'CNRM-CM5'}; {'EC-EARTH'}; {'GFDL-ESM2M'}; {'HadGEM2-ES'}; {'MIROC5'}; {'MPI-ESM-LR'}; {'NorESM1-M'} ; {'CSIRO-Mk3-6-0'}; {'MPI-ESM-LR'} ; {'EC-EARTH'}   ];
   

elseif flag_run == 6 %  rcp 85
RCM(:,1) = [{'CCLM4-8-17_'}; {'CCLM4-8-17_'}; {'CCLM4-8-17_'}; {'CCLM4-8-17_'};   {'HIRHAM5_'} ; {'RACMO22T_'} ;  {'RCA4_'}  ; {'RCA4_'}  ; {'RCA4_'}   ; {'RCA4_'}   ; {'RCA4_'}     ; {'RCA4_'}     ; {'RCA4_'} ; {'RCA4_'}     ; {'RCA4_'}     ; {'RCA4_'}        ; {'REMO2009_'}  ; {'REMO2009_'}  ; {'REMO2009_'}  ];
GCM(:,1) = [{'CNRM-CM5'}   ; {'EC-EARTH'}   ; {'HadGEM2-ES'} ; {'MPI-ESM-LR'} ;   {'EC-EARTH'} ; {'HadGEM2-ES'};  {'CanESM2'}; {'CM5A-MR'}; {'CNRM-CM5'}; {'EC-EARTH'}; {'GFDL-ESM2M'}; {'HadGEM2-ES'}; {'MIROC5'}; {'MPI-ESM-LR'}; {'NorESM1-M'} ; {'CSIRO-Mk3-6-0'}; {'MPI-ESM-LR'} ; {'EC-EARTH'}   ; {'CM5A-LR'}    ];
end

% define period

nm = length(GCM); % number of models
Lvap = 2.50E6; %
nc = 0; 
A_cell = 5.2356e+07;  

% add directory containing CORDEX data to path

addpath(genpath('/media/Inne_1/CORDEX-AFR/data/historical'));
addpath(genpath('/media/Inne_1/CORDEX-AFR/data/rcp26'));
addpath(genpath('/media/Inne_1/CORDEX-AFR/data/rcp45'));
addpath(genpath('/media/Inne_1/CORDEX-AFR/data/rcp85'));


% Calculate terms of the water balance per model. 
calcWBterms_cdx; 

