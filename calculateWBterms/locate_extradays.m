% ------------------------------------------------------------------------
% Matlab function to locate the days to be added to make a 365 year of the
% 360 days year for the whole simulation period (34698 days) 
% ------------------------------------------------------------------------

function [xtra_locations] = locate_extradays(date) 


% define indices where extra day is added (add 
        ind_afterxtrday = [36,108,180,252,324];
        
        % define number of years. 
        nyears = length(unique(date(:,1))); 
        
        xtra_locations = ind_afterxtrday; 
       % indices + 360 * number of years
       for i = 1:(nyears-2)
           xtra_locations_yr = ind_afterxtrday + 360 * i; 
           xtra_locations = [xtra_locations, xtra_locations_yr];
       end
            
end