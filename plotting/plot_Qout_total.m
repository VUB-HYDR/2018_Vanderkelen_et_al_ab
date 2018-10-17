% % ------------------------------------------------------------------------
% Plot Qout over whole period with all scenarios (in subplots)
% in progress
% ------------------------------------------------------------------------

% flags 
flag_bc = 2;  % 1: QUANT bias correction, 2: PFT bias correction

% define percentiles
prct_low = 5; 
prct_high = 95; 

% plotting variables
legend_size = 12; 
title_size = 14; 
label_size = 12; 
ylabel_size=12; 
% initialisation

% labels
years = unique(date_fut(:,1));  
temp_futyears = date_fut(:,1); 
yearfut = time_begin_fut-1:5:time_end_fut+1; 
yearfut(1) = time_begin_fut(1); 
[~, year_loc_fut] = ismember(yearfut,temp_futyears);
labels_fut = {'2006','2010','2015','2020','2025','2030','2035','2040','2045','2050',...
    '2055', '2060','2065', '2070','2075','2080','2085','2090','2095','2100'};
yearfut(length(yearfut)) = time_end_fut(1); 
[~, year_loc_fut_sing] = ismember(yearfut,years);

figure1 = figure();
 
for t = 1:length(years)
    [~, ind_year(t)] = ismember(years(t),date_fut(:,1)); 
end


%% subplot 1: outflow agreed curve
subplot(2,1,1)
if flag_bc == 1 % QUANT 
    load Qout_rcp85_ac_QUANT.mat 
    load Qout_rcp45_ac_QUANT.mat 
    load Qout_rcp26_ac_QUANT.mat  
elseif flag_bc ==2 % PFT
    load Qout_rcp85_ac_PFT.mat 
    load Qout_rcp45_ac_PFT.mat
    load Qout_rcp26_ac_PFT.mat 
end

% remove HIRHAM
n_HIRHAM = 5; 
Qout_rcp45ii = exclude_sim(Qout_rcp45,n_HIRHAM); 
Qout_rcp85i = exclude_sim(Qout_rcp85,n_HIRHAM);
clear Qout_rcp45 Qout_rcp85
Qout_rcp45 = Qout_rcp45ii;
Qout_rcp85 = Qout_rcp85i; 

% manipulate
nm_rcp45 = size(Qout_rcp45,1); 
nm_rcp26 = size(Qout_rcp26,1);
nm_rcp85 = size(Qout_rcp85,1);

% calculate annual mean outflow
for i = 1:nm_rcp26
    for t = 1:(length(years)-1)
             Qout_yearmean_rcp26(i,t) = nanmean(Qout_rcp26(i,(ind_year(t):(ind_year(t+1)-1)))); 
    end 
end
for i = 1:nm_rcp45
    for t = 1:(length(years)-1)
             Qout_yearmean_rcp45(i,t) = nanmean(Qout_rcp45(i,(ind_year(t):(ind_year(t+1)-1)))); 
    end 
end
for i = 1:nm_rcp85
    for t = 1:(length(years)-1)
             Qout_yearmean_rcp85(i,t) = nanmean(Qout_rcp85(i,(ind_year(t):(ind_year(t+1)-1)))); 
    end 
end
 
% calculate difference with historical outflow
Qout_hist = 88; 
Qout_rcp26_m = mean(Qout_yearmean_rcp26,1)./10^6
Qout_rcp45_m = mean(Qout_yearmean_rcp45,1)./10^6
Qout_rcp85_m = mean(Qout_yearmean_rcp85,1)./10^6

diff_rcp26 = mean(Qout_rcp26_m) - Qout_hist
diff_rcp45 = mean(Qout_rcp45_m) - Qout_hist
diff_rcp85 = mean(Qout_rcp85_m) - Qout_hist

% define ranges
min_Qout_yearmean_rcp45 = prctile(Qout_yearmean_rcp45,[prct_low],1); 
min_Qout_yearmean_rcp85= prctile(Qout_yearmean_rcp85,[prct_low],1); 
min_Qout_yearmean_rcp26 = prctile(Qout_yearmean_rcp26,[prct_low],1); 

