% -----------------------------------------------------------------------
% Script to load non-climatological data: 
%               1. lake levels (DAHITI and HYDROMET)
%               2. lake and basin shapefiles
%               3. latitude and longitude of grid -> check if really
%               necessary! 
%               4. load outflow
% -----------------------------------------------------------------------


% 1. Load lake levels 
% -----------------------------------------------------------------------

% DAHITI lake levels (units: [m/day]) 
[date_dh(:,1), date_dh(:, 2), date_dh(:,3), dh_lakelevel,...
    dh_lakelevel_err] = textread('DAHITI_lakelevels.txt'); 

% HYDROMOET lake levels (no constant time series) (units: [m/day])
[date_hm_raw(:,1), date_hm_raw(:, 2), date_hm_raw(:,3), lakelevel_hm_raw,...
    lakelevel_jinja_raw] = textread('Jinja_lakelevels.txt'); 


% 2. Load shape files
% -----------------------------------------------------------------------

% Load shape files
shp_Vict = load('shp_Vict','shp_Vict'); % Lake Victoria
shp_Vict = shp_Vict.shp_Vict;
shp_basin = load('shp_basin'); % Lake Victoria basin
shp_basin = shp_basin.shp_basin;


% 3. Load longitude and latitude of CCLM grid
% ------------------------------------------------------------------------
% load lon_P.mat
% load lat_P.mat

nc = 0; 
[lat_CCLM, lon_CCLM, depth_CCLM] = mf_load('lffd1996010100c.nc', 'DEPTH_LK', nc);



% 4. Load outflow
% ------------------------------------------------------------------------
load outflow.mat

