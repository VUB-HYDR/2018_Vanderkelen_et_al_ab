
% ------------------------------------------------------------------------
% Function to solve the Water Balance
%   INPUT:  - mean precipitation over the lake
%           - mean evaporation over the lake
%           - inflow
%           - outflow
%           - lake surface area
%           - initial lake level
%   OUTPUT: - L lakelevel
% ------------------------------------------------------------------------

function [L,Qout] = solveWB(P_mean,E_mean,Qin,Qout, A_lake, L0, ndays,flag_run,flag_outscen,Pel,k,Lbounds)
       
L(1) = L0;
    for t = 1:ndays-1
        
        % observational WB
        if flag_run==1||flag_run==2
          
            L(t+1) = L(t)+ P_mean(t) - E_mean(t) + (Qin(t)- Qout(t))/(A_lake); 

        % other WBs    
        elseif flag_run>2
             if flag_outscen <3
                 
                 if L(t) > Lbounds(2)
                      Qout(t) = Qin(t) - A_lake*(Lbounds(2)-L(t)+E_mean(t) - P_mean(t)); 

                 elseif L(t) <= Lbounds(1)
                      Qout(t) = 0;
                 else
                     Qout(t) = solveQout(L(t),flag_outscen,Pel,k); 
                 end
            
                 L(t+1) = L(t)+ P_mean(t) - E_mean(t) + (Qin(t)- Qout(t))/(A_lake); 
                 
             elseif flag_outscen == 3 % constant lake level
                
                 if L(t) >= L0
                     Qout(t) = ((P_mean(t)-E_mean(t))*A_lake+Qin(t)); 

                     if Qout(t) <0 % accounting for negative outflow: lake level decreases
                         Qout(t) = 0;
                     L(t+1) =  L(t)+ P_mean(t) - E_mean(t) + (Qin(t))/(A_lake);
                     else
                        L(t+1) = L(t)+ P_mean(t) - E_mean(t) + (Qin(t)- ((P_mean(t)-E_mean(t))*A_lake+Qin(t)))/(A_lake); 
                     end
                 
                 elseif L(t) < L0 % if lake level does not meet constant lake level (yet)
                     L(t+1) = L(t)+ P_mean(t) - E_mean(t) + (Qin(t))/(A_lake);

                     if L(t) > L0 % increase above constant lake level becomes outflow
                         Qout(t) = L(t)-L0; 
                         L(t) = L(t)-Qout(t);
                     else
                         Qout(t) = 0;
                     end
                 end
            elseif flag_outscen == 4 % agreed curve
                
                if L(t) < 1130
                    Qout(t) = 0; 
                    
                elseif L(t) > 1136.5
                    Qout(t) = Qin(t) - A_lake*(Lbounds(2)-L(t)+E_mean(t) - P_mean(t)); 
             
                else
                    Qout(t) = solveQout(L(t),flag_outscen,Pel,k);
                end
                L(t+1) = L(t)+ P_mean(t) - E_mean(t) + (Qin(t)- Qout(t))/(A_lake); 

            end
            
        end
        

    end
end


