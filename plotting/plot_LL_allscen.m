% ------------------------------------------------------------------------
% Plot lakelevel over whole period with all scenarios (in subplots)
% ------------------------------------------------------------------------

% flags 
flag_bc = 2;  % 1: QUANT bias correction, 2: PFT bias correction

% define percentiles
prct_low = 5; 
prct_high = 95; 

% figure element sizes
ylimit = [1120 1160]; 
legend_size = 10; 
title_size = 14; 
ylabel_size = 12; 
label_size = 11; 
% initialisation
figure1 = figure();
main_plotting;

% time variable and labels
time_end_fut = [2100, 12, 31, 0,0,0]; 
date_vec_tot= datevec(datenum(time_begin_hist):1:datenum(time_end_fut));
date_tot = date_vec_tot(:,1:3);
date_2006=[2006 1 1]; 
[~, loc_2006] = ismember(date_2006,date_tot,'rows'); 
temp_allyears = date_tot(:,1); 
year_tot = time_begin_hist-1:10:time_end_fut; 
[~, year_loc] = ismember(year_tot,temp_allyears);
year_loc(1) = 1; 
labels = {'1951','1960','1970','1980','1990','2000','2010','2020','2030',...
    '2040', '2050','2060', '2070','2080','2090','2100'};


%% Subplot 1: lake levels following maximum outflow
subplot(3,1,1)

% load 
if flag_bc == 1 % QUANT 
    load L_rcp85_cstout_max_QUANT.mat 
    load L_rcp45_cstout_max_QUANT.mat
    load L_rcp26_cstout_max_QUANT.mat 
    title_large = 'Empirical quantiles';
elseif flag_bc ==2 % PFT
    load L_rcp85_cstout_max_PFT.mat 
    load L_rcp45_cstout_max_PFT.mat 
    load L_rcp26_cstout_max_PFT.mat 
    title_large = 'Parametric linear transformation';

end

% manipulate


n_HIRHAM = 7; 

 L_rcp45ii = exclude_sim(L_rcp45,n_HIRHAM); 
clear L_rcp45
L_rcp45 = L_rcp45ii;

L_tot_hist = NaN(length(date_tot),1); 
L_tot_rcp26 = NaN(length(date_tot),1); 
L_tot_rcp45 = NaN(length(date_tot),1); 
L_tot_rcp85 = NaN(length(date_tot),1); 

L_tot_hist(1:length(L_hist))=mean(L_hist,1); 
L_tot_rcp26(loc_2006:loc_2006+length(L_rcp45(2,:))-1) = mean(L_rcp26,1);
L_tot_rcp45(loc_2006:loc_2006+length(L_rcp45(2,:))-1) = mean(L_rcp45,1);
L_tot_rcp85(loc_2006:loc_2006+length(L_rcp45(2,:))-1) = mean(L_rcp85,1);

min_L_hist_tot = NaN(length(date_tot),1); 
max_L_hist_tot = NaN(length(date_tot),1); 
min_L_rcp45_tot = NaN(length(date_tot),1); 
min_L_rcp85_tot = NaN(length(date_tot),1);  
min_L_rcp26_tot = NaN(length(date_tot),1); 
max_L_rcp45_tot = NaN(length(date_tot),1); 
max_L_rcp85_tot = NaN(length(date_tot),1);  
max_L_rcp26_tot = NaN(length(date_tot),1); 

% calculate percentiles
max_L_hist = prctile(L_hist,[prct_low],1);
min_L_hist = prctile(L_hist,[prct_high],1); 
min_L_rcp45 = prctile(L_rcp45,[prct_low],1); 
min_L_rcp85 = prctile(L_rcp85,[prct_low],1); 
min_L_rcp26 = prctile(L_rcp26,[prct_low],1); 
max_L_rcp85 = prctile(L_rcp85,[prct_high],1);    
max_L_rcp45 = prctile(L_rcp45,[prct_high],1);     
max_L_rcp26 = prctile(L_rcp26,[prct_high],1); 

