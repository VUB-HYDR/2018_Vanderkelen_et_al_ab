%load P
% calculate index where a new year starts
years = min(date(:,1)):max(date(:,1));
for t = 1:length(years)
    [~, ind_year(t)] = ismember(years(t),date(:,1)); 
end

for t = 1:(length(years)-1)
   for i = 1:nx
        for j = 1:nx
            P_yearsum(i,j,t) = nansum(P(i,j,(ind_year(t):(ind_year(t+1)-1))),3); 
        end
   end
end 

for i = 1:nx
   for j = 1:nx
            P_ysummean(i,j) = nanmean(P_yearsum(i,j,:))*10^3; 
   end
end

% plot spatial distribution
mf_plot_cdx(lon_P, lat_P, P_ysummean, caxes.prec, colormaps.prec,res_grid,fields{index},'mm/year'); 


