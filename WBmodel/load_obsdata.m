% -----------------------------------------------------------------------
% Script to load observational data (precipitation and evaporation)
% -----------------------------------------------------------------------

% -----------------------------------------------------------------------
% Load LHF from model data (CCLM² from THiery et al. 2015)
% -----------------------------------------------------------------------
% units: [J/s]

nc = 0 ; 

[lat_LHF, lon_LHF, LHF_daymean] = mf_load('1996-2008_FLake_out02_LHF_ydaymean.nc','ALHFL_S', nc);


% -----------------------------------------------------------------------
% Load PERSIANN-CDR data
% -----------------------------------------------------------------------

% observational model
[ lat_P, lon_P, P] = mf_loadPERSIANN('PERSIANN-CDR_v01r01_1992_2014_AGL_remapped_owngrid.nc','precipitation', nc);

% Remove

% % Observations
 time_begin_trmm  = [1998, 1, 1, 0,0,0]; % datum van eerste dahiti data beschikb
 time_end_trmm    = [2007,12,31,23,0,0];
% 
 date_vec_trmm= datevec(datenum(time_begin_trmm ):1:datenum(time_end_trmm ));
 date_trmm = date_vec_trmm(:,1:3); 
% 
%  time_begin_obs = [1998, 1, 1, 0,0,0]; % datum van eerste dahiti data beschikb
%  time_end_obs    = [2007,12,31,23,0,0];
%  date_vec_obs= datevec(datenum(time_begin_obs ):1:datenum(time_end_obs ));
%  date_obs = date_vec_trmm(:,1:3); 
%  date_2007 = [2007 12 31]; 
%  [~, ind_2007] = ismember(date_2007,date_trmm,'rows'); 
% 
% % mm/hr
%  [~, ~, P_trmm_all] = mf_load('TRMM_3B42_AGL_1998-2010_remap.nc', 'hrf', 0) ; 
%  
%  % cut TRMM period to 2007
%  P = P_trmm_all(:,:,1:ind_2007); 
%   P = flipud(P); 



