% ----------------------------------------------------------------------------
% Function to calculate 95% confidence interval of a data series

function CI = calc_CI(data)

    % calculate 95% confidence intervals on difference 
    SEM = std(data)./sqrt(length(data)); % Standard Error
    ts = tinv([0.05  0.95],length(data)-1);      % T-Score
    CI = mean(data) + ts.*SEM;    % Confidence Intervals


end