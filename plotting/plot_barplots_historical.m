% ------------------------------------------------------------------------
% Calculate difference of barplots 
% Period: 1981-2010 and 2071-2100
% Need to also load historical bias corrected WB terms for this script!
% ------------------------------------------------------------------------

% flags
flag_bc = 2; % 0: no bias correction, 1: QUANT, 2: linear 

% initialisation
main_plotting;

clear P_diff E_diff Qin_diff
clear CI_P_rcp85 CI_P_rcp45 CI_P_rcp26
clear CI_E_rcp85 CI_E_rcp45 CI_E_rcp26
clear CI_Qin_rcp85 CI_Qin_rcp45 CI_Qin_rcp26

clear legend_name

% load all data according to bc scenario.  
if flag_bc == 2 % linear transformation

    E_wb_hist = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\PFT_lin\E_wb_hist_bc.csv',1)'; 
    P_wb_hist = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\PFT_lin\P_wb_hist_bc.csv',1)'; 
    Qin_wb_hist = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\PFT_lin\Qin_wb_hist_bc.csv',1)';  

    E_wb_rcp26   = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\PFT_lin\E_wb_rcp26_bc.csv',1)'; 
    P_wb_rcp26   = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\PFT_lin\P_wb_rcp26_bc.csv',1)'; 
    Qin_wb_rcp26 = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\PFT_lin\Qin_wb_rcp26_bc.csv',1)'; 
    
    E_wb_rcp45i = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\PFT_lin\E_wb_rcp45_bc.csv',1)'; 
    P_wb_rcp45i = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\PFT_lin\P_wb_rcp45_bc.csv',1)'; 
    Qin_wb_rcp45i = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\PFT_lin\Qin_wb_rcp45_bc.csv',1)';  

    E_wb_rcp85 = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\PFT_lin\E_wb_rcp85_bc.csv',1)'; 
    P_wb_rcp85 = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\PFT_lin\P_wb_rcp85_bc.csv',1)'; 
    Qin_wb_rcp85 = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\PFT_lin\Qin_wb_rcp85_bc.csv',1)';  
    
    title_large= 'FUT-HIST (hist: 1981-2010, fut: 2071-2100) Linear parametric transformation'; 

elseif flag_bc == 1 % empirical quantiles
    
    E_wb_hist = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\QUANT\E_wb_hist_bc.csv',1)'; 
    P_wb_hist = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\QUANT\P_wb_hist_bc.csv',1)'; 
    Qin_wb_hist = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\QUANT\Qin_wb_hist_bc.csv',1)';  

   E_wb_rcp26 = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\QUANT\E_wb_rcp26_bc.csv',1)'; 
    P_wb_rcp26 = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\QUANT\P_wb_rcp26_bc.csv',1)'; 
    Qin_wb_rcp26= csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\QUANT\Qin_wb_rcp26_bc.csv',1)';  
    
    E_wb_rcp45i = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\QUANT\E_wb_rcp45_bc.csv',1)'; 
    P_wb_rcp45i = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\QUANT\P_wb_rcp45_bc.csv',1)'; 
    Qin_wb_rcp45i = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\QUANT\Qin_wb_rcp45_bc.csv',1)';  
    
    E_wb_rcp85 = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\QUANT\E_wb_rcp85_bc.csv',1)'; 
    P_wb_rcp85 = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\QUANT\P_wb_rcp85_bc.csv',1)'; 
    Qin_wb_rcp85 = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\QUANT\Qin_wb_rcp85_bc.csv',1)';  

    title_large= ' FUT-HIST (hist: 1981-2010, fut: 2071-2100) Empirical quantiles '; 

elseif flag_bc==0
    
    load P_wb_hist
    load E_wb_hist
    load Qin_wb_hist
    
    load('P_wb_rcp26.mat')
    load('E_wb_rcp26.mat')
    load('Qin_wb_rcp26.mat')
    
    load('P_wb_rcp45.mat')
    load('E_wb_rcp45.mat')
    load('Qin_wb_rcp45.mat')
    
    load('P_wb_rcp85.mat')
    load('E_wb_rcp85.mat')
    load('Qin_wb_rcp85.mat')
    
    E_wb_rcp45i =  E_wb_rcp45;
    P_wb_rcp45i =  P_wb_rcp45;
    Qin_wb_rcp45i = Qin_wb_rcp45;

    clear P_wb_rcp45 E_wb_rcp45 Qin_wb_rcp45 
    
    title_large= 'FUT-HIST (hist: 1981-2010, fut: 2071-2100) no bias correction'; 
end
%%
% initialise time periods
time_begin  = [1951, 1, 1, 0,0,0]; 
time_end  = [2100,12,31,23,0,0];
date_vec_tot= datevec(datenum(time_begin):1:datenum(time_end));
date_total = date_vec_tot(:,1:3);
years = unique(date_total(:,1)); 
years(length(years)+1) = years(length(years))+1; 
    
for t = 1:length(years)
        [~, ind_year(t)] = ismember(years(t),date_total(:,1)); 
end

% historical period: 1981-2010 (30 years)
years_hist = 1971:2000; 
[~,hist_loc] = ismember(years_hist,years);