max_Qout_yearmean_rcp85 = prctile(Qout_yearmean_rcp85,[prct_high],1);    
max_Qout_yearmean_rcp45 = prctile(Qout_yearmean_rcp45,[prct_high],1);     
max_Qout_yearmean_rcp26 = prctile(Qout_yearmean_rcp26,[prct_high],1); 

% calculate range on end of period
diff_Qout_rcp26_ac = max_Qout_yearmean_rcp26(length(max_Qout_yearmean_rcp26)) - min_Qout_yearmean_rcp26(length(max_Qout_yearmean_rcp26)) 
diff_Qout_rcp45_ac = max_Qout_yearmean_rcp45(length(max_Qout_yearmean_rcp26)) - min_Qout_yearmean_rcp45(length(max_Qout_yearmean_rcp26))
diff_Qout_rcp85_ac  = max(max_Qout_yearmean_rcp85 - min_Qout_yearmean_rcp85)
diff_mean =  max(max_Qout_yearmean_rcp85)/((mean(mean(Qout_yearmean_rcp26)) + mean(mean(Qout_yearmean_rcp45)) + mean(mean(Qout_yearmean_rcp85)))/3)...
; 

diff_abs = max(diff_Qout_rcp85_ac); 


Qout_average = (mean(mean(Qout_yearmean_rcp26)) + mean(mean(Qout_yearmean_rcp45)) + mean(mean(Qout_yearmean_rcp85)))/3

Qout_mean_ac_rcp26 = std(Qout_rcp26,1);
Qout_mean_ac_rcp45 = std(Qout_rcp45,1);
Qout_mean_ac_rcp85 = std(Qout_rcp85,1);

Qout_ac_m = (Qout_mean_ac_rcp26 +Qout_mean_ac_rcp45 +Qout_mean_ac_rcp85)/3; 
Qout_ac_std = mean(Qout_ac_m)
mean_Qout_ac = (Qout_yearmean_rcp26(length(Qout_yearmean_rcp26))+ ...
Qout_yearmean_rcp45(length(Qout_yearmean_rcp45))+ Qout_yearmean_rcp85(length(Qout_yearmean_rcp85)))/3;

mean(diff_abs./Qout_average)*100
% calculate how often outflow is above capacity of turbines (so we have
% overflow)
Qmax_nalu = 1200* (60*60*24); % [m³/day] (turbines; Kizza et al., 2006  )
Qmax_kiira = 1100* (60*60*24); % [m³/day] (turbines; Kizza et al., 2006  )
Qmax_mean = (Qmax_nalu + Qmax_kiira)/2 ;

Qout_mean_rcp26 = nanmean(Qout_rcp26,2); 
Qout_overfl_rcp26 = Qout_mean_rcp26-Qmax_mean; 
days_overfl_rcp26 = sum(Qout_overfl_rcp26>0)

Qout_mean_rcp45 = nanmean(Qout_rcp45,2); 
Qout_overfl_rcp45 = Qout_mean_rcp45-Qmax_mean; 
days_overfl_rcp45 = sum(Qout_overfl_rcp45>0)

Qout_mean_rcp85 = nanmean(Qout_rcp85,2); 
Qout_overfl_rcp85 = Qout_mean_rcp85-Qmax_mean; 
days_overfl_rcp85 = sum(Qout_overfl_rcp85>0)
vol_overfl_rcp85 = sum(Qout_overfl_rcp85(find(Qout_overfl_rcp85>0)))

% plot
x = 1:length(min_Qout_yearmean_rcp26); 
x2 = [x, fliplr(x)];

% rcp26
range_rcp26 = [min_Qout_yearmean_rcp26, fliplr(max_Qout_yearmean_rcp26)];
f1 = fill(x2, range_rcp26*10^-6, blue_range);
set(f1,'facealpha',.5)
hold on
plot(min_Qout_yearmean_rcp26*10^-6,'Color',blue_range)
plot(max_Qout_yearmean_rcp26*10^-6,'Color',blue_range)

