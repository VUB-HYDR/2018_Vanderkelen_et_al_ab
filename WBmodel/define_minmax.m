% ------------------------------------------------------------------------
% Function to define the minimum and maximum lake level for the different
% outflow scenarios
% ------------------------------------------------------------------------

function [Lbounds] = define_minmax(flag_outscen)

    load diff_abs_jinja 
    dam_height = diff_abs_jinja + 31;
    safety = 7; 
    hmax = dam_height-safety; 
    % Agreed Curve 
    if flag_outscen == 4
       Lmin = 10 + diff_abs_jinja; % Source: figure  
       Lmax = 13.5 + diff_abs_jinja;
    elseif flag_outscen == 1 % constant outflow max
       Lmin = diff_abs_jinja; 
       Lmax = hmax ;
    elseif flag_outscen == 2 % constant outflow min
       Lmin = diff_abs_jinja; 
       Lmax = hmax ;
    elseif flag_outscen == 3 % constant lake level
       Lmin = 0; 
       Lmax = hmax ;
    end
    
Lbounds = [Lmin Lmax]; 

end