% Future period: 2071-2100 (30 years)
years_fut=2071:2100;
 

[~,fut_loc] = ismember(years_fut,years);

% Exclude HIRHAM and CRCM5 CanESM2 from simulations
n_HIRHAM = 5; 

P_wb_rcp45 = exclude_sim(P_wb_rcp45i, n_HIRHAM ); 
E_wb_rcp45 = exclude_sim(E_wb_rcp45i, n_HIRHAM ); 
Qin_wb_rcp45 = exclude_sim(Qin_wb_rcp45i, n_HIRHAM ); 

% from here on HIRHAM already excluded!! 
% define indicators of rcp models in historical series
ind_rcp26 = [9,16,15,13,17,18,20,21,23,24,25];
ind_rcp45 = [1,	2,	3,	4,5, 6,8,9, 10,	11,	12,	13,	14,	15,	16,	17,	18,	19,	21,	22];
ind_rcp85 = [1, 2, 3, 4,5	9,	10,	11,	12,	13,	14,	15,	16,	17,	18,19,	21,	22,	23];

nm_rcp26 = length(ind_rcp26); 
nm_rcp45 = length(ind_rcp45); 
nm_rcp85 = length(ind_rcp85); 

% ------------------------------------------------------------------------
% RCP 2.6 

GCM_rcp26(:,1) = [ {'HadGEM2-ES'}; {'MIROC5'} ; {'HadGEM2-ES'} ; {'EC-EARTH'};  {'MPI-ESM-LR'}; {'NorESM1-M'} ; {'HadGEM2-ES'} ; {'MPI-ESM-LR'}  ; {'CM5A-LR'}   ; {'GFDL-ESM2G'} ;  {'MIROC5'}  ];
RCM_text_rcp26(:,1) = [ {'RACMO22T '} ; {'RCA4 '}  ; {'RCA4 '}      ; {'RCA4 '}   ;  {'RCA4 '}     ; {'RCA4 '}     ; {'REMO2009 '}  ; {'REMO2009 '}; {'REMO2009 '} ; {'REMO2009 '} ; {'REMO2009 '}];


% calculate yearmeans
        P_rcp26_tot = zeros(nm_rcp26,length(date_total)); 
        E_rcp26_tot = zeros(nm_rcp26,length(date_total)); 
        Qin_rcp26_tot = zeros(nm_rcp26,length(date_total)); 

for i = 1:nm_rcp26
        P_rcp26_tot(i,1:length(date_hist))=P_wb_hist(ind_rcp26(i),:); 
        P_rcp26_tot(i,length(date_hist)+1:length(date_total)) = P_wb_rcp26(i,:); 
        
        E_rcp26_tot(i,1:length(date_hist))=E_wb_hist(ind_rcp26(i),:); 
        E_rcp26_tot(i,length(date_hist)+1:length(date_total)) = E_wb_rcp26(i,:); 

        Qin_rcp26_tot(i,1:length(date_hist))=Qin_wb_hist(ind_rcp26(i),:); 
        Qin_rcp26_tot(i,length(date_hist)+1:length(date_total)) = Qin_wb_rcp26(i,:); 
  
    for t = 1:(length(years)-1)
        if t==(length(years)-1)
            P_rcp26_yearmean(i,t) = nanmean(P_rcp26_tot(i,(ind_year(t):ind_year(t)+364))); 
            E_rcp26_yearmean(i,t) = nanmean(E_rcp26_tot(i,(ind_year(t):(ind_year(t)+364)))); 
            Qin_rcp26_yearmean(i,t) = nanmean(Qin_rcp26_tot(i,(ind_year(t):(ind_year(t)+364)))); 
        else
          P_rcp26_yearmean(i,t) = nanmean(P_rcp26_tot(i,(ind_year(t):(ind_year(t+1)-1)))); 
          E_rcp26_yearmean(i,t) = nanmean(E_rcp26_tot(i,(ind_year(t):(ind_year(t+1)-1)))); 
          Qin_rcp26_yearmean(i,t) = nanmean(Qin_rcp26_tot(i,(ind_year(t):(ind_year(t+1)-1)))); 
        end
    end
    
    P_rcp26_histm(i,:) =  (P_rcp26_yearmean(i,hist_loc));
    P_rcp26_futm(i,:) = (P_rcp26_yearmean(i,fut_loc));
    E_rcp26_histm(i,:) =  (E_rcp26_yearmean(i,hist_loc));
    E_rcp26_futm(i,:) =  (E_rcp26_yearmean(i,fut_loc));
    Qin_rcp26_histm(i,:) = (Qin_rcp26_yearmean(i,hist_loc));
    Qin_rcp26_futm(i,:) = (Qin_rcp26_yearmean(i,fut_loc));
      

end
% 
% 
% 
% Calclate difference
P_rcp26_diff = (P_rcp26_futm-P_rcp26_histm)./P_rcp26_histm *100;
 E_rcp26_diff = (E_rcp26_futm-E_rcp26_histm)./E_rcp26_histm *100;
 Qin_rcp26_diff = (Qin_rcp26_futm-Qin_rcp26_histm)./Qin_rcp26_histm *100; 
