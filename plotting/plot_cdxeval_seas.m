% ------------------------------------------------------------------------
% Subroutine to plot different variables for CORDEX RCMs 
% ------------------------------------------------------------------------

%% initialise

% define flags

flag_save = 0; 
flag_precip_cor = 1; 
flag_evap_cor = 1; 
flag_lakelevel_cor = 0;
flag_total_lakelevel = 0; 
flag_WBterms_cor = 0; 

% initialise
axcolor = [0.3 0.3 0.3];
colors = mf_colors;
colormap = mf_colormap_cpt('Set2 07',7);
red = [0.894117647058824 0.101960784313725 0.109803921568627]; 
colormap(1,:) = red; 

% define ticks and ticklabels for one year
months_label = ['Jan';'Feb';'Mar';'Apr';'May';'Jun';'Jul';'Aug';'Sep';'Oct';'Nov';'Dec'];
months_label_short = ['J';'F';'M';'A';'M';'J';'J';'A';'S';'O';'N';'D'];
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

years_half = time_begin_ev:2:time_end_ev; 
[~, year_loc_ev_half] = ismember(years_half,temp_evyears);
labels_ev_half = {'1990','1992','1994','1996','1998','2000', '2002','2004','2006','2008'};

% 1993-2008 (Bias correction period) 
if flag_type == 3
   temp_bcyears = date_bc(:,1); 
    years = time_begin_bc:time_end_bc; 
    [~, year_loc_ev] = ismember(years,temp_bcyears);
    labels_ev = {'1993','1994','1995','1996','1997','1998','1999','2000', ...
    '2001','2002','2003','2004','2005','2006','2007','2008'};

    years_half = time_begin_bc:2:time_end_bc+2; 
    [~, year_loc_ev_half] = ismember(years_half,temp_bcyears);
    year_loc_ev_half(length(year_loc_ev_half+1))=(length(date)); 
    labels_ev_half = {'1993','1995','1997','1999','2001', '2003','2005','2007','2009'};
end
    

% define plotting colors for different terms
E_color = colors(16,:); 
P_color = colors(17,:); 
Qin_color = colors(18,:); 
Qout_color = colors(22,:); 
L_color  =colors(11,:); 

load E_ev
load P_wb_obs
load E_wb_obs
load Qin_wb_obs

figure1 = figure();

%% plot lakelevel
subplot(2,2,1)
    
    for i=1:nRCMs
        L = L_ev(i,:); 
        
        plot(L,'linewidth', 2, 'Color', colormap(i+1,:))
        hold on
        
      % clear L
    end 
    
    plot(lakelevel,'linewidth', 2, 'Color', colormap(1,:))
    hold off
    
    xlim([1 length(date)])
  %  ylim([1120 1150])
    legend('CCLM4-8-17' ,'CRCM5', 'HIRHAM5', 'RACMO22T', 'RCA4', 'REMO2009','Reference')
    set(legend,'Fontweight', 'Bold', 'Fontsize', 10, 'TextColor', axcolor,'Location', 'northeastoutside');
     set(gca, 'Fontsize', 11, 'Fontweight', 'Bold','Xcolor', axcolor,...
        'Ycolor', axcolor,'xtick',[year_loc_ev_half],'xticklabel',labels_ev_half,'xticklabelrotation',45); 
    title('Modelled and observed lake level','Fontsize', 14, 'Fontweight', 'Bold', 'color', axcolor)
    ylabel('Lake level (m a.s.l.)','Fontsize', 12, 'Fontweight', 'Bold', 'color', axcolor)
    grid on
% 

%% plot precip 
    % find indices for months
    year_months_un = unique(date(:,1:2),'rows');
    year_months_un_obs = unique(date_obs(:,1:2),'rows');

    year_month = 1:12; 
    [~,ind_month] = ismember(year_months_un(:,2),year_month); 

      
    
    % seasonal precipitation (monthly)