% rcp 45
range_rcp45 = [min_Qout_yearmean_rcp45, fliplr(max_Qout_yearmean_rcp45)];
f2 = fill(x2, range_rcp45*10^-6, green_range);
set(f2,'facealpha',.5)
plot(min_Qout_yearmean_rcp45*10^-6,'Color',green_range)
plot(max_Qout_yearmean_rcp45*10^-6,'Color',green_range)

% rcp 85
range_rcp85 = [min_Qout_yearmean_rcp85, fliplr(max_Qout_yearmean_rcp85)];
f3=fill(x2, range_rcp85*10^-6, red_range);
set(f3,'facealpha',.5)
plot(min_Qout_yearmean_rcp85*10^-6,'Color',red_range)
plot(max_Qout_yearmean_rcp85*10^-6,'Color',red_range)

% plot multimodel means
h2 = plot(mean(Qout_yearmean_rcp45,1)*10^-6,'Color',green,'linewidth',2);
h3 = plot(mean(Qout_yearmean_rcp85,1)*10^-6,'Color',red,'linewidth',2);
h1 = plot(mean(Qout_yearmean_rcp26,1)*10^-6,'Color',blue,'linewidth',2);

title_name = 'Agreed Curve scenario'; 

legend([h1 h2 h3],'RCP 2.6', 'RCP 4.5', 'RCP 8.5')
set(legend,'Fontweight', 'Bold', 'Fontsize', legend_size, 'TextColor', axcolor,'Location', 'northeast');
hold off
title(title_name,'Fontsize', title_size, 'Fontweight', 'Bold', 'color', axcolor)

set(gca, 'Fontsize', label_size, 'Fontweight', 'Bold','Xcolor', axcolor,...
        'Ycolor', axcolor,'xtick',[year_loc_fut_sing],'xticklabel',labels_fut,'xticklabelrotation',45); 
%set(gca, 'Fontsize', 11, 'Fontweight', 'Bold','Xcolor', axcolor,...
     %   'Ycolor', axcolor,'xtick',[year_loc_ev],'xticklabel',labels_ev,'xticklabelrotation',45); 
ylabel('outlfow (10^6 m^3/day)','Fontsize', ylabel_size, 'Fontweight', 'Bold', 'color', axcolor)
    grid on
xlim([1 length(years)-1])    
ylim([0 300])

%% subplot 3: outflow following historical HPP
% load
subplot(2,1,2)
if flag_bc == 1 % QUANT 
    load Qout_rcp85_HPP_hist_QUANT.mat 
    load Qout_rcp45_HPP_hist_QUANT.mat 
    load Qout_rcp26_HPP_hist_QUANT.mat  
    title_large = ' ';
elseif flag_bc ==2 % PFT
    load Qout_rcp85_HPP_hist_PFT.mat 
    load Qout_rcp45_HPP_hist_PFT.mat
    load Qout_rcp26_HPP_hist_PFT.mat 
        title_large = ' ';

end

% remove HIRHAM
n_HIRHAM = 5; 
n_HIRHAM8 = 7; 
Qout_rcp45ii = exclude_sim(Qout_rcp45,n_HIRHAM); 
Qout_rcp45i = exclude_sim(Qout_rcp45ii,n_HIRHAM8); 

Qout_rcp85i = exclude_sim(Qout_rcp85,n_HIRHAM);
clear Qout_rcp45 Qout_rcp85
Qout_rcp45 = Qout_rcp45i;
Qout_rcp85 = Qout_rcp85i; 

% manipulate
nm_rcp45 = size(Qout_rcp45,1); 
nm_rcp26 = size(Qout_rcp26,1);
nm_rcp85 = size(Qout_rcp85,1);

% calculate annual mean outflow
for i = 1:nm_rcp26
    for t = 1:(length(years)-1)
             Qout_yearmean_rcp26(i,t) = nanmean(Qout_rcp26(i,(ind_year(t):(ind_year(t+1)-1)))); 
    end 