% 
% P_rcp26_diffa = mean(mean(P_rcp26_futm-P_rcp26_histm))./mean(mean(P_rcp26_histm));
% E_rcp26_diffa = mean(mean(E_rcp26_futm-E_rcp26_histm))./mean(mean(E_rcp26_histm ));
% Qin_rcp26_diffa = mean(mean(Qin_rcp26_futm-Qin_rcp26_histm))./mean(mean(Qin_rcp26_histm ));
% compensation = Qin_rcp26_diffa./P_rcp26_diffa*100
% calculate CI
for i = 1:nm_rcp26
    CI_P_rcp26(i,:) = calc_CI(P_rcp26_diff(i,:));
    CI_E_rcp26(i,:) = calc_CI(E_rcp26_diff(i,:));
    CI_Qin_rcp26(i,:) = calc_CI(Qin_rcp26_diff(i,:));
    
end

% Calclate difference mean
P_rcp26_diffm = mean(P_rcp26_diff,2); 
E_rcp26_diffm = mean(E_rcp26_diff,2); 
Qin_rcp26_diffm = mean(Qin_rcp26_diff,2); 

% CI of multimodel mean
CI_P_rcp26m = calc_CI(P_rcp26_diffm);
CI_E_rcp26m = calc_CI(E_rcp26_diffm);
CI_Qin_rcp26m = calc_CI(Qin_rcp26_diffm);

% add multimodel CI to CI
CI_P_rcp26(length(CI_P_rcp26)+1,:) = CI_P_rcp26m;
CI_E_rcp26(length(CI_E_rcp26)+1,:) = CI_E_rcp26m;
CI_Qin_rcp26(length(CI_Qin_rcp26)+1,:) = CI_Qin_rcp26m;

% calculate multimodelmean difference
P_rcp26_diff_mean = nanmean(P_rcp26_diffm);
E_rcp26_diff_mean = nanmean(E_rcp26_diffm);
Qin_rcp26_diff_mean = nanmean(Qin_rcp26_diffm);

P_rcp26_diffm(length(P_rcp26_diffm)+1)=P_rcp26_diff_mean; 
E_rcp26_diffm(length(E_rcp26_diffm)+1)=E_rcp26_diff_mean; 
Qin_rcp26_diffm(length(Qin_rcp26_diffm)+1)=Qin_rcp26_diff_mean; 

legend_name_rcp26 = strcat(RCM_text_rcp26,GCM_rcp26);
legend_name_rcp26{nm_rcp26+1} = 'Multi-model mean'; 


%-------------------------------------------------------------------------
% RCP 4.5


GCM_rcp45(:,1) = [{'CNRM-CM5'}   ; {'EC-EARTH'}   ; {'HadGEM2-ES'} ; {'MPI-ESM-LR'} ;  {'MPI-ESM-LR'}  ; {'CanESM2'}; {'EC-EARTH'} ; {'HadGEM2-ES'};  {'CanESM2'}; {'CM5A-MR'}; {'CNRM-CM5'}; {'EC-EARTH'}; {'GFDL-ESM2M'}; {'HadGEM2-ES'}; {'MIROC5'}; {'MPI-ESM-LR'}; {'NorESM1-M'} ; {'CSIRO-Mk3-6-0'}; {'MPI-ESM-LR'} ; {'EC-EARTH'}   ];
    
RCM_text_rcp45(:,1) = [{'CCLM4-8-17 '}; {'CCLM4-8-17 '}; {'CCLM4-8-17 '}; {'CCLM4-8-17 '};  {'CRCM5 '} ; {'CRCM5 '} ;{'RACMO22T '} ; {'RACMO22T '} ;  {'RCA4 '}  ; {'RCA4 '}  ; {'RCA4 '}   ; {'RCA4 '}   ; {'RCA4 '}     ; {'RCA4 '}     ; {'RCA4 '} ; {'RCA4 '}     ; {'RCA4 '}     ; {'RCA4 '}        ; {'REMO2009 '}  ; {'REMO2009 '} ];


% calculate yearmeans
P_rcp45_tot = zeros(nm_rcp45,length(date_total));
E_rcp45_tot = zeros(nm_rcp45,length(date_total)); 
Qin_rcp45_tot = zeros(nm_rcp45,length(date_total)); 

