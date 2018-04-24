% -----------------------------------------------------------------------
% Script to load monthly mean CORDEX data for one particular model (to use within loop)
% only for historical and rcp experiments
% -----------------------------------------------------------------------

fprintf('Loading RCM %d from %d \n', i, nm)

if flag_run == 3 % historical run

    % load file names
    file_name_hist_pr     = cell2mat(strcat('CORDEX_historical_',RCM(i,1),GCM(i,1),'_pr.nc'  ));
    file_name_hist_hfls     = cell2mat(strcat('CORDEX_historical_',RCM(i,1),GCM(i,1),'_hfls.nc'  ));
    
    % load variables
   [lat_CORDEX, lon_CORDEX, LHF_init] = mf_load(file_name_hist_hfls,'hfls',nc); 
   [~, ~, P_init] = mf_load(file_name_hist_pr,'pr',nc);        

   time_begin  = [1951, 1, 1, 0,0,0];
   time_end    = [2005,12,31,23,0,0];
 
elseif flag_run == 4 % RCP 2.6
    
    % load file names
    file_name_rcp26_pr     = cell2mat(strcat('CORDEX_rcp26_',RCM(i,1),GCM(i,1),'_pr.nc'  ));
    file_name_rcp26_hfls     = cell2mat(strcat('CORDEX_rcp26_',RCM(i,1),GCM(i,1),'_hfls.nc'  ));
    
    % load variables
    [~, ~, LHF_init] = mf_load(file_name_rcp26_hfls,'hfls',nc); 
    [~, ~, P_init] = mf_load(file_name_rcp26_pr,'pr',nc);
    
   time_begin  = [2006, 1, 1, 0,0,0];
   time_end    = [2100,12,31,23,0,0]; 
   
elseif flag_run == 5 % RCP 4.5
        
    % load file names
    file_name_rcp45_pr     = cell2mat(strcat('CORDEX_rcp45_',RCM(i,1),GCM(i,1),'_pr.nc'  ));
    file_name_rcp45_hfl     = cell2mat(strcat('CORDEX_rcp45_',RCM(i,1),GCM(i,1),'_hfls.nc'  ));
    
    % load variables
    [lat_CORDEX, lon_CORDEX, LHF_init] = mf_load(file_name_rcp45_hfl,'hfls',nc); 
    [~, ~, P_init] = mf_load(file_name_rcp45_pr,'pr',nc);   
    
   time_begin  = [2006, 1, 1, 0,0,0];
   time_end    = [2100,12,31,23,0,0]; 
    
elseif flag_run == 6 % RCP 8.5
        
    % load file names
    file_name_rcp85_pr       = cell2mat(strcat('CORDEX_rcp85_',RCM(i,1),GCM(i,1),'_pr.nc'  ));
    file_name_rcp85_hfls     = cell2mat(strcat('CORDEX_rcp85_',RCM(i,1),GCM(i,1),'_hfls.nc'  ));
    
    % load variables
    [~, ~, LHF_init] = mf_load(file_name_rcp85_hfls,'hfls',nc); 
    [~, ~, P_init] = mf_load(file_name_rcp85_pr,'pr',nc);
    
    time_begin  = [2006, 1, 1, 0,0,0];
    time_end    = [2100,12,31,23,0,0]; 
    
end

% define date vec and number of days of correct period
date_vec =  datevec(datenum(time_begin ):1:datenum(time_end));
date = date_vec(:,1:3);
ndays = length(date); 



        