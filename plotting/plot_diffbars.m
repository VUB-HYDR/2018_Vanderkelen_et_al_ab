% ------------------------------------------------------------------------
% Calculate differences between present and future
% ------------------------------------------------------------------------
plotting;
close all
clear P_diff E_diff Qin_diff
clear legend_name
years = unique(date(:,1)); 
years(length(years)+1) = years(length(years))+1; 
    
for t = 1:length(years)
        [~, ind_year(t)] = ismember(years(t),date(:,1)); 
end

% Present period: 2006-2035 (10 years)
years_pres = 2006:2035;
[~,pres_loc] = ismember(years_pres,years);

% Future period: 2091-2100 (10 years)
years_fut=2071:2100; 
[~,fut_loc] = ismember(years_fut,years);

% calculate yearmeans
for i = 1:nm
    
    if flag_run==3
    P(i,:) = P_wb_hist(i,:);

    elseif flag_run==4
        P_wb_rcp26(9,:) = NaN;
    P(i,:) = P_wb_rcp26(i,:);
    elseif flag_run ==5
    P(i,:) = P_wb_rcp45(i,:);

    elseif flag_run==6
     P(i,:) = P_wb_rcp85(i,:);
%    P(i,:) = P_wb_adj(i,:);

    end
  
    if flag_run==3
    E(i,:) = E_wb_hist(i,:);

    elseif flag_run==4
    E_wb_rcp26(9,:) = NaN;
    E(i,:) = E_wb_rcp26(i,:);

    elseif flag_run ==5
    E(i,:) = E_wb_rcp45(i,:);

    elseif flag_run==6
    E(i,:) = E_wb_rcp85(i,:);
   % E(i,:) = E_wb_adj(i,:);
        end
    
    if flag_run==3
    Qin(i,:) = Qin_wb_hist(i,:);
    
    elseif flag_run==4
    Qin_wb_rcp26(9,:) = NaN;
    Qin(i,:) = Qin_wb_rcp26(i,:);
    title1 = 'FUT-HIST of WBterms rcp26 simulations (hist: 2006-2035, fut: 2071-2100)';
    lim = [-100 150];
    elseif flag_run ==5
    Qin(i,:) = Qin_wb_rcp45(i,:);
    title1 = 'FUT-HIST of WBterms rcp45 simulations (hist: 2006-2035, fut: 2071-2100)';
    lim = [-350 150];

    elseif flag_run==6
    Qin(i,:) = Qin_wb_rcp85(i,:);
    %Qin(i,:) = Qin_wb_adj(i,:);
    title1 = 'FUT-HIST of WBterms rcp85 simulations (hist: 2006-2035, fut: 2071-2100)';
    lim = [-900 700];

    end
    for t = 1:(length(years)-1)
        if t==(length(years)-1)
            P_yearmean(i,t) = nanmean(P(i,(ind_year(t):ind_year(t)+364))); 
            E_yearmean(i,t) = nanmean(E(i,(ind_year(t):(ind_year(t)+364)))); 
            Qin_yearmean(i,t) = nanmean(Qin(i,(ind_year(t):(ind_year(t)+364)))); 
        else
          P_yearmean(i,t) = nanmean(P(i,(ind_year(t):(ind_year(t+1)-1)))); 
          E_yearmean(i,t) = nanmean(E(i,(ind_year(t):(ind_year(t+1)-1)))); 
          Qin_yearmean(i,t) = nanmean(Qin(i,(ind_year(t):(ind_year(t+1)-1)))); 
        end
    end
    
    P_pres(i) =  mean(P_yearmean(i,pres_loc));
    P_fut(i) = mean(P_yearmean(i,fut_loc));
    E_pres(i) =  mean(E_yearmean(i,pres_loc));
    E_fut(i) = mean(E_yearmean(i,fut_loc));
    Qin_pres(i) =  mean(Qin_yearmean(i,pres_loc));
    Qin_fut(i) = mean(Qin_yearmean(i,fut_loc));
end  

if flag_run ==4
    nm = 11; 
    P_adj = P_fut-P_pres;
    E_adj = E_fut-E_pres;
    Qin_adj = Qin_fut-Qin_pres; 
    
    P_diff = P_adj(1:8);
    E_diff = E_adj(1:8);
    Qin_diff = Qin_adj(1:8);
    
    P_diff(9:11) = P_adj(9:11);
    E_diff(9:11) = E_adj(9:11);
    Qin_diff(9:11) = Qin_adj(9:11);

else
    P_diff = P_fut-P_pres;
    E_diff = E_fut-E_pres;
    Qin_diff = Qin_fut-Qin_pres; 
end


P_diff_mean = nanmean(P_diff);
E_diff_mean = nanmean(E_diff);
Qin_diff_mean = nanmean(Qin_diff);

P_diff(length(P_diff)+1)=P_diff_mean; 
E_diff(length(E_diff)+1)=E_diff_mean; 
Qin_diff(length(Qin_diff)+1)=Qin_diff_mean; 



legend_name = strcat(RCM_text,GCM);
legend_name{nm+1} = 'Mean'; 

figure()
subplot(1,3,1)
bar(P_diff*365*1000, 'FaceColor', P_color)
%title('FUT-HIST mean P')
set(gca, 'Fontsize', 8,'xtick',([1:(nm+1)]),'xticklabel',legend_name,'xticklabelrotation',45); 
grid on
xlim([0 nm+2])
ylabel('Precipitation (mm/year)','Fontsize', 16, 'Fontweight', 'Bold', 'color', axcolor)
ylim(lim)

subplot(1,3,2)
bar(E_diff*365*1000, 'FaceColor', E_color)
%title('FUT-HIST mean E ')
set(gca, 'Fontsize',8,'xtick',([1:(nm+1)]),'xticklabel',legend_name,'xticklabelrotation',45); 
grid on
xlim([0 nm+2])
ylabel('Evaporation (mm/year)','Fontsize', 16, 'Fontweight', 'Bold', 'color', axcolor)
ylim(lim)

subplot(1,3,3)
bar(Qin_diff*365*1000/A_lake, 'FaceColor', Qin_color)
%title('FUT-HIST mean Qin')
set(gca, 'Fontsize', 8,'xtick',([1:(nm+1)]),'xticklabel',legend_name,'xticklabelrotation',45); 
grid on
ylabel('Inflow (mm/year)','Fontsize', 16, 'Fontweight', 'Bold', 'color', axcolor)
xlim([0 nm+2])
ylim(lim)
   
[ax,h]=subtitle(title1); 
    h.FontWeight = 'Bold';
    h.FontSize =  14;