for i = 1:nm_rcp45
        P_rcp45_tot(i,1:length(date_hist))=P_wb_hist(ind_rcp45(i),:); 
        P_rcp45_tot(i,length(date_hist)+1:length(date_total)) = P_wb_rcp45(i,:); 
        
        E_rcp45_tot(i,1:length(date_hist))=E_wb_hist(ind_rcp45(i),:); 
        E_rcp45_tot(i,length(date_hist)+1:length(date_total)) = E_wb_rcp45(i,:); 

        Qin_rcp45_tot(i,1:length(date_hist))=Qin_wb_hist(ind_rcp45(i),:); 
        Qin_rcp45_tot(i,length(date_hist)+1:length(date_total)) = Qin_wb_rcp45(i,:); 
  
    for t = 1:(length(years)-1)
        if t==(length(years)-1)
            P_rcp45_yearmean(i,t) = nanmean(P_rcp45_tot(i,(ind_year(t):ind_year(t)+364))); 
            E_rcp45_yearmean(i,t) = nanmean(E_rcp45_tot(i,(ind_year(t):(ind_year(t)+364)))); 
            Qin_rcp45_yearmean(i,t) = nanmean(Qin_rcp45_tot(i,(ind_year(t):(ind_year(t)+364)))); 
        else
          P_rcp45_yearmean(i,t) = nanmean(P_rcp45_tot(i,(ind_year(t):(ind_year(t+1)-1)))); 
          E_rcp45_yearmean(i,t) = nanmean(E_rcp45_tot(i,(ind_year(t):(ind_year(t+1)-1)))); 
          Qin_rcp45_yearmean(i,t) = nanmean(Qin_rcp45_tot(i,(ind_year(t):(ind_year(t+1)-1)))); 
        end
    end
    
    P_rcp45_histm(i,:) = (P_rcp45_yearmean(i,hist_loc));
    P_rcp45_futm(i,:) = (P_rcp45_yearmean(i,fut_loc));
    E_rcp45_histm(i,:) =  (E_rcp45_yearmean(i,hist_loc));
    E_rcp45_futm(i,:) = (E_rcp45_yearmean(i,fut_loc));
    Qin_rcp45_histm(i,:) =  (Qin_rcp45_yearmean(i,hist_loc));
    Qin_rcp45_futm(i,:) = (Qin_rcp45_yearmean(i,fut_loc));
    


    title_rcp45 = 'RCP 4.5';
end

% Calclate difference
P_rcp45_diff = (P_rcp45_futm-P_rcp45_histm)./P_rcp45_histm *100;
E_rcp45_diff = (E_rcp45_futm-E_rcp45_histm)./E_rcp45_histm *100;
Qin_rcp45_diff = (Qin_rcp45_futm-Qin_rcp45_histm)./Qin_rcp45_histm *100; 

for i = 1:nm_rcp45
    CI_P_rcp45(i,:) = calc_CI(P_rcp45_diff(i,:));
    CI_E_rcp45(i,:) = calc_CI(E_rcp45_diff(i,:));
    CI_Qin_rcp45(i,:) = calc_CI(Qin_rcp45_diff(i,:));
end

% Calclate difference mean
P_rcp45_diffm = mean(P_rcp45_diff,2); 
E_rcp45_diffm = mean(E_rcp45_diff,2); 
Qin_rcp45_diffm = mean(Qin_rcp45_diff,2);

% CI of multimodel mean
CI_P_rcp45m = calc_CI(P_rcp45_diffm);
CI_E_rcp45m = calc_CI(E_rcp45_diffm);
CI_Qin_rcp45m = calc_CI(Qin_rcp45_diffm);

% add multimodel CI to CI
CI_P_rcp45(length(CI_P_rcp45)+1,:) = CI_P_rcp45m;
CI_E_rcp45(length(CI_E_rcp45)+1,:) = CI_E_rcp45m;
CI_Qin_rcp45(length(CI_Qin_rcp45)+1,:) = CI_Qin_rcp45m;

% calculate multimodelmean difference
P_rcp45_diff_mean = nanmean(P_rcp45_diffm);
E_rcp45_diff_mean = nanmean(E_rcp45_diffm);
Qin_rcp45_diff_mean = nanmean(Qin_rcp45_diffm);

P_rcp45_diffm(length(P_rcp45_diffm)+1)=P_rcp45_diff_mean; 
E_rcp45_diffm(length(E_rcp45_diffm)+1)=E_rcp45_diff_mean; 
Qin_rcp45_diffm(length(Qin_rcp45_diffm)+1)=Qin_rcp45_diff_mean; 

legend_name_rcp45 = strcat(RCM_text_rcp45,GCM_rcp45);
legend_name_rcp45{nm_rcp45+1} = 'Multi-model mean';

WB_rcp45 = P_rcp45_diff_mean - E_rcp45_diff_mean + Qin_rcp45_diff_mean
% % -----------------------------------------------------------------------
% RCP 8.5
GCM_rcp85(:,1) = [{'CNRM-CM5'}   ; {'EC-EARTH'}   ; {'HadGEM2-ES'} ; {'MPI-ESM-LR'} ;  {'EC-EARTH'}   ;{'HadGEM2-ES'}     ;  {'CanESM2'}; {'CM5A-MR'}; {'CNRM-CM5'}; {'EC-EARTH'}; {'GFDL-ESM2M'}; {'HadGEM2-ES'}; {'MIROC5'}; {'MPI-ESM-LR'}; {'NorESM1-M'} ; {'CSIRO-Mk3-6-0'}; {'MPI-ESM-LR'} ; {'EC-EARTH'}   ; {'CM5A-LR'}    ];
RCM_text_rcp85(:,1) = [{'CCLM4-8-17 '}; {'CCLM4-8-17 '}; {'CCLM4-8-17 '}; {'CCLM4-8-17 '}; {'HIRHAM5 '} ; {'RACMO22T '} ;  {'RCA4 '}  ; {'RCA4 '}  ; {'RCA4 '}   ; {'RCA4 '}   ; {'RCA4 '}     ; {'RCA4 '}     ; {'RCA4 '} ; {'RCA4 '}     ; {'RCA4 '}     ; {'RCA4 '}        ; {'REMO2009 '}  ; {'REMO2009 '}  ; {'REMO2009 '}  ];

