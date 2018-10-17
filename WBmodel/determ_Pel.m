% ------------------------------------------------------------------------
% Script to calculate Pel (kW/day) and determine k: efficiency factor (kN/m³)
% ------------------------------------------------------------------------

% load absolute base eigt dam
load diff_abs_jinja.mat

Pel_m_nalu  = 180000; %[kW] (value from globalenergyobservatory.org)
Pel_m_kiira = 200000; %[kW] (value from globalenergyobservatory.org)
Pel_m_sum = Pel_m_nalu + Pel_m_kiira; 

Qmax_nalu = 1200; % [m³/s] (turbines; Kizza et al., 2006  )
Qmax_kiira = 1100; % [m³/s] (turbines; Kizza et al., 2006  )
Qmax_mean = (Qmax_nalu + Qmax_kiira)/2; 

% simplification: water head = relative height of the water at the dam.
h_max = 24; % maximum water head (m) (similar for nalu and kiira)

% calculate efficiency factor k [kN/m³]
k = Pel_m_sum./ (Qmax_mean * h_max); 

% Pel elektricity generation corresponding to mean observed outflow of historical
% period
Qout_mean_ms = mean(outflow)/(24*60*60); % in m³/s
h_mean = mean(lakelevel_all) - diff_abs_jinja; 
Pel_hist = mean(Qout_mean_ms*k*h_mean); 

% Pel for period for 1955 (minimum outflow) 
[isdate_1955, date_loc_date] = ismember(date_all(:,1),1955); 
Qout_mean_1955_ms = 55*10^6./(24*60*60); 
h_mean_1955 =  lakelevel_all(isdate_1955') - diff_abs_jinja; 
Pel_1955 = mean(Qout_mean_1955_ms*k*h_mean_1955); 

% Pel for period for 1964 (maximum outflow)
[isdate_1964, date_loc_date] = ismember(date_all(:,1),1964); 
Qout_mean_1964_ms = 138*10^6./(24*60*60); 
h_mean_1964 = lakelevel_all(isdate_1964') - diff_abs_jinja; 
Pel_1964 = mean(Qout_mean_1964_ms*k*h_mean_1964); 


if flag_outscen == 1
    Pel = Pel_hist; 
elseif flag_outscen == 2
    Pel = Pel_1964; 
else
    Pel = 0; 
end