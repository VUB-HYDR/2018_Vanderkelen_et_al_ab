% ------------------------------------------------------------------------
% Calculate outflow following the Agreed Curve
% ------------------------------------------------------------------------

function [Qout] =  solveQout(L,flag_outscen,Pel,k)
    load diff_abs_jinja

% Calculate outflow based on constant electricity production
    if flag_outscen < 3
        
        % define constants (k is given)
        Qmax_nalu = 1200; % [m³/s] (turbines; Kizza et al., 2006  )
        Qmax_kiira = 1100; % [m³/s] (turbines; Kizza et al., 2006  )
        Qmax_mean = (Qmax_nalu + Qmax_kiira)/2;
        Q_maxcap = Qmax_mean * (60*60*24);% [m³/day]
           
       
        % define water head
        h = L - diff_abs_jinja;

        % calculate outflow based on water head and electricity demand
       
        Q_req_ms = Pel/(h*k);  % [m³/s]
        % convert to m³/day
        Q_req = Q_req_ms * (60*60*24); 
        Qout = min(Q_req, Q_maxcap); 
    end

% Calculate outflow following the Agreed Curve
    if flag_outscen == 4
        % Agreed Curve parameters (according to Sene, 2000)
        a = 66.3;
        b = 2.01;
        c = 7.96;

        % convert lake level to Jinja dam level
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
end