% calculate yearmeans
P_rcp85_tot = zeros(nm_rcp85,length(date_total)); 
E_rcp85_tot = zeros(nm_rcp85,length(date_total)); 
Qin_rcp85_tot = zeros(nm_rcp85,length(date_total)); 

for i = 1:nm_rcp85
    
        P_rcp85_tot(i,1:length(date_hist))=P_wb_hist(ind_rcp85(i),:); 
        P_rcp85_tot(i,length(date_hist)+1:length(date_total)) = P_wb_rcp85(i,:); 
        
        E_rcp85_tot(i,1:length(date_hist))=E_wb_hist(ind_rcp85(i),:); 
        E_rcp85_tot(i,length(date_hist)+1:length(date_total)) = E_wb_rcp85(i,:); 

        Qin_rcp85_tot(i,1:length(date_hist))=Qin_wb_hist(ind_rcp85(i),:); 
        Qin_rcp85_tot(i,length(date_hist)+1:length(date_total)) = Qin_wb_rcp85(i,:); 
  
    for t = 1:(length(years)-1)
        if t==(length(years)-1)
            P_rcp85_yearmean(i,t) = nanmean(P_rcp85_tot(i,(ind_year(t):ind_year(t)+364))); 
            E_rcp85_yearmean(i,t) = nanmean(E_rcp85_tot(i,(ind_year(t):(ind_year(t)+364)))); 
            Qin_rcp85_yearmean(i,t) = nanmean(Qin_rcp85_tot(i,(ind_year(t):(ind_year(t)+364)))); 
        else
          P_rcp85_yearmean(i,t) = nanmean(P_rcp85_tot(i,(ind_year(t):(ind_year(t+1)-1)))); 
          E_rcp85_yearmean(i,t) = nanmean(E_rcp85_tot(i,(ind_year(t):(ind_year(t+1)-1)))); 
          Qin_rcp85_yearmean(i,t) = nanmean(Qin_rcp85_tot(i,(ind_year(t):(ind_year(t+1)-1)))); 
        end
    end
    
    P_rcp85_histm(i,:)   = (P_rcp85_yearmean(i,hist_loc));
    P_rcp85_futm(i,:)    = (P_rcp85_yearmean(i,fut_loc));
    E_rcp85_histm(i,:)   = (E_rcp85_yearmean(i,hist_loc));
    E_rcp85_futm(i,:)    = (E_rcp85_yearmean(i,fut_loc));
    Qin_rcp85_histm(i,:) = (Qin_rcp85_yearmean(i,hist_loc));
    Qin_rcp85_futm(i,:)  = (Qin_rcp85_yearmean(i,fut_loc));
    

    
end
     title_rcp85 = 'RCP 8.5';

% % Calclate relative difference
P_rcp85_diff_abs = mean(mean(P_rcp85_futm-P_rcp85_histm))
E_rcp85_diff_abs = mean(mean(E_rcp85_futm-E_rcp85_histm))

P_rcp85_diff   = (P_rcp85_futm-P_rcp85_histm)./P_rcp85_histm *100 ;
E_rcp85_diff   = (E_rcp85_futm-E_rcp85_histm)./E_rcp85_histm *100 ;
Qin_rcp85_diff = (Qin_rcp85_futm-Qin_rcp85_histm)./Qin_rcp85_histm *100 ; 

for i = 1:nm_rcp85
    CI_P_rcp85(i,:) = calc_CI(P_rcp85_diff(i,:));
    CI_E_rcp85(i,:) = calc_CI(E_rcp85_diff(i,:));
    CI_Qin_rcp85(i,:) = calc_CI(Qin_rcp85_diff(i,:));
end

% Calclate difference mean
P_rcp85_diffm = mean(P_rcp85_diff,2); 
E_rcp85_diffm = mean(E_rcp85_diff,2); 
Qin_rcp85_diffm = mean(Qin_rcp85_diff,2);

% CI of multimodel mean
CI_P_rcp85m = calc_CI(P_rcp85_diffm);
CI_E_rcp85m = calc_CI(E_rcp85_diffm);
CI_Qin_rcp85m = calc_CI(Qin_rcp85_diffm);

% add multimodel CI to CI
CI_P_rcp85(length(CI_P_rcp85)+1,:) = CI_P_rcp85m;
CI_E_rcp85(length(CI_E_rcp85)+1,:) = CI_E_rcp85m;
CI_Qin_rcp85(length(CI_Qin_rcp85)+1,:) = CI_Qin_rcp85m;

% calculate multimodelmean difference
ind_rcp85 = [1, 2, 3, 4,5	9,	10,	11,	12,	13,	14,	15,	16,	17,	18,19,	21,	22,	23];