end
for i = 1:nm_rcp45
    for t = 1:(length(years)-1)
             Qout_yearmean_rcp45(i,t) = nanmean(Qout_rcp45(i,(ind_year(t):(ind_year(t+1)-1)))); 
    end 
end
for i = 1:nm_rcp85
    for t = 1:(length(years)-1)
             Qout_yearmean_rcp85(i,t) = nanmean(Qout_rcp85(i,(ind_year(t):(ind_year(t+1)-1)))); 
    end 
end
 
% define ranges
min_Qout_yearmean_rcp45 = prctile(Qout_yearmean_rcp45,[prct_low],1); 
min_Qout_yearmean_rcp85= prctile(Qout_yearmean_rcp85,[prct_low],1); 
min_Qout_yearmean_rcp26 = prctile(Qout_yearmean_rcp26,[prct_low],1); 

max_Qout_yearmean_rcp85 = prctile(Qout_yearmean_rcp85,[prct_high],1);    
max_Qout_yearmean_rcp45 = prctile(Qout_yearmean_rcp45,[prct_high],1);     
max_Qout_yearmean_rcp26 = prctile(Qout_yearmean_rcp26,[prct_high],1); 

% calculate difference on end of period
diff_Qout_rcp26_ac = max_Qout_yearmean_rcp26(length(max_Qout_yearmean_rcp26)) - min_Qout_yearmean_rcp26(length(max_Qout_yearmean_rcp26)) 
diff_Qout_rcp45_ac = max_Qout_yearmean_rcp45(length(max_Qout_yearmean_rcp26)) - min_Qout_yearmean_rcp45(length(max_Qout_yearmean_rcp26))
diff_Qout_rcp85_ac = max_Qout_yearmean_rcp85(length(max_Qout_yearmean_rcp26)) - min_Qout_yearmean_rcp85(length(max_Qout_yearmean_rcp26))
(mean(mean(Qout_yearmean_rcp26)) + mean(mean(Qout_yearmean_rcp45)) + mean(mean(Qout_yearmean_rcp85)))/3

Qout_mean_ac_rcp26 = mean(Qout_yearmean_rcp26,1);
Qout_mean_ac_rcp45 = mean(Qout_yearmean_rcp45,1);
Qout_mean_ac_rcp85 = mean(Qout_yearmean_rcp85,1);

mean_Qout_ac = (Qout_yearmean_rcp26(length(Qout_yearmean_rcp26))+ ...
Qout_yearmean_rcp45(length(Qout_yearmean_rcp45))+ Qout_yearmean_rcp85(length(Qout_yearmean_rcp85)))/3;

% plot
x = 1:length(min_Qout_yearmean_rcp26); 
x2 = [x, fliplr(x)];

% rcp26
range_rcp26 = [min_Qout_yearmean_rcp26, fliplr(max_Qout_yearmean_rcp26)];
f1 = fill(x2, range_rcp26*10^-6, blue_range);
set(f1,'facealpha',.5)
hold on
plot(min_Qout_yearmean_rcp26*10^-6,'Color',blue_range)
plot(max_Qout_yearmean_rcp26*10^-6,'Color',blue_range)

% rcp 45
range_rcp45 = [min_Qout_yearmean_rcp45, fliplr(max_Qout_yearmean_rcp45)];
f2 = fill(x2, range_rcp45*10^-6, green_range);
set(f2,'facealpha',.5)
plot(min_Qout_yearmean_rcp45*10^-6,'Color',green_range)
plot(max_Qout_yearmean_rcp45*10^-6,'Color',green_range)

% rcp 85
range_rcp85 = [min_Qout_yearmean_rcp85, fliplr(max_Qout_yearmean_rcp85)];
f3=fill(x2, range_rcp85*10^-6, red_range);
set(f3,'facealpha',.5)
plot(min_Qout_yearmean_rcp85*10^-6,'Color',red_range)
plot(max_Qout_yearmean_rcp85*10^-6,'Color',red_range)

