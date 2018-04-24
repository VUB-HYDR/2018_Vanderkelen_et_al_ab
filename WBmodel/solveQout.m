% ------------------------------------------------------------------------
% Implement future Outflow Scenario
% flag_outscen = 1: constant outflow
%                 2: constant lake level
%                 3: according to Agreed Curve
% ------------------------------------------------------------------------

function [Qout] =  solveQout(L)
    
    % Agreed Curve parameters (according to Sene, 2000)
    a = 66.3;
    b = 2.01;
    c = 7.96;
    
    % convert lake level to Jinja dam level
    load diff_abs_jinja
    if L>(diff_abs_jinja + c)
        L_dam = L-diff_abs_jinja; 
    else 
        L_dam = c; 
    end
    
    
    % calculate outflow (agreed curve: in m³ per second)
    Qout_s = a.*(L_dam-c).^b;
    % convert to m³/day
    Qout = Qout_s.*3600.*24;

end