% fill in period in total period
min_L_hist_tot((1:loc_2006-1)) = min_L_hist; 
max_L_hist_tot((1:loc_2006-1)) = max_L_hist; 
min_L_rcp45_tot((loc_2006:loc_2006+length(L_rcp45(2,:))-1)) = min_L_rcp45; 
min_L_rcp85_tot(loc_2006:loc_2006+length(L_rcp45(2,:))-1)= min_L_rcp85;
min_L_rcp26_tot(loc_2006:loc_2006+length(L_rcp45(2,:))-1) = min_L_rcp26;
max_L_rcp85_tot(loc_2006:loc_2006+length(L_rcp45(2,:))-1) = max_L_rcp85 ;   
max_L_rcp45_tot(loc_2006:loc_2006+length(L_rcp45(2,:))-1) = max_L_rcp45 ;    
max_L_rcp26_tot(loc_2006:loc_2006+length(L_rcp45(2,:))-1) = max_L_rcp26;

% plot 
x_hist = 1:loc_2006-1; 
x2_hist = [x_hist, fliplr(x_hist)];
range_hist = [min_L_hist, fliplr(max_L_hist)];
f4 = fill(x2_hist, range_hist, gray_range);
hold on
plot(min_L_hist_tot,'Color',gray)
plot(max_L_hist_tot,'Color',gray)

x = loc_2006:loc_2006+length(min_L_rcp26)-1; 
x2 = [x, fliplr(x)];

% rcp26
range_rcp26 = [min_L_rcp26, fliplr(max_L_rcp26)];
f1 = fill(x2, range_rcp26, blue_range);
set(f1,'facealpha',.5)
hold on
plot(min_L_rcp26_tot,'Color',blue_range)
plot(max_L_rcp26_tot,'Color',blue_range)

% rcp 45
range_rcp45 = [min_L_rcp45, fliplr(max_L_rcp45)];
f2 = fill(x2, range_rcp45, green_range);
set(f2,'facealpha',.5)
plot(min_L_rcp45_tot,'Color',green_range)
plot(max_L_rcp45_tot,'Color',green_range)

% rcp 85
range_rcp85 = [min_L_rcp85, fliplr(max_L_rcp85)];
f3=fill(x2, range_rcp85, red_range);
set(f3,'facealpha',.5)
plot(min_L_rcp85_tot,'Color',red_range)
plot(max_L_rcp85_tot,'Color',red_range)

% plot means
 f1 =  plot(L_tot_hist,'linewidth', 1,'Color',[0.3 0.3 0.3]); 
 f2 = plot(L_tot_rcp26,'linewidth', 1,'Color',blue);
 f3 =  plot(L_tot_rcp45,'linewidth', 1,'Color',green);
 f4 = plot(L_tot_rcp85,'linewidth', 1,'Color',red);    
 hold off
 
 xlim([1 length(date_tot)])
 legend([f1 f2 f3 f4], 'Historical','RCP 2.6','RCP 4.5','RCP 8.5')
 set(legend,'Fontweight', 'Bold','Fontsize', legend_size, 'TextColor', axcolor, 'Position',[0.141493055555556 0.715455840455841 0.0722656259313226 0.0970886773533289]);
 title('High constant outflow scenario','Fontsize', title_size, 'Fontweight', 'Bold', 'color', axcolor)
 set(gca, 'Fontsize', label_size, 'Fontweight', 'Bold','Xcolor', axcolor,...
   'Ycolor', axcolor,'xtick',[year_loc],'xticklabel',labels,'xticklabelrotation',45); 
ylabel('Lake level (m a.s.l.)','Fontsize', ylabel_size , 'Fontweight', 'Bold', 'color', axcolor)
ylim(ylimit)
grid on


%% Subplot 2: lake levels following minimum outflow
subplot(3,1,2)

% load 
if flag_bc == 1 % QUANT 
    load L_rcp85_cstout_min_QUANT.mat
    load L_rcp45_cstout_min_QUANT.mat
    load L_rcp26_cstout_min_QUANT.mat  
elseif flag_bc ==2 % PFT
    load L_rcp85_cstout_min_PFT.mat 
    load L_rcp45_cstout_min_PFT.mat 
    load L_rcp26_cstout_min_PFT.mat 
end

% % remove HIRHAM and CRCM5 CanESM2
% n_HIRHAM = 5; 
% n_CRCM = 7; 
% L_rcp45i = exclude_sim(L_rcp45,n_CRCM);
% L_rcp45ii = exclude_sim(L_rcp45i,n_HIRHAM); 
% L_rcp85i = exclude_sim(L_rcp85,n_HIRHAM); 
% clear L_rcp45 L_rcp85
% L_rcp45 = L_rcp45ii;
% L_rcp85 = L_rcp85i;
n_HIRHAM = 7; 

 L_rcp45ii = exclude_sim(L_rcp45,n_HIRHAM); 
clear L_rcp45 
L_rcp45 = L_rcp45ii;
% manipulate

