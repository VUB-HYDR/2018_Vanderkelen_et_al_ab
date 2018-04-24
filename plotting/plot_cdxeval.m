% ------------------------------------------------------------------------
% Subroutine to plot different variables for CORDEX RCMs 
% ------------------------------------------------------------------------

%% initialise

% define flags

flag_save_cor = 0; 
flag_precip_cor = 1; 
flag_evap_cor = 1; 
flag_lakelevel_cor = 0;
flag_total_lakelevel = 0; 
flag_WBterms_cor = 0; 

% initialise
axcolor = [0.3 0.3 0.3];
colors = mf_colors;

% define ticks and ticklabels for one year
months_label = ['Jan';'Feb';'Mar';'Apr';'May';'Jun';'Jul';'Aug';'Sep';'Oct';'Nov';'Dec'];
months = (1:12).'; 
first_day = ones(length(months),1); 
first_daymonth=[months first_day]; 
[~,ind_firstmonth] = ismember(first_daymonth,month_day,'rows');

mid_day = ones(length(months),1).*15; 
mid_daymonth=[months mid_day]; 
[~,ind_midmonth] = ismember(mid_daymonth,month_day,'rows');


% find the indices of the year array for every day in the whole period
[isday,ind_day] = ismember(date(:,2:3),month_day,'rows'); 

% define periods
% 1950-2014
temp_allyears = date_all(:,1); 
yearlong = time_begin_hist:2:time_end_obs; 
[~, year_loc] = ismember(yearlong,temp_allyears);
labels = {'1950','1952','1954','1956','1958','1960','1962','1964','1966','1968',...
    '1970', '1972','1974', '1976','1978','1980','1982','1984','1986','1988',...
    '1990', '1992','1994','1996','1998','2000', '2002','2004','2006','2008',...
    '2010','2012','2014'};


% 1992-2014
temp_obsyears = date_obs(:,1); 
years = time_begin_obs:time_end_obs; 
[~, year_loc_short] = ismember(years,temp_obsyears);
labels_short = {'1993','1994','1995','1996','1997','1998','1999','2000', ...
'2001','2002','2003','2004','2005','2006','2007','2008','2009','2010',...
'2011','2012','2013','2014'};

% 1990-2008 (CORDEX evaluation period)
temp_evyears = date_ev(:,1); 
years = time_begin_ev:time_end_ev; 
[~, year_loc_ev] = ismember(years,temp_evyears);
labels_ev = {'1990','1991','1992','1993','1994','1995','1996','1997','1998','1999','2000', ...
'2001','2002','2003','2004','2005','2006','2007','2008'};

% define plotting colors for different terms
E_color = colors(16,:); 
P_color = colors(17,:); 
Qin_color = colors(18,:); 
Qout_color = colors(22,:); 
L_color  =colors(11,:); 



%% plotting

fields = fieldnames(E_lake_ev); 


% ------------------------------------------------------------------------
%% plot evap
if flag_evap_cor ==1
    
    % seasonal evaporation
    figure()
    ax1=axes('color','none','Ytick',[])
    ax2=axes;
    
    for index=1:numel(fields)
        E_lake = E_lake_ev.(fields{index}); 
        plot_evap_seas;
        clear E_lake
    end 
    
    hold off
    xlim([1 366])
    set(legend,'Fontweight', 'Bold', 'Fontsize', 10, 'TextColor', axcolor);
    legend('CCLM4-8-17' ,'CRCM5', 'HIRHAM5', 'RACMO22T', 'RCA4', 'REMO2009')
    title('Daily mean lake evaporation (CORDEX evaluations)','Fontsize', 14, 'Fontweight', 'Bold', 'color', axcolor) 
    ylabel('Evaporation  [mm/day]','Fontsize', 12, 'Fontweight', 'Bold', 'color', axcolor)
    set(gca,'XTick',ind_firstmonth,'XtickLabel',[])
    set(ax1,'Xlim',get(ax2,'Xlim'),'Fontsize', 11, 'Fontweight', 'Bold','Xcolor', axcolor,...
        'Ycolor', axcolor,'XTick',ind_midmonth,'XTickLabel',months_label );
    grid on

    % save
    if flag_save==1
    saveas(gcf,'C:\Users\Inne\Documents\MATLAB\Thesis\plots in progress\Eseas_CORDEX.png')
    end
    
    % plot map of annual evaporation
    
    % set colormaps
    colormaps.prec = mf_colormap_cpt('Oranges_04',4); 
    caxes.prec = [0      2000 ];
    
    figure()
    
    for index=1:numel(fields)
        E_lake = E_lake_ev.(fields{index}); 
        subplot(2,3,index)
        plot_evap_ann;
        clear E_lake
        fprintf('Drawing lake evaporation of RCM %d \n', index)
    end 
    [ax,h]=subtitle('Annual Evaporation (CORDEX evaluation)')
    h.FontWeight = 'Bold';
    h.FontSize =  14;
    
