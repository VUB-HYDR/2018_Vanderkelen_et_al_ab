% % ------------------------------------------------------------------------
% Plot Qout over whole period with all scenarios (in subplots)
% in progress
% ------------------------------------------------------------------------

% flags 
flag_bc = 1;  % 1: QUANT bias correction, 2: PFT bias correction

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


%% subplot 1: outflow with constant lake level
subplot(2,1,1)
% load
if flag_bc == 1 % QUANT 
    load Qout_rcp85_cstL_QUANT.mat 
    load Qout_rcp45_cstL_QUANT.mat 
    load Qout_rcp26_cstL_QUANT.mat 
    
    title_large= 'Empirical quantiles';
elseif flag_bc ==2 % PFT
    load Qout_rcp85_cstL_PFT.mat 
    load Qout_rcp45_cstL_PFT.mat 
    load Qout_rcp26_cstL_PFT.mat
    title_large = 'Parametric linear transformation';

end

% remove HIRHAM and CRCM5 CanESM2
n_HIRHAM = 5; 
n_CRCM = 7; 
Qout_rcp45i = exclude_sim(Qout_rcp45,n_CRCM);
Qout_rcp45ii = exclude_sim(Qout_rcp45i,n_HIRHAM); 
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

diff_Qout_rcp26_cstL = max_Qout_yearmean_rcp26(length(max_Qout_yearmean_rcp26)) - min_Qout_yearmean_rcp26(length(max_Qout_yearmean_rcp26)) 
diff_Qout_rcp45_cstL = max_Qout_yearmean_rcp45(length(max_Qout_yearmean_rcp26)) - min_Qout_yearmean_rcp45(length(max_Qout_yearmean_rcp26))
diff_Qout_rcp85_cstL = max_Qout_yearmean_rcp85(length(max_Qout_yearmean_rcp26)) - min_Qout_yearmean_rcp85(length(max_Qout_yearmean_rcp26))
Qout_yearmean_rcp26(length(Qout_yearmean_rcp26));
Qout_yearmean_rcp45(length(Qout_yearmean_rcp45));
Qout_yearmean_rcp85(length(Qout_yearmean_rcp85));

Qout_mean_l = (mean(Qout_mean_l_rcp26)+mean(Qout_mean_l_rcp45)+mean(Qout_mean_l_rcp85))/3
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
ylim([0 350])

%% subplot 2: outflow following Agreed Curve
% load
subplot(2,1,2)
if flag_bc == 1 % QUANT 
    load Qout_rcp85_ac_QUANT.mat 
    load Qout_rcp45_ac_QUANT.mat 
    load Qout_rcp26_ac_QUANT.mat  
elseif flag_bc ==2 % PFT
    load Qout_rcp85_ac_PFT.mat 
    load Qout_rcp45_ac_PFT.mat
    load Qout_rcp26_ac_PFT.mat 
end

% remove HIRHAM and CRCM5 CanESM2
n_HIRHAM = 5; 
n_CRCM = 7; 
Qout_rcp45i = exclude_sim(Qout_rcp45,n_CRCM);
Qout_rcp45ii = exclude_sim(Qout_rcp45i,n_HIRHAM); 
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
ylim([0 350])



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
    'String','b)',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',14,...
    'Color', axcolor, ...
    'FitBoxToText','off');

[ax,h]=subtitle(title_large); 
    h.FontWeight = 'Bold';
    h.FontSize =  14;
    h.Color = axcolor; 
    