% plot multimodel means
h2 = plot(mean(Qout_yearmean_rcp45,1)*10^-6,'Color',green,'linewidth',2);
h3 = plot(mean(Qout_yearmean_rcp85,1)*10^-6,'Color',red,'linewidth',2);
h1 = plot(mean(Qout_yearmean_rcp26,1)*10^-6,'Color',blue,'linewidth',2);

title_name = 'Historical hydropower scenario'; 

%legend([h1 h2 h3],'RCP 2.6', 'RCP 4.5', 'RCP 8.5')
%set(legend,'Fontweight', 'Bold', 'Fontsize', legend_size, 'TextColor', axcolor,'Location', 'northeast');
hold off
title(title_name,'Fontsize', title_size, 'Fontweight', 'Bold', 'color', axcolor)

set(gca, 'Fontsize', label_size, 'Fontweight', 'Bold','Xcolor', axcolor,...
        'Ycolor', axcolor,'xtick',[year_loc_fut_sing],'xticklabel',labels_fut,'xticklabelrotation',45); 
%set(gca, 'Fontsize', 11, 'Fontweight', 'Bold','Xcolor', axcolor,...
     %   'Ycolor', axcolor,'xtick',[year_loc_ev],'xticklabel',labels_ev,'xticklabelrotation',45); 
ylabel('outlfow (10^6 m^3/day)','Fontsize', ylabel_size, 'Fontweight', 'Bold', 'color', axcolor)
    grid on
xlim([1 length(years)-1])    
ylim([0 300])


% annotations and title

annotation(figure1,'textbox',...
    [0.13225 0.895299145299145 0.0161875 0.032051282051282],'String','a)',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',14,...
    'Color', axcolor, ...
    'FitBoxToText','off');

annotation(figure1,'textbox',...
    [0.133552083333333 0.418269230769231 0.0161875 0.032051282051282],...
    'String','c)',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',14,...
    'Color', axcolor, ...
    'FitBoxToText','off');

[ax,h]=subtitle(title_large); 
    h.FontWeight = 'Bold';
    h.FontSize =  14;
    h.Color = axcolor; 
%% subplot 2: outflow following constant lake level
% load
figure2 = figure()
subplot(2,1,1)

% load
if flag_bc == 1 % QUANT 
    load Qout_rcp85_cstL_QUANT.mat 
    load Qout_rcp45_cstL_QUANT.mat 
    load Qout_rcp26_cstL_QUANT.mat 
    
elseif flag_bc ==2 % PFT
    load Qout_rcp85_cstL_PFT.mat 
    load Qout_rcp45_cstL_PFT.mat 
    load Qout_rcp26_cstL_PFT.mat

end

% remove HIRHAM 
n_HIRHAM = 5; 
Qout_rcp45ii = exclude_sim(Qout_rcp45,n_HIRHAM); 
Qout_rcp85i = exclude_sim(Qout_rcp85,n_HIRHAM);
clear Qout_rcp45 Qout_rcp85
Qout_rcp45 = Qout_rcp45ii;
Qout_rcp85 = Qout_rcp85i; 


% manipulate
nm_rcp45 = size(Qout_rcp45,1); 
nm_rcp26 = size(Qout_rcp26,1);
nm_rcp85 = size(Qout_rcp85,1);

% calculate annual mean outflow
for i = 1:nm_rcp26
    for t = 1:(length(years)-1)
             Qout_yearmean_rcp26(i,t) = nanmean(Qout_rcp26(i,(ind_year(t):(ind_year(t+1)-1)))); 
    end 
end
for i = 1:nm_rcp45
    for t = 1:(length(years)-1)
             Qout_yearmean_rcp45(i,t) = nanmean(Qout_rcp45(i,(ind_year(t):(ind_year(t+1)-1)))); 
    end 
end
for i = 1:nm_rcp85
    for t = 1:(length(years)-1)
             Qout_yearmean_rcp85(i,t) = nanmean(Qout_rcp85(i,(ind_year(t):(ind_year(t+1)-1)))); 
    end 
end
 
