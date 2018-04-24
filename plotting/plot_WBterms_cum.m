

%% Plot time series


% calculate total precipitation over the lake 
P_dcumsum(1) = nanmean(nanmean(P_lake(:,:,1))); 
for t = 2:ndays    
    P_dsum(t)= nanmean(nanmean(P_lake(:,:,t))); 
    if (isnan(P_dsum(t)))P_dsum(t) = 0; end
    P_dcumsum(t) = P_dcumsum(t-1)+P_dsum(t); 
end

% calculate total evaporation over the lake 
E_dcumsum(1)= nanmean(nanmean(E_lake(:,:,1)));
for t = 2:ndays    
    E_dsum(t)= nanmean(nanmean(E_lake(:,:,t)));
    E_dcumsum(t) = E_dcumsum(t-1)+E_dsum(t); 
end

% calculate total inflow in the lake 
Qin_dcumsum(1)= Qin_lake(1);
for t = 2:ndays    
    Qin_dsum(t)= Qin_lake(t);
    Qin_dcumsum(t) = Qin_dcumsum(t-1)+Qin_dsum(t); 
end

% calculate total evaporation over the lake 
Qout_dcumsum(1)= Qout_lake(1);
for t = 2:ndays    
    Qout_dsum(t)= Qout_lake(t);
    Qout_dcumsum(t) = Qout_dcumsum(t-1)+Qout_dsum(t); 
end

% make evaporation and outflow negative
E_dcumsum = -E_dcumsum; 
Qout_dcumsum = -Qout_dcumsum; 

L_anom = P_dcumsum+E_dcumsum+Qin_dcumsum + Qout_dcumsum; 

% Calculate percentages of total in- or output
% P_pr = (mean(P_seas)/(mean(P_seas)+mean(Qin_lake_seas)))*100
% Qin_pr = (mean(Qin_lake_seas)/(mean(P_seas)+mean(Qin_lake_seas)))*100 
% Qout_pr = (mean(Qout_lake_seas)/(mean(E_seas)+mean(Qout_lake_seas)))*100 
% E_pr = (mean(E_seas)/(mean(E_seas)+mean(Qout_lake_seas)))*100


%% PLOT
figure1 = figure(); 

P_color_ar = [144 184 215]/255; 
E_color_ar = [242 115 60]/255; 
Qout_color_ar =  [253 210 68]/255; 
Qin_color_ar =  [83 199 79]/255; 
L_color_ar =  [110 37 37]/255;
%L_color_ar =  [30 30 30]/255;

area(P_dcumsum, 'linewidth', 1.5, 'EdgeColor', P_color,'FaceColor', P_color_ar)
hold on
area(E_dcumsum,'linewidth', 1.5, 'EdgeColor', E_color,'FaceColor', E_color_ar)
area(Qin_dcumsum,'linewidth', 1.5, 'EdgeColor', Qin_color,'FaceColor', Qin_color_ar)
area(Qout_dcumsum,'linewidth', 1.5, 'EdgeColor', Qout_color,'FaceColor', Qout_color_ar)
plot(L_anom,'linewidth', 1.5, 'Color', L_color)


plot(get(gca,'xlim'), [0 0], 'color', axcolor); % plot zero line
hold off
%legend('Precipitation', 'Evaporation','Inflow', 'Outflow','Lakelevel')
xlim([1 length(date_obs)])
%set(legend,'Fontweight', 'Bold', 'Fontsize', 10, 'TextColor', axcolor,'Location','northwest');
%title('Cumulative terms of the water balance and resulting lake level','Fontsize', 14, 'Fontweight', 'Bold', 'color', axcolor) 
ylabel('lake level equivalent (m)','Fontsize', 12, 'Fontweight', 'Bold', 'color', axcolor)
set(gca, 'Fontsize', 11, 'Fontweight', 'Bold','Xcolor', axcolor,...
    'Ycolor', axcolor,'xtick',[year_loc_short],'xticklabel',labels_short,'xticklabelrotation',45); 
grid on

createdoublearrow(figure1,P_color,E_color,Qin_color,Qout_color); 
createWBnames(figure1,[0.2 0.2 0.2]); 
createprecentages(figure1,axcolor); 
