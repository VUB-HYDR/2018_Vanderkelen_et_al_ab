% -------------- --------------------------------------------------------
% script to locate leap days (indices) in a period 
% ----------------------------------------------------------------------

function [leap_locations] = locate_leapdays(date) 

    monthday = date(:,2:3); 
    leapmonthday = [2 29 ]; 
    [~,leap_occurrence] = ismember(monthday,leapmonthday,'rows'); 

    leap_locations = find(leap_occurrence==1); 
end