% define ranges
min_Qout_yearmean_rcp45 = prctile(Qout_yearmean_rcp45,[prct_low],1); 
min_Qout_yearmean_rcp85= prctile(Qout_yearmean_rcp85,[prct_low],1); 
min_Qout_yearmean_rcp26 = prctile(Qout_yearmean_rcp26,[prct_low],1); 

max_Qout_yearmean_rcp85 = prctile(Qout_yearmean_rcp85,[prct_high],1);    
max_Qout_yearmean_rcp45 = prctile(Qout_yearmean_rcp45,[prct_high],1);     
max_Qout_yearmean_rcp26 = prctile(Qout_yearmean_rcp26,[prct_high],1); 

%calculate difference

diff_Qout_rcp26_cstL = max(max_Qout_yearmean_rcp26() - min_Qout_yearmean_rcp26()) 
diff_Qout_rcp45_cstL = max(max_Qout_yearmean_rcp45() - min_Qout_yearmean_rcp45)
diff_Qout_rcp85_cstL = max(max_Qout_yearmean_rcp85() - min_Qout_yearmean_rcp85())
Qout_yearmean_rcp26(length(Qout_yearmean_rcp26));
Qout_yearmean_rcp45(length(Qout_yearmean_rcp45));
Qout_yearmean_rcp85(length(Qout_yearmean_rcp85));

Qout_std_cst_rcp26 = std(Qout_rcp26,1);
Qout_std_cst_rcp45 = std(Qout_rcp45,1);
Qout_std_cst_rcp85 = std(Qout_rcp85,1);

Qout_mean_cst_rcp26 = mean(mean(Qout_rcp26,1))
Qout_mean_cst_rcp45 = mean(mean(Qout_rcp45,1))
Qout_mean_cst_rcp85 = mean(mean(Qout_rcp85,1))
Qout_cst_m = (Qout_std_cst_rcp26 +Qout_std_cst_rcp45 +Qout_std_cst_rcp85)/3; 
Qout_cst_stdmean = mean(Qout_cst_m)

%Qout_mean_l = (mean(Qout_mean_l_rcp26)+mean(Qout_mean_l_rcp45)+mean(Qout_mean_l_rcp85))/3
% plot
x = 1:length(min_Qout_yearmean_rcp26); 
x2 = [x, fliplr(x)];

% rcp26
range_rcp26 = [min_Qout_yearmean_rcp26, fliplr(max_Qout_yearmean_rcp26)];
f1 = fill(x2, range_rcp26*10^-6, blue_range);
set(f1,'facealpha',.5)
hold on
plot(min_Qout_yearmean_rcp26*10^-6,'Color',blue_range)
plot(max_Qout_yearmean_rcp26*10^-6,'Color',blue_range)

% rcp 45
range_rcp45 = [min_Qout_yearmean_rcp45, fliplr(max_Qout_yearmean_rcp45)];
f2 = fill(x2, range_rcp45*10^-6, green_range);
set(f2,'facealpha',.5)
plot(min_Qout_yearmean_rcp45*10^-6,'Color',green_range)
plot(max_Qout_yearmean_rcp45*10^-6,'Color',green_range)

% rcp 85
range_rcp85 = [min_Qout_yearmean_rcp85, fliplr(max_Qout_yearmean_rcp85)];
f3=fill(x2, range_rcp85*10^-6, red_range);
set(f3,'facealpha',.5)
plot(min_Qout_yearmean_rcp85*10^-6,'Color',red_range)
plot(max_Qout_yearmean_rcp85*10^-6,'Color',red_range)

% plot multimodel means
h2 = plot(mean(Qout_yearmean_rcp45,1)*10^-6,'Color',green,'linewidth',2);
h3 = plot(mean(Qout_yearmean_rcp85,1)*10^-6,'Color',red,'linewidth',2);
h1 = plot(mean(Qout_yearmean_rcp26,1)*10^-6,'Color',blue,'linewidth',2);

title_name = 'Constant lake level scenario'; 

%legend([h1 h2 h3],'RCP 2.6', 'RCP 4.5', 'RCP 8.5')
%set(legend,'Fontweight', 'Bold', 'Fontsize', legend_size, 'TextColor', axcolor,'Location','northwest');
hold off
title(title_name,'Fontsize', title_size, 'Fontweight', 'Bold', 'color', axcolor)

