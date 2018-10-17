% ------------------------------------------------------------------------
% Script to exclude any simulation from set 
% General function. 


function [new_data] = exclude_sim(old_data, row)

    [x,y] = size(old_data); 
    temp = zeros(x-1,y); 

    temp(1:row-1,:) = old_data(1:row-1,:); 
    temp(row:x-1,:) = old_data(row+1:x,:); 
    new_data = temp; 
end