subplot(2,2,2)    
%     ax1=axes('color','none','Ytick',[]); 
%     ax2=axes;
    
    % change Xtick (working with monthly data)
    midmonth = 1:12; 
    % calculate seasonal means for evaluation
    for index=1:nRCMs
        P_mean = P_wb_ev(index,:); 
        
        % calculate monthly means
        for i = 1:length(year_months_un)
            [ismonth, loc_month] = ismember(date(:,1:2),year_months_un(i,:),'rows') ; 

            P_mean_month(i) = nanmean(P_mean((find(ismonth==1)))); 
        end
        
        % calculate seasonal means
         for i = 1:length(year_month)
            P_mmeanmean(i) = nanmean(P_mean_month((find(ind_month==i)))); 
         end
        plot(P_mmeanmean*10^3, 'linewidth', 2,'Color', colormap(index+1,:))
        hold on
        clear P_mean
    end
    % calculate seasonal mean for observations
    P_mean_obs = P_wb_obs; 
    
   for i = 1:length(year_months_un_obs)
   [ismonth, loc_month] = ismember(date(:,1:2),year_months_un_obs(i,:),'rows') ; 

    P_mean_month(i) = nanmean(P_mean_obs((find(ismonth==1)))); 
    end
    
    for i = 1:length(year_month)
       P_mmeanmean_obs(i) = nanmean(P_mean_month((find(ind_month==i)))); 
    end
    plot(P_mmeanmean_obs*10^3, 'linewidth', 2,'Color', colormap(1,:))
 
    hold off
    xlim([1 12])
    %legend('CCLM4-8-17' ,'CRCM5', 'HIRHAM5', 'RACMO22T', 'RCA4', 'REMO2009', 'Observations')
    %set(legend,'Fontweight', 'Bold', 'Fontsize', 10, 'TextColor', axcolor,'Location', 'northeastoutside');
     set(gca,'Fontsize', 9, 'Fontweight', 'Bold','Xcolor', axcolor,...
        'Ycolor', axcolor,'XTick',midmonth,'XtickLabel',months_label_short)
    title('Monthly mean lake precipitation','Fontsize', 14, 'Fontweight', 'Bold', 'color', axcolor) 
    ylabel('lake level eq. [mm/day]','Fontsize', 12, 'Fontweight', 'Bold', 'color', axcolor)
   
    grid on

    % save
    if flag_save==1
    saveas(gcf,'C:\Users\Inne\Documents\MATLAB\Thesis\plots in progress\Pseas_CORDEX.png')
    end
%% plot evap
subplot(2,2,3)    
    % calculate seasonal means for evaluation
    for index=1:nRCMs
        E_mean = E_wb_ev(index,:); 
     
        for i = 1:length(year_months_un)
            [ismonth, loc_month] = ismember(date(:,1:2),year_months_un(i,:),'rows') ; 

            E_mean_month(i) = nanmean(E_mean((find(ismonth==1)))); 
        end
        
        % calculate seasonal means
         for i = 1:length(year_month)
            E_mmeanmean(i) = nanmean(E_mean_month((find(ind_month==i)))); 
         end
        plot(E_mmeanmean*10^3, 'linewidth', 2,'Color', colormap(index+1,:))
        hold on
        clear P_mean   
        
        
%         for i = 1:length(month_day)
%             E_dmeanmean(i) = nanmean(E_mean((find(ind_day==i)))); 
%         end
%         plot(E_dmeanmean*10^3, 'linewidth', 2, 'Color', colormap(index+1,:))
%         hold on
%         clear E_mean
    end 
   
%     % calculate seasonal mean for observations
%     E_mean_obs = E_wb_obs; 
%     for i = 1:length(month_day)
%        E_dmeanmean_obs(i) = nanmean(E_mean_obs((find(ind_day==i)))); 
%     end
%     plot(E_dmeanmean_obs*10^3, 'linewidth', 2,'Color', colormap(1,:))
%     hold off
 
    % calculate seasonal mean for observations
    E_mean_obs = E_wb_obs; 
    
   for i = 1:length(year_months_un_obs)
   [ismonth, loc_month] = ismember(date(:,1:2),year_months_un_obs(i,:),'rows') ; 

    E_mean_month(i) = nanmean(E_mean_obs((find(ismonth==1)))); 
    end
    
    for i = 1:length(year_month)
       E_mmeanmean_obs(i) = nanmean(E_mean_month((find(ind_month==i)))); 
    end
    plot(E_mmeanmean_obs*10^3, 'linewidth', 2,'Color', colormap(1,:))
    
        
    xlim([1 12])
   % ylim([0 12])
    %legend('CCLM4-8-17' ,'CRCM5', 'HIRHAM5', 'RACMO22T', 'RCA4', 'REMO2009', 'Observations')
    %set(legend,'Fontweight', 'Bold', 'Fontsize', 10, 'TextColor', axcolor,'Location', 'northeastoutside');
    set(gca,'Fontsize', 9, 'Fontweight', 'Bold','Xcolor', axcolor,...
        'Ycolor', axcolor,'XTick',midmonth,'XTickLabel',months_label_short );
            ylabel('lake level eq.  [mm/day]','Fontsize', 12, 'Fontweight', 'Bold', 'color', axcolor)
    title('Daily mean lake evaporation ','Fontsize', 14, 'Fontweight', 'Bold', 'color', axcolor) 

    grid on