set(gca, 'Fontsize', label_size, 'Fontweight', 'Bold','Xcolor', axcolor,...
        'Ycolor', axcolor,'xtick',[year_loc_fut_sing],'xticklabel',labels_fut,'xticklabelrotation',45); 
%set(gca, 'Fontsize', 11, 'Fontweight', 'Bold','Xcolor', axcolor,...
     %   'Ycolor', axcolor,'xtick',[year_loc_ev],'xticklabel',labels_ev,'xticklabelrotation',45); 
ylabel('outlfow (10^6 m^3/day)','Fontsize', ylabel_size, 'Fontweight', 'Bold', 'color', axcolor)
    grid on
xlim([1 length(years)-1])    
ylim([0 300])


%% subplot 4: max HPP
% load
subplot(2,1,2)
if flag_bc == 1 % QUANT 
    load Qout_rcp85_HPP_max_QUANT.mat 
    load Qout_rcp45_HPP_max_QUANT.mat 
    load Qout_rcp26_HPP_max_QUANT.mat  
elseif flag_bc ==2 % PFT
    load Qout_rcp85_HPP_max_PFT.mat 
    load Qout_rcp45_HPP_max_PFT.mat
    load Qout_rcp26_HPP_max_PFT.mat 
end

% remove HIRHAM
n_HIRHAM = 5; 
Qout_rcp45ii = exclude_sim(Qout_rcp45,n_HIRHAM); 
Qout_rcp85i = exclude_sim(Qout_rcp85,n_HIRHAM);
clear Qout_rcp45 Qout_rcp85
Qout_rcp45 = Qout_rcp45ii;
Qout_rcp85 = Qout_rcp85i; 


% manipulate
nm_rcp45 = size(Qout_rcp45,1); 
nm_rcp26 = size(Qout_rcp26,1);
nm_rcp85 = size(Qout_rcp85,1);

% calculate annual mean outflow
for i = 1:nm_rcp26
    for t = 1:(length(years)-1)
             Qout_yearmean_rcp26(i,t) = nanmean(Qout_rcp26(i,(ind_year(t):(ind_year(t+1)-1)))); 
    end 
end
for i = 1:nm_rcp45
    for t = 1:(length(years)-1)
             Qout_yearmean_rcp45(i,t) = nanmean(Qout_rcp45(i,(ind_year(t):(ind_year(t+1)-1)))); 
    end 
end
for i = 1:nm_rcp85
    for t = 1:(length(years)-1)
             Qout_yearmean_rcp85(i,t) = nanmean(Qout_rcp85(i,(ind_year(t):(ind_year(t+1)-1)))); 
    end 
end
 
% define ranges
min_Qout_yearmean_rcp45 = prctile(Qout_yearmean_rcp45,[prct_low],1); 
min_Qout_yearmean_rcp85= prctile(Qout_yearmean_rcp85,[prct_low],1); 
min_Qout_yearmean_rcp26 = prctile(Qout_yearmean_rcp26,[prct_low],1); 

max_Qout_yearmean_rcp85 = prctile(Qout_yearmean_rcp85,[prct_high],1);    
max_Qout_yearmean_rcp45 = prctile(Qout_yearmean_rcp45,[prct_high],1);     
max_Qout_yearmean_rcp26 = prctile(Qout_yearmean_rcp26,[prct_high],1); 

% calculate difference on end of period
diff_Qout_rcp26_ac = max_Qout_yearmean_rcp26(length(max_Qout_yearmean_rcp26)) - min_Qout_yearmean_rcp26(length(max_Qout_yearmean_rcp26)) 
diff_Qout_rcp45_ac = max_Qout_yearmean_rcp45(length(max_Qout_yearmean_rcp26)) - min_Qout_yearmean_rcp45(length(max_Qout_yearmean_rcp26))
diff_Qout_rcp85_ac = max_Qout_yearmean_rcp85(length(max_Qout_yearmean_rcp26)) - min_Qout_yearmean_rcp85(length(max_Qout_yearmean_rcp26))
(mean(mean(Qout_yearmean_rcp26)) + mean(mean(Qout_yearmean_rcp45)) + mean(mean(Qout_yearmean_rcp85)))/3

