% ------------------------------------------------------------------------
% Plotting plots of FUT-HIST
% ------------------------------------------------------------------------
flag_CRCM = 0; 

load lon_grid lat_grid
% load in variables
for i = 1:16
 % historical run

    % load file names
    file_name_hist_pr  = cell2mat(strcat('CORDEX_historical_',RCM(i,1),GCM(i,1),'_pr_1971-2000_ymean.nc'  ));
    file_name_hist_hfls   = cell2mat(strcat('CORDEX_historical_',RCM(i,1),GCM(i,1),'_hfls_1971-2000_ymean.nc'  ));
    
    % load variables
    [~ ,~,  LHF_hist_ymean(:,:,i)] = mf_load(file_name_hist_hfls,'hfls',nc); 
    [~, ~, P_hist_ymean(:,:,i)] = mf_load(file_name_hist_pr,'pr',nc);        

    E_hist_ymean(:,:,i) = LHF_hist_ymean(:,:,i)/Lvap * 3600 * 24 *10^(-3); 
    P_hist_ymean(:,:,i) = P_hist_ymean(:,:,i) .* 10^(-3).* 3600 .* 24;

% RCP 2.6
       if flag_CRCM ==1

    % load file names
    file_name_rcp26_pr      = cell2mat(strcat('CORDEX_rcp26_',RCM(i,1),GCM(i,1),'_pr_2071-2100_ymean.nc'  ));
    file_name_rcp26_hfls      = cell2mat(strcat('CORDEX_rcp26_',RCM(i,1),GCM(i,1),'_hfls_2071-2100_ymean.nc'  ));
    
    % load variables
    [~, ~, LHF_rcp26_ymean(:,:,i)] = mf_load(file_name_rcp26_hfls,'hfls',nc); 
    [~, ~, P_rcp26_ymean(:,:,i)] = mf_load(file_name_rcp26_pr,'pr',nc);
    
    E_rcp26_ymean(:,:,i) = LHF_rcp26_ymean(:,:,i)/Lvap * 3600 * 24 *10^(-3); 
    P_rcp26_ymean(:,:,i) = P_rcp26_ymean(:,:,i) .* 10^(-3).* 3600 .* 24;
       end
% RCP 4.5
        
    % load file names
    file_name_rcp45_pr    = cell2mat(strcat('CORDEX_rcp45_',RCM(i,1),GCM(i,1),'_pr_2071-2100_ymean.nc'  ));
    file_name_rcp45_hfls  = cell2mat(strcat('CORDEX_rcp45_',RCM(i,1),GCM(i,1),'_hfls_2071-2100_ymean.nc'  ));
    
    % load variables
    [~, ~, LHF_rcp45_ymean(:,:,i)] = mf_load(file_name_rcp45_hfls,'hfls',nc); 
    [~, ~, P_rcp45_ymean(:,:,i)] = mf_load(file_name_rcp45_pr,'pr',nc);     
    
    E_rcp45_ymean(:,:,i) = LHF_rcp45_ymean(:,:,i)/Lvap * 3600 * 24 *10^(-3); 
    P_rcp45_ymean(:,:,i) = P_rcp45_ymean(:,:,i) * 10^(-3)* 3600 * 24;

    if flag_CRCM ==1
% RCP 8.5
        
    % load file names
    file_name_rcp85_pr      = cell2mat(strcat('CORDEX_rcp85_',RCM(i,1),GCM(i,1),'_pr_2071-2100_ymean.nc'  ));
    file_name_rcp85_hfls    = cell2mat(strcat('CORDEX_rcp85_',RCM(i,1),GCM(i,1),'_hfls_2071-2100_ymean.nc'  ));
    
    % load variables
    [~, ~, LHF_rcp85_ymean(:,:,i)] = mf_load(file_name_rcp85_hfls,'hfls',nc); 
    [~, ~, P_rcp85_ymean(:,:,i)] = mf_load(file_name_rcp85_pr,'pr',nc);
    
    
    E_rcp85_ymean(:,:,i) = LHF_rcp85_ymean(:,:,i)/Lvap * 3600 * 24 *10^(-3); 
    P_rcp85_ymean(:,:,i) = P_rcp85_ymean(:,:,i) .* 10^(-3).* 3600 .* 24;
    end
end
    
%% loop over all different models to plot separately
 % set colormaps
 
 colormaps.prec = mf_colormap_cpt('es skywalker 01',12); 
 caxes.prec = [0      3100];
 colormaps.prec(1,:) = [1 1 1];
 colormaps.evap = mf_colormap_cpt('Oranges_07',7); 
 caxes.evap = [0      1800 ];
 colormaps.evap(1,:) = [1 1 1];
 colormaps.diffprec = mf_colormap_cpt('RdBu 11',11); 
 caxes.diffprec = [-400      400 ];
 colormaps.diffevap = mf_colormap_cpt('RdBu 11',11); 
 caxes.diffevap = [-80      80];
 
for i = 1:nm
% plot precipitation
 figure()
 
 % historical
 ax1 = subplot(2,3,1); 
 mf_plot_cdx(lon_grid, lat_grid, P_hist_ymean(:,:,i)*10^3, caxes.prec, colormaps.prec,res_grid,'HIST precipitation (1971-2000)','mm/year',ax1,'a)')

 % future
ax2 = subplot(2,3,2); 
mf_plot_cdx(lon_grid, lat_grid, P_rcp45_ymean(:,:,i)*10^3, caxes.prec, colormaps.prec,res_grid,'FUT precipitation (RCP 4.5 2071-2100)','mm/year',ax2,'b)')

 % difference
P_diff = P_rcp45_ymean(:,:,i)*10^3-P_hist_ymean(:,:,i)*10^3; 

ax3 = subplot(2,3,3); 
mf_plot_cdx(lon_grid, lat_grid, P_diff, caxes.diffprec, colormaps.diffprec,res_grid,'FUT-HIST precipitation','mm/year',ax3,'c)')


%  plot evaporation
 % historical
 ax4 = subplot(2,3,4); 
 mf_plot_cdx(lon_P, lat_P, E_hist_ymean(:,:,i)*10^3, caxes.evap, colormaps.evap,res_grid,'HIST evaporation (1971-2000)','mm/year',ax4,'d)')

 % future
ax5 = subplot(2,3,5); 
mf_plot_cdx(lon_P, lat_P, E_rcp45_ymean(:,:,i)*10^3, caxes.evap, colormaps.evap,res_grid,'FUT evaporation (RCP 4.5 2071-2100)','mm/year',ax5,'e)')

 % difference
E_diff = E_rcp45_ymean(:,:,i)*10^3-E_hist_ymean(:,:,i)*10^3; 
 
ax6 = subplot(2,3,6); 
mf_plot_cdx(lon_P, lat_P, E_diff, caxes.diffevap, colormaps.diffevap,res_grid,'FUT-HIST evaporation','mm/year',ax6,'f)')


 
        
        
    if i == 1    
    [ax,h]=subtitle('CRCM5 driven by MPI-ESM-LR');
    else
    [ax,h]=subtitle('CRCM5 driven by CanESM2')   ;   
    end
    h.FontWeight = 'Bold';
    h.FontSize =  14;
    
end