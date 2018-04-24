% plot DAHITI and HYDROMET lakelevel over whole period. 

    %  find position of dahiti in hydromet time series
    [isdate, date_loc_all] = ismember(date_all,date_obs,'rows');
    loc_min_dh = min((find(date_loc_all)));
    loc_dh = loc_min_dh:1:length(date_all);


    figure()
    plot(loc_dh,lakelevel_dh,'linewidth', 2)
    hold on
    plot(lakelevel_hm_raw(find_date(date_all,date_hm):ind_max_hm),'linewidth', 2)
    hold off
    xlim([1 length(date_all)])
    legend('DAHITI lake level','HYDROMET lake level')
    set(legend,'Fontweight', 'Bold', 'Fontsize', 16, 'TextColor', axcolor);
   % title('Lake level data','Fontsize', 35, 'Fontweight', 'Bold', 'color', axcolor)
    set(gca, 'Fontsize', 16, 'Fontweight', 'Bold','Xcolor', axcolor,...
        'Ycolor', axcolor,'xtick',[year_loc],'xticklabel',labels,'xticklabelrotation',45); 
    ylabel('Lake level (m a.s.l.)','Fontsize', 16, 'Fontweight', 'Bold', 'color', axcolor)
    grid on