Qout_mean_ac_rcp26 = mean(Qout_yearmean_rcp26,1);
Qout_mean_ac_rcp45 = mean(Qout_yearmean_rcp45,1);
Qout_mean_ac_rcp85 = mean(Qout_yearmean_rcp85,1);

mean_Qout_ac = (Qout_yearmean_rcp26(length(Qout_yearmean_rcp26))+ ...
Qout_yearmean_rcp45(length(Qout_yearmean_rcp45))+ Qout_yearmean_rcp85(length(Qout_yearmean_rcp85)))/3;

% plot
x = 1:length(min_Qout_yearmean_rcp26); 
x2 = [x, fliplr(x)];

% rcp26
range_rcp26 = [min_Qout_yearmean_rcp26, fliplr(max_Qout_yearmean_rcp26)];
f1 = fill(x2, range_rcp26*10^-6, blue_range);
set(f1,'facealpha',.5)
hold on
plot(min_Qout_yearmean_rcp26*10^-6,'Color',blue_range)
plot(max_Qout_yearmean_rcp26*10^-6,'Color',blue_range)

% rcp 45
range_rcp45 = [min_Qout_yearmean_rcp45, fliplr(max_Qout_yearmean_rcp45)];
f2 = fill(x2, range_rcp45*10^-6, green_range);
set(f2,'facealpha',.5)
plot(min_Qout_yearmean_rcp45*10^-6,'Color',green_range)
plot(max_Qout_yearmean_rcp45*10^-6,'Color',green_range)

% rcp 85
range_rcp85 = [min_Qout_yearmean_rcp85, fliplr(max_Qout_yearmean_rcp85)];
f3=fill(x2, range_rcp85*10^-6, red_range);
set(f3,'facealpha',.5)
plot(min_Qout_yearmean_rcp85*10^-6,'Color',red_range)
plot(max_Qout_yearmean_rcp85*10^-6,'Color',red_range)

% plot multimodel means
h2 = plot(mean(Qout_yearmean_rcp45,1)*10^-6,'Color',green,'linewidth',2);
h3 = plot(mean(Qout_yearmean_rcp85,1)*10^-6,'Color',red,'linewidth',2);
h1 = plot(mean(Qout_yearmean_rcp26,1)*10^-6,'Color',blue,'linewidth',2);

title_name = 'High hydropower scenario'; 


hold off
title(title_name,'Fontsize', title_size, 'Fontweight', 'Bold', 'color', axcolor)

set(gca, 'Fontsize', label_size, 'Fontweight', 'Bold','Xcolor', axcolor,...
        'Ycolor', axcolor,'xtick',[year_loc_fut_sing],'xticklabel',labels_fut,'xticklabelrotation',45); 
%set(gca, 'Fontsize', 11, 'Fontweight', 'Bold','Xcolor', axcolor,...
     %   'Ycolor', axcolor,'xtick',[year_loc_ev],'xticklabel',labels_ev,'xticklabelrotation',45); 
ylabel('outlfow (10^6 m^3/day)','Fontsize', ylabel_size, 'Fontweight', 'Bold', 'color', axcolor)
    grid on
xlim([1 length(years)-1])    
ylim([0 300])


%%


% annotations and title

annotation(figure2,'textbox',...
    [0.13225 0.895299145299145 0.0161875 0.032051282051282],'String','b)',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',14,...
    'Color', axcolor, ...
    'FitBoxToText','off');

annotation(figure2,'textbox',...
    [0.133552083333333 0.418269230769231 0.0161875 0.032051282051282],...
    'String','d)',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',14,...
    'Color', axcolor, ...
    'FitBoxToText','off');

[ax,h]=subtitle(title_large); 
    h.FontWeight = 'Bold';
    h.FontSize =  14;
    h.Color = axcolor; 
    
