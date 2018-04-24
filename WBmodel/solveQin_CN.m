% --------------------------------------------------------------------
% Function to calculate lake inflow based on CN method
% INPUTS: 
%           - precipitation in the basin (P_basin)
%           - Curve Number
%           - number of days of which antecent moisture taken into account
%           - number of days of model period
%           - surface area of one pixel. 
% --------------------------------------------------------------------

function [Qin,Q] = solveQin_CN(P_basin, CN, amc_days, ndays, A_cell)

    fprintf('Calculating Qin ... \n ');

    % initialise 
    Q = zeros(size(P_basin));  % outflows 
    AM = zeros(size(P_basin)); % antecedent moisture

    % initialise AM for first amc_days
    AM(:,:, 1:amc_days) = 0.0112; % mean condtion
    
    % loop over all cells to calculate runoff
    for t=amc_days:ndays
         for i = 1:size(P_basin,1)
             for j = 1:size(P_basin,2)

               % determine antecedent moisture condition
                if t>amc_days
                    for k = 1:amc_days
                        AM(i,j,t) = AM(i,j,t)+P_basin(i,j,t-k); 
                    end
                end

                % determine CN runoff
                [Q(i,j,t),CN_AMC(i,j,t)] = calc_runoff_CN(P_basin(i,j,t),AM(i,j,t),CN(i,j)); 

              end 
         end

         % calculate total runoff of basin
         Qin(t) = nansum(nansum(Q(:,:,t).*A_cell));

     end
end
 
 