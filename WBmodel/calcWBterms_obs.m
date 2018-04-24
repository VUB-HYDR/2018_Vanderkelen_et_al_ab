% --------------------------------------------------------------------
% Subroutine to calculate the terms (precipitation, evaporation and inflow
% of the WBmodel for observations
% --------------------------------------------------------------------


% ------------------------------------------------------------------------
% calculate the inflow (Qin)

% calculate the CN pixel values of the grid

CN = calc_CN(nx,ny);

% define number of antecedent day precipitation to determine AMC
amc_days = 5; 
    
% solve the inflow with the CN method
[Qin,Q] = solveQin_CN(P_basin, CN, amc_days, ndays, A_cell); 

%% ------------------------------------------------------------------------
%  calculate mean precipitation and evaporation over the lake

for t = 1:ndays
     % Calculate terms of WB
     P_mean(t) = nanmean(nanmean(P_lake(:,:,t))); % average all precip [m]
     if (isnan(P_mean(t))) P_mean(t) = 0; end
     E_mean(t) = nanmean(nanmean(E_lake(:,:,t))); % average all evap [m]
end

% ------------------------------------------------------------------------
% Outflow is taken from sources (variable Qout)  

P_wb_obs =  P_mean;
E_wb_obs =  E_mean;
Qin_wb_obs = Qin; 