end


% ------------------------------------------------------------------------
%% plot precip 
if flag_precip_cor==1
    
    % seasonal precipitation
    figure()
    ax1=axes('color','none','Ytick',[])
    ax2=axes;
    
    for index=1:numel(fields)
        P_lake = P_lake_ev.(fields{index}); 
        plot_precip_seas;
        clear P_lake
    end 
    hold off
    xlim([1 366])
    set(legend,'Fontweight', 'Bold', 'Fontsize', 10, 'TextColor', axcolor);
    legend('CCLM4-8-17' ,'CRCM5', 'HIRHAM5', 'RACMO22T', 'RCA4', 'REMO2009')
    title('Daily mean lake precipitation (CORDEX evaluations)','Fontsize', 14, 'Fontweight', 'Bold', 'color', axcolor) 
    ylabel('Precipitation  [mm/day]','Fontsize', 12, 'Fontweight', 'Bold', 'color', axcolor)
    set(gca,'XTick',ind_firstmonth,'XtickLabel',[])
    set(ax1,'Xlim',get(ax2,'Xlim'),'Fontsize', 11, 'Fontweight', 'Bold','Xcolor', axcolor,...
        'Ycolor', axcolor,'XTick',ind_midmonth,'XTickLabel',months_label );
    grid on

    % save
    if flag_save==1
    saveas(gcf,'C:\Users\Inne\Documents\MATLAB\Thesis\plots in progress\Pseas_CORDEX.png')
    end
    
    
    % Plot map of annual precipitation
    
    % set colormaps
    colormaps.prec = mf_colormap_cpt('es skywalker 01',12); 
    caxes.prec = [0      3000];
    
    figure()
    
    for index=1:numel(fields)
        P = P_ev.(fields{index}); 
        subplot(2,3,index)
        plot_precip_ann;
        clear P_lake
        fprintf('Drawing lake precipitation of RCM %d \n', index)
    end 
    [ax,h]=subtitle('Annual Precipitation (CORDEX evaluations)')
    h.FontWeight = 'Bold';
    h.FontSize =  14;
    
end


% ------------------------------------------------------------------------
%% plot lakelevel
if flag_lakelevel_cdx == 1
    
    figure()
    
    for index=1:numel(fields)
        L = L_ev.(fields{index}); 
        
        plot(L,'linewidth', 2)
        hold on
        
        clear L
    end 
    
    plot(lakelevel,'linewidth', 2)
    hold off
    
    xlim([1 length(date)])
    %ylim([1126 113])
    legend('CCLM4-8-17' ,'CRCM5', 'HIRHAM5', 'RACMO22T', 'RCA4', 'REMO2009','Observed')
    set(legend,'Fontweight', 'Bold', 'Fontsize', 10, 'TextColor', axcolor,'Location', 'northwest');
    title('Modelled and observed lake level (CORDEX evaluations)','Fontsize', 14, 'Fontweight', 'Bold', 'color', axcolor)
    set(gca, 'Fontsize', 11, 'Fontweight', 'Bold','Xcolor', axcolor,...
        'Ycolor', axcolor,'xtick',[year_loc_ev],'xticklabel',labels_ev,'xticklabelrotation',45); 
    ylabel('Lake level (m a.s.l.)','Fontsize', 12, 'Fontweight', 'Bold', 'color', axcolor)
    grid on

    % save
    if flag_save==1
    saveas(gcf,'C:\Users\Inne\Documents\MATLAB\Thesis\plots in progress\lakelevel_cdxev.png')
    end
    
    
    
    
end

