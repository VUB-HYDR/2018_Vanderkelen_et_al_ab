% ------------------------------------------------------------------------
% Plot lakelevel
%-------------------------------------------------------------------------

colorobs = [36 60 74]/255; 
colormod = [255 119 60]/255; 
    % plot modelled and observed lakelevels over observation period
    % Plotting on DAHITI period (from 1992 onwards)
    ind_min_hm = find_date(date_obs,date_hm); 
%%
    figure()
    plot(lakelevel,'linewidth', 2,'color',colorobs)
    hold on 
    plot(L_obs,'linewidth', 2,'color',colormod)
  %  plot(L_mod,'linewidth', 2)
    %plot(L_ac,'linewidth', 2)

    hold off
    xlim([1 length(date_obs)])
    ylim([1133.3 1136])
    legend('Observed lake level','Modelled lake level')
    set(legend,'Fontweight', 'Bold', 'Fontsize', 14, 'TextColor', axcolor);
    %title('Modelled and observed lake level','Fontsize', 16, 'Fontweight', 'Bold', 'color', axcolor)
    set(gca, 'Fontsize', 13, 'Fontweight', 'Bold','Xcolor', axcolor,...
        'Ycolor', axcolor,'xtick',[year_loc_short],'xticklabel',labels_short,'xticklabelrotation',45); 
    ylabel('Lake level (m a.s.l.)','Fontsize', 14, 'Fontweight', 'Bold', 'color', axcolor)
    grid on



   