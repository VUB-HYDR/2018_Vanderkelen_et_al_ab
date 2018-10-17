% ------------------------------------------------------------------------
% Script to load and restore evaluation simulation of CORDEX
% ------------------------------------------------------------------------

% ------------------------------------------------------------------------
% Determine intersection OBS and EVAL periods
% Define timebounds of intersection obs and eval data

time_begin_ev_obs  = [1993, 1, 1, 0,0,0]; % data of first dahiti available
time_end_ev_obs    = [2008,12,31,23,0,0];

date_vec_ev_obs= datevec(datenum(time_begin_ev_obs ):1:datenum(time_end_ev_obs ));
date_ev_obs = date_vec_ev_obs(:,1:3); 

% load observed
load('P_wb_obs.mat')
load('E_wb_obs.mat')
load('Qin_wb_obs.mat')

% extract corresponding eval period from obs timeseries

[ind_evalobs, ind] = ismember(date_ev,date_obs,'rows');
[ind_obseval, ind] = ismember(date_obs,date_ev,'rows');

P_wb_obs_cor = P_wb_obs(find(ind_obseval==1));
E_wb_obs_cor = E_wb_obs(find(ind_obseval==1));
Qin_wb_obs_cor = Qin_wb_obs(find(ind_obseval==1));

%  load evaluation
load('P_wb_ev.mat')
load('E_wb_ev.mat')
load('Qin_wb_ev.mat')

P_wb_ev_cor = P_wb_ev(:,find(ind_evalobs==1));
E_wb_ev_cor = E_wb_ev(:,find(ind_evalobs==1));
Qin_wb_ev_cor = Qin_wb_ev(:,find(ind_evalobs==1));

% write variables
csvwrite('P_wb_ev.csv',(P_wb_ev_cor)')
csvwrite('E_wb_ev.csv',E_wb_ev_cor')
csvwrite('Qin_wb_ev.csv',Qin_wb_ev_cor')
csvwrite('P_wb_obs.csv',P_wb_obs_cor')
csvwrite('E_wb_obs.csv',E_wb_obs_cor')
csvwrite('Qin_wb_obs.csv',Qin_wb_obs_cor')
%%
% -------------------------------------------------------------------------
% Intersection OBS and HIST
% Define timebounds of intersection obs and eval data

time_begin_hist_obs  = [1993, 1, 1, 0,0,0]; % datum van eerste dahiti data beschikb
time_end_hist_obs    = [2004,12,31,23,0,0];

date_vec_hist_obs= datevec(datenum(time_begin_hist_obs ):1:datenum(time_end_hist_obs ));
date_hist_obs = date_vec_hist_obs(:,1:3); 

% load observed
load('P_wb_obs.mat')
load('E_wb_obs.mat')
load('Qin_wb_obs.mat')

% extract corresponding eval period from obs timeseries

[ind_histobs, ind] = ismember(date_hist,date_obs,'rows');
[ind_obshist, ind] = ismember(date_obs,date_hist,'rows');

P_wb_obs_cor = P_wb_obs(find(ind_obshist==1));
E_wb_obs_cor = E_wb_obs(find(ind_obshist==1));
Qin_wb_obs_cor = Qin_wb_obs(find(ind_obshist==1));

%  load evaluation
load('P_wb_hist.mat')
load('E_wb_hist.mat')
load('Qin_wb_hist.mat')

P_wb_hist_cor = P_wb_hist(:,find(ind_histobs==1));
E_wb_hist_cor = E_wb_hist(:,find(ind_histobs==1));
Qin_wb_hist_cor = Qin_wb_hist(:,find(ind_histobs==1));

% write variables
csvwrite('P_wb_histobs.csv',(P_wb_hist_cor)')
csvwrite('E_wb_histobs.csv',E_wb_hist_cor')
csvwrite('Qin_wb_histobs.csv',Qin_wb_hist_cor')
csvwrite('P_wb_obs.csv',P_wb_obs_cor')
csvwrite('E_wb_obs.csv',E_wb_obs_cor')
csvwrite('Qin_wb_obs.csv',Qin_wb_obs_cor')

%%
% -------------------------------------------------------------------------
% write hist WBterms
csvwrite('P_wb_hist.csv',(P_wb_hist)')
csvwrite('E_wb_hist.csv',E_wb_hist')
csvwrite('Qin_wb_hist.csv',Qin_wb_hist')

% write rcp26 WBterms
csvwrite('P_wb_rcp26.csv',(P_wb_rcp26)')
csvwrite('E_wb_rcp26.csv',E_wb_rcp26')
csvwrite('Qin_wb_rcp26.csv',Qin_wb_rcp26')

% write rcp45 WBterms
csvwrite('P_wb_rcp45.csv',(P_wb_rcp45)')
csvwrite('E_wb_rcp45.csv',E_wb_rcp45')
csvwrite('Qin_wb_rcp45.csv',Qin_wb_rcp45')

% write rcp85 WBterms
csvwrite('P_wb_rcp85.csv',(P_wb_rcp85)')
csvwrite('E_wb_rcp85.csv',E_wb_rcp85')
csvwrite('Qin_wb_rcp85.csv',Qin_wb_rcp85')