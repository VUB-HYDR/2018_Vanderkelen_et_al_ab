% ------------------------------------------------------------------------
% Plot seasonal cycle of all water balance terms
% ------------------------------------------------------------------------
close all

% Calculate input and output in terms of lake level
Qin_lake = Qin_wb_obs./A_lake; 
Qout_lake= Qout./A_lake;


%% Seasonal series

% calculate yearmean of daily percip
for t = 1:ndays    
    P_dmean(t)= nanmean(nanmean(P_lake(:,:,t))); 
end
% calculate mean precipitation per day of each year
for i = 1:length(month_day)
   P_seas(i) = nanmean(P_dmean((find(ind_day==i)))); 
end

% calculate yearmean of daily evap
for t = 1:ndays    
    E_dmean(t)= nanmean(nanmean(E_lake(:,:,t))); 
end
% calculate mean evaporation per day of each year
for i = 1:length(month_day)
   E_seas(i)= nanmean(E_dmean((find(ind_day==i)))); 
end

% calculate mean inflow per day of each year
for i = 1:length(month_day)
   Qin_lake_seas(i) = nanmean(Qin_lake((find(ind_day==i)))); 
end

% calculate mean outflow per day of each year
for i = 1:length(month_day)
   Qout_lake_seas(i) = nanmean(Qout_lake((find(ind_day==i)))); 
end

% calculate mean difference per day of each year (anomaly resulting lak
for i = 1:length(month_day)
 WB_diff(i) = P_seas(i)-E_seas(i)+Qin_lake_seas(i)-Qout_lake_seas(i);
end

% give negative sign to evaporation and outflow
E_seas = -E_seas; 
Qout_lake_seas = -Qout_lake_seas;


%% Plot seasonal cycle

figure()
ax1=axes('color','none','Ytick',[])
ax2=axes;
plot((P_seas+Qin_lake_seas).*10^3, 'linewidth', 2, 'color', P_color)
hold on
plot((E_seas+Qout_lake_seas).*10^3,'linewidth', 2, 'color', E_color)
plot((Qin_lake_seas).*10^3,'linewidth', 2, 'color', Qin_color)
plot((Qout_lake_seas).*10^3,'linewidth', 2, 'color', Qout_color)
%plot(WB_diff.*10^3,'linewidth', 1.5, 'color', L_color)
plot(get(gca,'xlim'), [0 0], 'color', axcolor); % plot zero line
hold off
xlim([1 366])
ylim([-13 13])
legend('Precipitation', 'Evaporation','Inflow', 'Outflow')
set(legend,'Fontweight', 'Bold', 'Fontsize', 10, 'TextColor', axcolor,'Location','southeast');
%title('Seasonal terms of the water balance','Fontsize', 14, 'Fontweight', 'Bold', 'color', axcolor) 
ylabel('lake level equivalent (mm)','Fontsize', 12, 'Fontweight', 'Bold', 'color', axcolor)
set(gca,'XTick',ind_firstmonth,'XtickLabel',[])
set(ax1,'Xlim',get(ax2,'Xlim'),'Fontsize', 11, 'Fontweight', 'Bold','Xcolor', axcolor,...
    'Ycolor', axcolor,'XTick',ind_midmonth,'XTickLabel',months_label );
grid on

