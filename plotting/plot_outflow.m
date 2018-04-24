% ------------------------------------------------------------------------
% Plot outflow
%-------------------------------------------------------------------------

%% Plot continous outflow data
figure()
plot(outflow*10^(-6),'linewidth', 2)
xlim([1 length(date_all)])
title('Outflow','Fontsize', 14, 'Fontweight', 'Bold', 'color', axcolor)
%set(legend,'Fontweight', 'Bold', 'Fontsize', 10, 'TextColor', axcolor);
set(gca, 'Fontsize', 11, 'Fontweight', 'Bold','Xcolor', axcolor,...
    'Ycolor', axcolor,'xtick',[year_loc],'xticklabel',labels,'xticklabelrotation',45); 
ylabel('Outflow (10^6 m³)','Fontsize', 12, 'Fontweight', 'Bold', 'color', axcolor)
grid on