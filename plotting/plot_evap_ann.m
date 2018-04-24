%% Map spatial distribution of multiyear mean of yearly precipitation


% calculate index where a new year starts
years = min(date(:,1)):max(date(:,1));
load lon_P lat_P
for t = 1:length(years)
    [~, ind_year(t)] = ismember(years(t),date(:,1)); 
end

for t = 1:(length(years)-1)
   for i = 1:length(lon_P)
        for j = 1:length(lat_P)
            E_yearsum(i,j,t) = nansum(E_lake(i,j,(ind_year(t):(ind_year(t+1)-1))),3); 
        end
   end
end 

for i = 1:length(lon_P)
   for j = 1:length(lat_P)
            E_ysummean(i,j) = nanmean(E_yearsum(i,j,:))*10^3; 
   end
end

%Plotscript

% plot spatial distribution
mf_plot_cdx(lon_P, lat_P, E_ysummean, caxes.prec, colormaps.prec,res_grid,fields{index},'mm per year') 