L_tot_hist = NaN(length(date_tot),1); 
L_tot_rcp26 = NaN(length(date_tot),1); 
L_tot_rcp45 = NaN(length(date_tot),1); 
L_tot_rcp85 = NaN(length(date_tot),1); 

L_tot_hist(1:length(L_hist))=mean(L_hist,1); 
L_tot_rcp26(loc_2006:loc_2006+length(L_rcp45(2,:))-1) = mean(L_rcp26,1);
L_tot_rcp45(loc_2006:loc_2006+length(L_rcp45(2,:))-1) = mean(L_rcp45,1);
L_tot_rcp85(loc_2006:loc_2006+length(L_rcp45(2,:))-1) = mean(L_rcp85,1);

min_L_hist_tot = NaN(length(date_tot),1); 
max_L_hist_tot = NaN(length(date_tot),1); 
min_L_rcp45_tot = NaN(length(date_tot),1); 
min_L_rcp85_tot = NaN(length(date_tot),1);  
min_L_rcp26_tot = NaN(length(date_tot),1); 
max_L_rcp45_tot = NaN(length(date_tot),1); 
max_L_rcp85_tot = NaN(length(date_tot),1);  
max_L_rcp26_tot = NaN(length(date_tot),1); 

% calculate percentiles
max_L_hist = prctile(L_hist,[prct_low],1);
min_L_hist = prctile(L_hist,[prct_high],1); 
min_L_rcp45 = prctile(L_rcp45,[prct_low],1); 
min_L_rcp85 = prctile(L_rcp85,[prct_low],1); 
min_L_rcp26 =prctile(L_rcp26,[prct_low],1); 
max_L_rcp85 = prctile(L_rcp85,[prct_high],1);    
max_L_rcp45 =prctile(L_rcp45,[prct_high],1);     
max_L_rcp26= prctile(L_rcp26,[prct_high],1); 

% fill in period in total period
min_L_hist_tot((1:loc_2006-1)) = min_L_hist; 
max_L_hist_tot((1:loc_2006-1)) = max_L_hist; 
min_L_rcp45_tot((loc_2006:loc_2006+length(L_rcp45(2,:))-1)) = min_L_rcp45; 
min_L_rcp85_tot(loc_2006:loc_2006+length(L_rcp45(2,:))-1)= min_L_rcp85;
min_L_rcp26_tot(loc_2006:loc_2006+length(L_rcp45(2,:))-1) = min_L_rcp26;
max_L_rcp85_tot(loc_2006:loc_2006+length(L_rcp45(2,:))-1) = max_L_rcp85 ;   
max_L_rcp45_tot(loc_2006:loc_2006+length(L_rcp45(2,:))-1) = max_L_rcp45 ;    
max_L_rcp26_tot(loc_2006:loc_2006+length(L_rcp45(2,:))-1) = max_L_rcp26;


% plot
x_hist = 1:loc_2006-1; 
x2_hist = [x_hist, fliplr(x_hist)];
range_hist = [min_L_hist, fliplr(max_L_hist)];
f4 = fill(x2_hist, range_hist, gray_range);
hold on
plot(min_L_hist_tot,'Color',gray)
plot(max_L_hist_tot,'Color',gray)

x = loc_2006:loc_2006+length(min_L_rcp26)-1; 
x2 = [x, fliplr(x)];

% rcp26
range_rcp26 = [min_L_rcp26, fliplr(max_L_rcp26)];
f1 = fill(x2, range_rcp26, blue_range);
set(f1,'facealpha',.5)
hold on
plot(min_L_rcp26_tot,'Color',blue_range)
plot(max_L_rcp26_tot,'Color',blue_range)

% rcp 45
range_rcp45 = [min_L_rcp45, fliplr(max_L_rcp45)];
f2 = fill(x2, range_rcp45, green_range);
set(f2,'facealpha',.5)
plot(min_L_rcp45_tot,'Color',green_range)
plot(max_L_rcp45_tot,'Color',green_range)

% rcp 85
range_rcp85 = [min_L_rcp85, fliplr(max_L_rcp85)];
f3=fill(x2, range_rcp85, red_range);
set(f3,'facealpha',.5)
plot(min_L_rcp85_tot,'Color',red_range)
plot(max_L_rcp85_tot,'Color',red_range)

