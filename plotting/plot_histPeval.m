% ------------------------------------------------------------------------
% Script to make pdfs of WB terms of the different runs
% ------------------------------------------------------------------------

% Extract right periods of observations

date_2008 = [2008 12 31]; 
date_1993 = [1993 1 1]; 
date_2005 = [2005 1 1]; 

[~, loc_2008] = ismember(date_2008,date_obs,'rows');
[~, loc_2005] = ismember(date_2005, date_obs,'rows'); 
[~, loc_1993_ev] = ismember(date_1993, date_ev,'rows'); 
[~, loc_1993_hist] = ismember(date_1993, date_hist,'rows'); 

load P_wb_hist 
load E_wb_hist 
load Qin_wb_hist
load P_wb_obs 
load E_wb_obs 
load Qin_wb_obs
load P_wb_ev 
load E_wb_ev 
load Qin_wb_ev

P_obs_evaladj = P_wb_obs(1:loc_2008); 
P_ev_obsadj = P_wb_ev(:,loc_1993_ev:length(date_ev)); 
P_obs_histadj = P_wb_obs(1:loc_2005-1); 
P_hist_obsadj = P_wb_hist(:,loc_1993_hist:length(P_wb_hist)); 

E_obs_evaladj = E_wb_obs(1:loc_2008); 
E_ev_obsadj = E_wb_ev(:,loc_1993_ev:length(date_ev)); 
E_obs_histadj = E_wb_obs(1:loc_2005-1); 
E_hist_obsadj = E_wb_hist(:,loc_1993_hist:length(E_wb_hist)); 

Qin_obs_evaladj = Qin_wb_obs(1:loc_2008); 
Qin_ev_obsadj = Qin_wb_ev(:,loc_1993_ev:length(date_ev)); 
Qin_obs_histadj = Qin_wb_obs(1:loc_2005-1); 
Qin_hist_obsadj = Qin_wb_hist(:,loc_1993_hist:length(Qin_wb_hist)); 


% Precipitation
figure1 = figure();
for i = 1:size(P_ev_obsadj,1)
subplot(2,3,i)
mf_plot_hist(P_obs_evaladj*10^3,[0.2 0.2 0.2],'Observed','precipitation [mm/day]',[0 33],axcolor,1,0.6)
ylim([0 0.85])
hold on
mf_plot_hist(P_ev_obsadj(i,:)*10^3,P_color,RCM_text{i,1},'precipitation [mm/day]',[0 33],axcolor,1,0.6)
xlim([0 25])
hold off
end

[ax,h]=subtitle('Histograms of mean precipitation (CORDEX evaluations)');
h.FontWeight = 'Bold';
h.FontSize =  14;
h.Color = axcolor; 
createpanelnrhist(figure1);