%% plot inflow
subplot(2,2,4)

 % find indices for months
    year_months_un = unique(date(:,1:2),'rows');
    year_months_un_obs = unique(date_obs(:,1:2),'rows');

    year_month = 1:12; 
    [~,ind_month] = ismember(year_months_un(:,2),year_month); 

    
    % change Xtick (working with monthly data)
    midmonth = 1:12; 
    % calculate seasonal means for evaluation
    for index=1:nRCMs
        Qin = Qin_wb_ev(index,:); 
        
        % calculate monthly means
        for i = 1:length(year_months_un)
            [ismonth, loc_month] = ismember(date(:,1:2),year_months_un(i,:),'rows') ; 

            Qin_month(i) = nanmean(Qin((find(ismonth==1)))); 
        end
        
        % calculate seasonal means
         for i = 1:length(year_month)
            Qin_mmeanmean(i) = nanmean(Qin_month((find(ind_month==i)))); 
         end
        plot(Qin_mmeanmean*10^3/A_lake, 'linewidth', 2,'Color', colormap(index+1,:))
        hold on
        clear Qin
    end
    % calculate seasonal mean for observations
    Qin_obs = Qin_wb_obs; 
    
   for i = 1:length(year_months_un_obs)
   [ismonth, loc_month] = ismember(date(:,1:2),year_months_un_obs(i,:),'rows') ; 

    Qin_month(i) = nanmean(Qin_obs((find(ismonth==1)))); 
    end
    
    for i = 1:length(year_month)
       Qin_mmeanmean_obs(i) = nanmean(Qin_month((find(ind_month==i)))); 
    end
    plot(Qin_mmeanmean_obs*10^3/A_lake, 'linewidth', 2,'Color', colormap(1,:))
    
    hold off
    
    xlim([1 12])
   %legend('CCLM4-8-17' ,'CRCM5', 'HIRHAM5', 'RACMO22T', 'RCA4', 'REMO2009', 'Observations')
    %set(legend,'Fontweight', 'Bold','Location', 'northeastoutside','Fontsize', 10, 'TextColor', axcolor);
    set(gca,'Fontsize', 9, 'Fontweight', 'Bold','Xcolor', axcolor,...
        'Ycolor', axcolor,'XTick',midmonth,'XtickLabel',months_label_short)
    title('Monthly mean inflow','Fontsize', 14, 'Fontweight', 'Bold', 'color', axcolor) 
    ylabel('lake level eq. [mm/day])','Fontsize', 12, 'Fontweight', 'Bold', 'color', axcolor)

    grid on
    
% annotations

annotation(figure1,'textbox',...
    [0.130190515126737 0.886609071274297 0.0333417825020441 0.0421166306695462],...
    'String','a)',...
    'Fontweight', 'Bold',...
    'LineStyle','none',...
     'Color', axcolor, ...
    'FontSize',12,...
    'FitBoxToText','off');

annotation(figure1,'textbox',...
    [0.572136549468519 0.88714902807775 0.0333417825020441 0.0421166306695462],...
    'String','b)',...
        'Fontweight', 'Bold',...
     'Color', axcolor, ...
    'LineStyle','none',...
    'FontSize',12,...
    'FitBoxToText','off');
annotation(figure1,'textbox',...
    [0.129372853638592 0.413606911447079 0.0333417825020441 0.042116630669546],...
    'String','c)',...
     'Color', axcolor, ...
         'Fontweight', 'Bold',...
    'LineStyle','none',...
    'FontSize',12,...
    'FitBoxToText','off');

annotation(figure1,'textbox',...
    [0.572954210956662 0.413066954643622 0.033341782502044 0.042116630669546],...
    'String','d)',...
    'Color', axcolor, ...
        'Fontweight', 'Bold',...
    'LineStyle','none',...
    'FontSize',12,...
    'FitBoxToText','off');


%    [ax,h]=subtitle('WB terms of CORDEX evaluations bias corrected with the power parametric transformation'); 
%     h.FontWeight = 'Bold';
%     h.FontSize =  14;