% plot means
 f1 =  plot(L_tot_hist,'linewidth', 1,'Color',[0.3 0.3 0.3]); 
 f2 = plot(L_tot_rcp26,'linewidth', 1,'Color',blue);
 f3 =  plot(L_tot_rcp45,'linewidth', 1,'Color',green);
 f4 = plot(L_tot_rcp85,'linewidth', 1,'Color',red);    
 hold off
 
 xlim([1 length(date_tot)])
%   legend([f1 f2 f3 f4], 'historical','RCP 2.6','RCP 4.5','RCP 8.5')
%   set(legend,'Fontweight', 'Bold', 'Fontsize',legend_size, 'TextColor', axcolor,'Location','southwest');
 title('Low constant outflow scenario','Fontsize', title_size, 'Fontweight', 'Bold', 'color', axcolor)
 set(gca, 'Fontsize', label_size, 'Fontweight', 'Bold','Xcolor', axcolor,...
   'Ycolor', axcolor,'xtick',[year_loc],'xticklabel',labels,'xticklabelrotation',45); 
ylabel('Lake level (m a.s.l.)','Fontsize', ylabel_size, 'Fontweight', 'Bold', 'color', axcolor)
grid on
ylim(ylimit)

%% subplot 3: lake levels following agreed curve
subplot(3,1,3)
% load 
if flag_bc == 1 % QUANT 
    load L_rcp85_ac_QUANT.mat 
    load L_rcp45_ac_QUANT.mat 
    load L_rcp26_ac_QUANT.mat
elseif flag_bc ==2 % PFT
    load L_rcp85_ac_PFT.mat
    load L_rcp45_ac_PFT.mat 
    load L_rcp26_ac_PFT.mat  
end

% % remove HIRHAM and CRCM5 CanESM2
% n_HIRHAM = 5; 
% n_CRCM = 7; 
% L_rcp45i = exclude_sim(L_rcp45,n_CRCM);
% L_rcp45ii = exclude_sim(L_rcp45i,n_HIRHAM); 
% L_rcp85i = exclude_sim(L_rcp85,n_HIRHAM); 
% clear L_rcp45 L_rcp85
% L_rcp45 = L_rcp45ii;
% L_rcp85 = L_rcp85i;
n_HIRHAM = 7; 

 L_rcp45ii = exclude_sim(L_rcp45,n_HIRHAM); 
clear L_rcp45 
L_rcp45 = L_rcp45ii;



% manipulate
L_tot_hist = NaN(length(date_tot),1); 
L_tot_rcp26 = NaN(length(date_tot),1); 
L_tot_rcp45 = NaN(length(date_tot),1); 
L_tot_rcp85 = NaN(length(date_tot),1); 

L_tot_hist(1:length(L_hist))=mean(L_hist,1); 
L_tot_rcp26(loc_2006:loc_2006+length(L_rcp45(2,:))-1) = mean(L_rcp26,1);
L_tot_rcp45(loc_2006:loc_2006+length(L_rcp45(2,:))-1) = mean(L_rcp45,1);
L_tot_rcp85(loc_2006:loc_2006+length(L_rcp45(2,:))-1) = mean(L_rcp85,1);

min_L_hist_tot = NaN(length(date_tot),1); 
max_L_hist_tot = NaN(length(date_tot),1); 
min_L_rcp45_tot = NaN(length(date_tot),1); 
min_L_rcp85_tot = NaN(length(date_tot),1);  
min_L_rcp26_tot = NaN(length(date_tot),1); 
max_L_rcp45_tot = NaN(length(date_tot),1); 
max_L_rcp85_tot = NaN(length(date_tot),1);  
max_L_rcp26_tot = NaN(length(date_tot),1); 

% calculate percentiles
max_L_hist = prctile(L_hist,[prct_low],1);
min_L_hist = prctile(L_hist,[prct_high],1); 
min_L_rcp45 = prctile(L_rcp45,[prct_low],1); 
min_L_rcp85 = prctile(L_rcp85,[prct_low],1); 
min_L_rcp26 =prctile(L_rcp26,[prct_low],1); 
max_L_rcp85 = prctile(L_rcp85,[prct_high],1);    
max_L_rcp45 =prctile(L_rcp45,[prct_high],1);     
max_L_rcp26= prctile(L_rcp26,[prct_high],1); 