P_rcp85_diff_mean = nanmean(P_rcp85_diffm);
E_rcp85_diff_mean = nanmean(E_rcp85_diffm);
Qin_rcp85_diff_mean = nanmean(Qin_rcp85_diffm);

P_rcp85_diffm(length(P_rcp85_diffm)+1)=P_rcp85_diff_mean; 
E_rcp85_diffm(length(E_rcp85_diffm)+1)=E_rcp85_diff_mean; 
Qin_rcp85_diffm(length(Qin_rcp85_diffm)+1)=Qin_rcp85_diff_mean; 

legend_name_rcp85 = strcat(RCM_text_rcp85,GCM_rcp85);
legend_name_rcp85{nm_rcp85+1} = 'Multi-model mean';

% Calculations for John Marsham
% P_rcp85_histmean = mean(P_rcp85_histm,2);
% E_rcp85_histmean = mean(E_rcp85_histm,2);
% Qin_rcp85_histmean = mean(Qin_rcp85_histm,2);
% 
% P_rcp26_histmean = mean(P_rcp26_histm,2);
% E_rcp26_histmean = mean(E_rcp26_histm,2);
% Qin_rcp26_histmean = mean(Qin_rcp26_histm,2);
% 
% P_rcp45_histmean = mean(P_rcp45_histm,2);
% E_rcp45_histmean = mean(E_rcp45_histm,2);
% Qin_rcp45_histmean = mean(Qin_rcp45_histm,2);
% 
% 
% CF_P_rcp26 = P_rcp26_futm./P_rcp26_histmean*100; 
% CF_P_rcp45 = P_rcp45_futm./P_rcp45_histmean*100;
% CF_P_rcp85 = P_rcp85_futm./P_rcp85_histmean*100;
% 
% CF_E_rcp26 = E_rcp26_futm./E_rcp26_histmean*100; 
% CF_E_rcp45 = E_rcp45_futm./E_rcp45_histmean*100;
% CF_E_rcp85 = E_rcp85_futm./E_rcp85_histmean*100;
% 
% CF_Qin_rcp26 = Qin_rcp26_futm./Qin_rcp26_histmean*100; 
% CF_Qin_rcp45 = Qin_rcp45_futm./Qin_rcp45_histmean*100;
% CF_Qin_rcp85 = Qin_rcp85_futm./Qin_rcp85_histmean*100;
% 
% save change factors
% xlswrite('CF_CORDEX_P.xls',CF_P_rcp26','rcp26')
% xlswrite('CF_CORDEX_P.xls',CF_P_rcp45','rcp45')
% xlswrite('CF_CORDEX_P.xls',CF_P_rcp85','rcp85')
% 
% xlswrite('CF_CORDEX_E.xls',CF_E_rcp26','rcp26')
% xlswrite('CF_CORDEX_E.xls',CF_E_rcp45','rcp45')
% xlswrite('CF_CORDEX_E.xls',CF_E_rcp85','rcp85')
% 
% xlswrite('CF_CORDEX_Qin.xls',CF_Qin_rcp26','rcp26')
% xlswrite('CF_CORDEX_Qin.xls',CF_Qin_rcp45','rcp45')
% xlswrite('CF_CORDEX_Qin.xls',CF_Qin_rcp85','rcp85')



%% ------------------------------------------------------------------------
% Draw figure
figure1 = figure();
lengend_font = 11; 
label_font = 10; 
lim = [-100 100];
lim_85 = lim;
lim_45 = lim;
lim_26 = lim;
title_size = 12; 

[ha, pos] = tight_subplot(3,3,[.04 .04],[.2 .05],[.06 .01]);

%P rcp26
%subplot(3,3,1)
axes(ha(1)); 
bar(P_rcp26_diffm, 'FaceColor', P_color)
barwitherr(CI_P_rcp26,P_rcp26_diffm); 
set(gca, 'Fontsize', lengend_font,'xtick',([1:(nm_rcp26+1)]),'xticklabel',[],'xticklabelrotation',45); 
grid on
title('RCP 2.6','Fontsize', title_size, 'Fontweight', 'bold', 'Color', axcolor)
xlim([0 nm_rcp26+2])
ylabel('Lake precipitation (%)','Fontsize', label_font , 'Fontweight', 'Bold', 'color', axcolor)
ylim(lim_26)

% P_rcp45
%subplot(3,3,2)
axes(ha(2)); 
bar(P_rcp45_diffm, 'FaceColor', P_color)
barwitherr(CI_P_rcp45,P_rcp45_diffm); 
set(gca, 'Fontsize', lengend_font,'xtick',([1:(nm_rcp45+1)]),'xticklabel',[],'xticklabelrotation',45); 
grid on
title('RCP 4.5','Fontsize', title_size, 'Fontweight', 'bold', 'Color', axcolor)
xlim([0 nm_rcp45+2])
%ylabel('Precipitation (mm/year)','Fontsize', label_font , 'Fontweight', 'Bold', 'color', axcolor)
ylim(lim_45)


% P_rcp85
%subplot(3,3,3)
axes(ha(3)); 
bar(P_rcp85_diffm, 'FaceColor', P_color)
barwitherr(CI_P_rcp85,P_rcp85_diffm); 
set(gca, 'Fontsize', lengend_font,'xtick',([1:(nm_rcp85+1)]),'xticklabel',[],'xticklabelrotation',45); 
grid on
xlim([0 nm_rcp85+2])
title('RCP 8.5 ','Fontsize', title_size, 'Fontweight', 'bold', 'Color', axcolor)
%ylabel('Precipitation (mm/year)','Fontsize', label_font , 'Fontweight', 'Bold', 'color', axcolor)
ylim(lim_85)


% E_rcp26
%subplot(3,3,4)
axes(ha(4)); 
bar(E_rcp26_diffm, 'FaceColor', E_color)
hbar = barwitherr(CI_E_rcp26,E_rcp26_diffm); 
set(hbar,'FaceColor', E_color)
set(gca, 'Fontsize',lengend_font,'xtick',([1:(nm_rcp26+1)]),'xticklabel',[],'xticklabelrotation',45); 
grid on
xlim([0 nm_rcp26+2])
ylabel('Lake evaporation (%)','Fontsize', label_font , 'Fontweight', 'Bold', 'color', axcolor)
ylim(lim_26)

% E_rcp45
%subplot(3,3,5)
axes(ha(5)); 
bar(E_rcp45_diffm, 'FaceColor', E_color)
hbar = barwitherr(CI_E_rcp45,E_rcp45_diffm); 
set(hbar,'FaceColor', E_color)
set(gca, 'Fontsize',lengend_font,'xtick',([1:(nm_rcp45+1)]),'xticklabel',[],'xticklabelrotation',45); 
grid on
xlim([0 nm_rcp45+2])
%ylabel('Evaporation (mm/year)','Fontsize', label_font , 'Fontweight', 'Bold', 'color', axcolor)
ylim(lim_45)

% E_rcp85
%subplot(3,3,6)
axes(ha(6)); 
bar(E_rcp85_diffm, 'FaceColor', E_color)
hbar = barwitherr(CI_E_rcp85,E_rcp85_diffm); 
set(hbar,'FaceColor', E_color)
set(gca, 'Fontsize',lengend_font,'xtick',([1:(nm_rcp85+1)]),'xticklabel',[],'xticklabelrotation',45); 
grid on
xlim([0 nm_rcp85+2])
%ylabel('Evaporation (mm/year)','Fontsize', label_font , 'Fontweight', 'Bold', 'color', axcolor)
ylim(lim_85)


% Qin rcp26
%subplot(3,3,7)
axes(ha(7)); 
bar(Qin_rcp26_diffm, 'FaceColor', Qin_color);
hbar = barwitherr(CI_Qin_rcp26,Qin_rcp26_diffm); 
set(hbar,'FaceColor', Qin_color)
set(gca, 'Fontsize', lengend_font,'xtick',([1:(nm_rcp26+1)]),'xticklabel',legend_name_rcp26,'xticklabelrotation',45); 
grid on
ylabel('Inflow (%)','Fontsize', label_font , 'Fontweight', 'Bold', 'color', axcolor)
xlim([0 nm_rcp26+2])
ylim(lim_26)

% Qin rcp45
%subplot(3,3,8)
axes(ha(8)); 
bar(Qin_rcp45_diffm, 'FaceColor', Qin_color)
hbar = barwitherr(CI_Qin_rcp45,Qin_rcp45_diffm); 
set(hbar,'FaceColor', Qin_color)
set(gca, 'Fontsize', lengend_font,'xtick',([1:(nm_rcp45+1)]),'xticklabel',legend_name_rcp45,'xticklabelrotation',45); 
grid on
%ylabel('Inflow (mm/year)','Fontsize', label_font , 'Fontweight', 'Bold', 'color', axcolor)
xlim([0 nm_rcp45+2])
ylim(lim_45)

% Qin rcp85
%subplot(3,3,9)
axes(ha(9)); 
bar(Qin_rcp85_diffm); 
hbar = barwitherr(CI_Qin_rcp85,Qin_rcp85_diffm); 
set(hbar,'FaceColor', Qin_color)
set(gca, 'Fontsize',lengend_font,'xtick',([1:(nm_rcp85+1)]),'xticklabel',legend_name_rcp85,'xticklabelrotation',45); 
grid on
%ylabel('Inflow (mm/year)','Fontsize', label_font , 'Fontweight', 'Bold', 'color', axcolor)
xlim([0 nm_rcp85+2])
ylim(lim_85)

% Put numbers next to bars which are out of range. 
fontsize = 9;
if flag_bc == 0
%     % E rcp 26
%     annotation(figure1,'textbox',...
%     [0.239375 0.430666666666666 0.0401458333333333 0.030982905982906],...
%     'String',round(E_rcp26_diff(9)*365*1000),...
%     'LineStyle','none',...
%     'FontSize',fontsize,...
%     'FontWeight','bold',...
%     'Color',axcolor,...
%     'FitBoxToText','off');
% 
% % P rcp 45
% annotation(figure1,'textbox',...
%     [0.396625 0.701923076923077 0.0437916666666672 0.0192307692307691],...
%     'String',round(P_rcp45_diff(2)*365*1000),...
%     'LineStyle','none',...
%     'FontSize',fontsize,...
%     'FontWeight','bold',...
%     'Color',axcolor,...
%     'FitBoxToText','off');
% % P rcp85
%     annotation(figure1,'textbox',...
%     [0.720531249999999 0.701388888888888 0.0232187500000012 0.0192307692307691],...
%     'String',round(P_rcp85_diff(2)*365*1000),...
%     'LineStyle','none',...
%     'FontWeight','bold',...
%     'Color',axcolor,...
%     'FontSize',fontsize,...
%     'FitBoxToText','off');

% annotation(figure1,'textbox',...
%     [0.951 0.951923076923077 0.0297291666666668 0.0245726495726496],...
%     'String',round(P_rcp85_diff(18)*365*1000),...
%     'LineStyle','none',...
%     'FontWeight','bold',...
%     'Color',axcolor,...
%     'FontSize',fontsize,...
%     'FitBoxToText','off');
    
%     % P rcp85 
%         annotation(figure1,'textbox',...
%     [0.720531249999999 0.699307692307692 0.0232187500000012 0.0192307692307691],...
%     'String',round(P_rcp85_diff(2)*365*1000),...
%     'LineStyle','none',...
%     'FontWeight','bold',...
%     'Color',axcolor,...
%     'FontSize',fontsize,...
%     'FitBoxToText','off');
% 
% annotation(figure1,'textbox',...
%     [0.935375 0.692307692307692 0.0172291666666666 0.0245726495726497],...
%     'String',round(P_rcp85_diff(17)*365*1000),...
%     'LineStyle','none',...
%     'FontWeight','bold',...
%     'Color',axcolor,...
%     'FontSize',fontsize,...
%     'FitBoxToText','off');
% % E rcp 85
%     annotation(figure1,'textbox',...
%     [0.935635416666666 0.43826923076923 0.0172291666666666 0.0245726495726497],...
%     'String',round(E_rcp85_diff(17)*365*1000),...
%     'LineStyle','none',...
%     'FontSize',fontsize,...
%     'FontWeight','bold',...
%     'Color',axcolor,...
%     'FitBoxToText','off');
% 
 elseif flag_bc >0
     

%    % E rcp 85
%     annotation(figure1,'textbox',...
%     [0.935635416666666 0.43826923076923 0.0172291666666666 0.0245726495726497],...
%     'String',round(E_rcp85_diff(17)*365*1000),...
%     'LineStyle','none',...
%     'FontSize',fontsize,...
%     'FontWeight','bold',...
%     'Color',axcolor,...
%     'FitBoxToText','off');
%  
 end

% create annotations
annotation(figure1,'textbox',...
    [0.0619375 0.928418803418803 0.0125416666666667 0.0181623931623929],'String','a)',...
    'LineStyle','none',...
    'Color', axcolor, ....
    'FontWeight','bold',...
    'FitBoxToText','off');

annotation(figure1,'textbox',...
    [0.384333333333333 0.92094017094017 0.0120208333333333 0.0256410256410255],...
    'String','b)',...
    'Color', axcolor, ....
    'LineStyle','none',...
    'FontWeight','bold',...
    'FitBoxToText','off');

annotation(figure1,'textbox',...
    [0.705427083333332 0.91826923076923 0.0130624999999999 0.0288461538461537],...
    'String','c)',...
    'Color', axcolor, ....
    'LineStyle','none',...
    'FontWeight','bold',...
    'FitBoxToText','off');

annotation(figure1,'textbox',...
    [0.0614166666666666 0.66559829059829 0.0109791666666667 0.0213675213675217],...
    'String','d)',...
    'Color', axcolor, ....
    'LineStyle','none',...
    'FontWeight','bold',...
    'FitBoxToText','off');

annotation(figure1,'textbox',...
    [0.384333333333333 0.659188034188034 0.0109791666666667 0.0245726495726493],...
    'String','e)',...
    'Color', axcolor, ....
    'LineStyle','none',...
    'FontWeight','bold',...
    'FitBoxToText','off');

annotation(figure1,'textbox',...
    [0.708812499999999 0.66025641025641 0.0109791666666667 0.024572649572649],...
    'String','f)',...
    'Color', axcolor, ....
    'LineStyle','none',...
    'FontWeight','bold',...
    'FitBoxToText','off');

annotation(figure1,'textbox',...
    [0.0619375  0.39636752136752 0.0109791666666666 0.024572649572649],...
    'String','g)',...
    'Color', axcolor, ....
    'LineStyle','none',...
    'FontWeight','bold',...
    'FitBoxToText','off');
annotation(figure1,'textbox',...
    [0.382249999999999 0.395299145299144 0.0109791666666666 0.024572649572649],...
    'String','h)',...
    'Color', axcolor, ....
    'LineStyle','none',...
    'FontWeight','bold',...
    'FitBoxToText','off');

annotation(figure1,'textbox',...
    [0.707249999999999 0.397435897435897 0.0109791666666667 0.024572649572649],...
    'String','i)',...
    'Color', axcolor, ....
    'LineStyle','none',...
    'FontWeight','bold',...
    'FitBoxToText','off');