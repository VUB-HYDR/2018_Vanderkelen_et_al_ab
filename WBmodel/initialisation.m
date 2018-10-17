% ------------------------------------------------------------------------
% Initialisation script
% In this script includes initialisation of: 
%                           1. timebounds
%                           2. physical constants
%                           3. Lake Victoria boundaries
%                           4. grid resolution
%                           5. RCM and GCM names
%                           6. number of models for considered run
% ------------------------------------------------------------------------


% time bounds
def_timebounds; 


% initialise physical constants
inicon


% initialise Lake Victoria boundaries
lat_min_Vict = -3.1;
lat_max_Vict = 0.6;
lon_min_Vict = 31.4;
lon_max_Vict = 35;
bounds_Vict  = [lat_min_Vict; lat_max_Vict; lon_min_Vict; lon_max_Vict];


% define size of a grid point (grid resolution)
res_grid = 0.065;        % pixel length [°]
res_m = res_grid*c_earth/360;  % pixel length [m]
A_cell = res_m^2; % pixel area


% initialise RCM and GCM names
EraInt = {'ECMWF-ERAINT'};

    if flag_run == 2 % evaluation
        RCM(:,1) =  [{'CCLM4-8-17_'}; {'CRCM5_'} ;  {'HIRHAM5_'} ; {'RACMO22T_'} ;{'RCA4_'}; {'REMO2009_'}];
        RCM_text(:,1) =  [{'CCLM4-8-17 '}; {'CRCM5 '} ;  {'HIRHAM5 '} ; {'RACMO22T '} ;{'RCA4 '}; {'REMO2009 '}];

    elseif flag_run == 3 % historical
   
        RCM(:,1) = [{'CCLM4-8-17_'}; {'CCLM4-8-17_'}; {'CCLM4-8-17_'}; {'CCLM4-8-17_'};   {'CRCM5_'}     ; {'CRCM5_'} ; {'HIRHAM5_'} ;  {'RACMO22T_'}; {'RACMO22T_'} ;  {'RCA4_'}  ; {'RCA4_'}  ; {'RCA4_'}   ; {'RCA4_'}   ; {'RCA4_'}     ; {'RCA4_'}     ; {'RCA4_'} ; {'RCA4_'}     ; {'RCA4_'}     ; {'RCA4_'}         ; {'REMO2009_'}  ; {'REMO2009_'}  ; {'REMO2009_'} ; {'REMO2009_'} ; {'REMO2009_'}  ; {'REMO2009_'}];
        GCM(:,1) = [{'CNRM-CM5'}   ; {'EC-EARTH'}   ; {'HadGEM2-ES'} ; {'MPI-ESM-LR'} ;   {'MPI-ESM-LR'} ; {'CanESM2'}; {'EC-EARTH'} ; {'EC-EARTH'} ; {'HadGEM2-ES'};  {'CanESM2'}; {'CM5A-MR'}; {'CNRM-CM5'}; {'EC-EARTH'}; {'GFDL-ESM2M'}; {'HadGEM2-ES'}; {'MIROC5'}; {'MPI-ESM-LR'}; {'NorESM1-M'} ; {'CSIRO-Mk3-6-0'}; {'HadGEM2-ES'} ; {'MPI-ESM-LR'} ; {'EC-EARTH'}  ; {'CM5A-LR'}   ; {'GFDL-ESM2G'} ;  {'MIROC5'}  ];
        RCM_text(:,1) = [{'CCLM4-8-17 '}; {'CCLM4-8-17 '}; {'CCLM4-8-17 '}; {'CCLM4-8-17 '};   {'CRCM5 '}     ; {'CRCM5 '}  ; {'HIRHAM5 '}; {'RACMO22T '}; {'RACMO22T '} ;  {'RCA4 '}  ; {'RCA4 '}  ; {'RCA4 '}   ; {'RCA4 '}   ; {'RCA4 '}     ; {'RCA4 '}     ; {'RCA4 '} ; {'RCA4 '}     ; {'RCA4 '}     ; {'RCA4 '}         ; {'REMO2009 '}  ; {'REMO2009 '}  ; {'REMO2009 '} ; {'REMO2009 '} ; {'REMO2009 '}  ; {'REMO2009 '}];

    elseif flag_run == 4 % rcp 2.6
   
        RCM(:,1) = [ {'RACMO22T_'} ; {'RCA4_'}  ; {'RCA4_'}      ; {'RCA4_'}   ;  {'RCA4_'}     ; {'RCA4_'}     ; {'REMO2009_'}  ; {'REMO2009_'}   ; {'REMO2009_'} ; {'REMO2009_'}  ; {'REMO2009_'}];
        GCM(:,1) = [ {'HadGEM2-ES'}; {'MIROC5'} ; {'HadGEM2-ES'} ; {'EC-EARTH'};  {'MPI-ESM-LR'}; {'NorESM1-M'} ; {'HadGEM2-ES'} ; {'MPI-ESM-LR'}  ; {'CM5A-LR'}   ; {'GFDL-ESM2G'} ;  {'MIROC5'}  ];
        RCM_text(:,1) = [ {'RACMO22T '} ; {'RCA4 '}  ; {'RCA4 '}      ; {'RCA4 '}   ;  {'RCA4 '}     ; {'RCA4 '}     ; {'REMO2009 '}  ; {'REMO2009 '}; {'REMO2009 '} ; {'REMO2009 '} ; {'REMO2009 '}];

    elseif flag_run == 5 % rcp 45
    
        RCM(:,1) = [{'CCLM4-8-17_'}; {'CCLM4-8-17_'}; {'CCLM4-8-17_'}; {'CCLM4-8-17_'};  {'CRCM5_'}      ; {'CRCM5_'}  ;{'HIRHAM5_'}  ;{'RACMO22T_'} ; {'RACMO22T_'} ;  {'RCA4_'}  ; {'RCA4_'}  ; {'RCA4_'}   ; {'RCA4_'}   ; {'RCA4_'}     ; {'RCA4_'}     ; {'RCA4_'} ; {'RCA4_'}     ; {'RCA4_'}     ; {'RCA4_'}        ; {'REMO2009_'}  ; {'REMO2009_'} ];
        GCM(:,1) = [{'CNRM-CM5'}   ; {'EC-EARTH'}   ; {'HadGEM2-ES'} ; {'MPI-ESM-LR'}  ; {'MPI-ESM-LR'}  ; {'CanESM2'} ;  {'EC-EARTH'};{'EC-EARTH'} ; {'HadGEM2-ES'};  {'CanESM2'}; {'CM5A-MR'}; {'CNRM-CM5'}; {'EC-EARTH'}; {'GFDL-ESM2M'}; {'HadGEM2-ES'}; {'MIROC5'}; {'MPI-ESM-LR'}; {'NorESM1-M'} ; {'CSIRO-Mk3-6-0'}; {'MPI-ESM-LR'} ; {'EC-EARTH'}   ];
        RCM_text(:,1) = [{'CCLM4-8-17 '}; {'CCLM4-8-17 '}; {'CCLM4-8-17 '}; {'CCLM4-8-17 '}; {'CRCM5 '} ; {'CRCM5 '} ;{'HIRHAM5 '} ; {'RACMO22T '} ; {'RACMO22T '} ;  {'RCA4 '}  ; {'RCA4 '}  ; {'RCA4 '}   ; {'RCA4 '}   ; {'RCA4 '}     ; {'RCA4 '}     ; {'RCA4 '} ; {'RCA4 '}     ; {'RCA4 '}     ; {'RCA4 '}        ; {'REMO2009 '}  ; {'REMO2009 '} ];

    elseif flag_run == 6 %  rcp 85
        
        RCM(:,1) = [{'CCLM4-8-17_'}; {'CCLM4-8-17_'}; {'CCLM4-8-17_'}; {'CCLM4-8-17_'};   {'HIRHAM5_'} ; {'RACMO22T_'} ;  {'RCA4_'}  ; {'RCA4_'}  ; {'RCA4_'}   ; {'RCA4_'}   ; {'RCA4_'}     ; {'RCA4_'}     ; {'RCA4_'} ; {'RCA4_'}     ; {'RCA4_'}     ; {'RCA4_'}        ; {'REMO2009_'}  ; {'REMO2009_'}  ; {'REMO2009_'}  ];
        GCM(:,1) = [{'CNRM-CM5'}   ; {'EC-EARTH'}   ; {'HadGEM2-ES'} ; {'MPI-ESM-LR'} ;   {'EC-EARTH'} ; {'HadGEM2-ES'};  {'CanESM2'}; {'CM5A-MR'}; {'CNRM-CM5'}; {'EC-EARTH'}; {'GFDL-ESM2M'}; {'HadGEM2-ES'}; {'MIROC5'}; {'MPI-ESM-LR'}; {'NorESM1-M'} ; {'CSIRO-Mk3-6-0'}; {'MPI-ESM-LR'} ; {'EC-EARTH'}   ; {'CM5A-LR'}    ];
        RCM_text(:,1) = [{'CCLM4-8-17 '}; {'CCLM4-8-17 '}; {'CCLM4-8-17 '}; {'CCLM4-8-17 '};   {'HIRHAM5 '} ; {'RACMO22T '} ;  {'RCA4 '}  ; {'RCA4 '}  ; {'RCA4 '}   ; {'RCA4 '}   ; {'RCA4 '}     ; {'RCA4 '}     ; {'RCA4 '} ; {'RCA4 '}     ; {'RCA4 '}     ; {'RCA4 '}        ; {'REMO2009 '}  ; {'REMO2009 '}  ; {'REMO2009 '}  ];

    end
    
    RCM_all(:,1)= [{'CCLM4-8-17'}; {'CRCM5'} ;  {'HIRHAM5'} ; {'RACMO22T'}; {'RCA4'} ; {'REMO2009'}];
   
    
% determine number of models 
if flag_run == 1
    nm = 1;    
else
    nm = length(RCM); % number of models
     nRCMs = length(unique(RCM));
end