% fill in period in total period
min_L_hist_tot((1:loc_2006-1)) = min_L_hist; 
max_L_hist_tot((1:loc_2006-1)) = max_L_hist; 
min_L_rcp45_tot((loc_2006:loc_2006+length(L_rcp45(2,:))-1)) = min_L_rcp45; 
min_L_rcp85_tot(loc_2006:loc_2006+length(L_rcp45(2,:))-1)= min_L_rcp85;
min_L_rcp26_tot(loc_2006:loc_2006+length(L_rcp45(2,:))-1) = min_L_rcp26;
max_L_rcp85_tot(loc_2006:loc_2006+length(L_rcp45(2,:))-1) = max_L_rcp85 ;   
max_L_rcp45_tot(loc_2006:loc_2006+length(L_rcp45(2,:))-1) = max_L_rcp45 ;    
max_L_rcp26_tot(loc_2006:loc_2006+length(L_rcp45(2,:))-1) = max_L_rcp26;

% plot
x_hist = 1:loc_2006-1; 
x2_hist = [x_hist, fliplr(x_hist)];
range_hist = [min_L_hist, fliplr(max_L_hist)];
f4 = fill(x2_hist, range_hist, gray_range);
hold on
plot(min_L_hist_tot,'Color',gray)
plot(max_L_hist_tot,'Color',gray)

x = loc_2006:loc_2006+length(min_L_rcp26)-1; 
x2 = [x, fliplr(x)];

% rcp26
range_rcp26 = [min_L_rcp26, fliplr(max_L_rcp26)];
f1 = fill(x2, range_rcp26, blue_range);
set(f1,'facealpha',.5)
hold on
plot(min_L_rcp26_tot,'Color',blue_range)
plot(max_L_rcp26_tot,'Color',blue_range)

% rcp 45
range_rcp45 = [min_L_rcp45, fliplr(max_L_rcp45)];
f2 = fill(x2, range_rcp45, green_range);
set(f2,'facealpha',.5)
plot(min_L_rcp45_tot,'Color',green_range)
plot(max_L_rcp45_tot,'Color',green_range)

% rcp 85
range_rcp85 = [min_L_rcp85, fliplr(max_L_rcp85)];
f3=fill(x2, range_rcp85, red_range);
set(f3,'facealpha',.5)
plot(min_L_rcp85_tot,'Color',red_range)
plot(max_L_rcp85_tot,'Color',red_range)

% plot means
 f1 =  plot(L_tot_hist,'linewidth', 1,'Color',[0.3 0.3 0.3]); 
 f2 = plot(L_tot_rcp26,'linewidth', 1,'Color',blue);
 f3 =  plot(L_tot_rcp45,'linewidth', 1,'Color',green);
 f4 = plot(L_tot_rcp85,'linewidth', 1,'Color',red);    
 hold off
 
 xlim([1 length(date_tot)])
%  legend([f1 f2 f3 f4], 'historical','RCP 2.6','RCP 4.5','RCP 8.5')
%  set(legend,'Fontweight', 'Bold', 'Fontsize', legend_size, 'TextColor', axcolor,'Location','northwest');
  title('Agreed Curve scenario','Fontsize', title_size, 'Fontweight', 'Bold', 'color', axcolor)
 set(gca, 'Fontsize', label_size, 'Fontweight', 'Bold','Xcolor', axcolor,...
   'Ycolor', axcolor,'xtick',[year_loc],'xticklabel',labels,'xticklabelrotation',45); 
ylabel('Lake level (m a.s.l.)','Fontsize',  ylabel_size, 'Fontweight', 'Bold', 'color', axcolor)
grid on
ylim([1130 1138])

% annotations
[ax,h]=subtitle(title_large); 
    h.FontWeight = 'Bold';
    h.FontSize =  14;
    h.Color = axcolor; 
    

annotation(figure1,'textbox',...
    [0.130166666666667 0.879273504273504 0.0156666666666667 0.0438034188034188],...
    'String',{'a)'},...
    'LineStyle','none',...
    'Color',axcolor, ...
    'FontWeight','bold',...
    'FontSize',12,...
    'FitBoxToText','off');
annotation(figure1,'textbox',...
    [0.12834375 0.281517094017094 0.0156666666666667 0.0438034188034187],...
    'String','c)',...
    'LineStyle','none',...
    'Color',axcolor, ...
    'FontWeight','bold',...
    'FontSize',12,...
    'FitBoxToText','off');
annotation(figure1,'textbox',...
    [0.130427083333333 0.578525641025641 0.0156666666666667 0.0438034188034188],...
    'String','b)',...
    'LineStyle','none',...
    'Color',axcolor, ...
    'FontWeight','bold',...
    'FontSize',12,...
    'FitBoxToText','off');

