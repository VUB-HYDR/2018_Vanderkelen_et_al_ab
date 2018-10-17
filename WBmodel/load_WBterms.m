% --------------------------------------------------------------------
% Script to load calculated WB terms for CORDEX data (historical and RCPs
% --------------------------------------------------------------------
  
if flag_bc == 0  
     
    if flag_run == 1 % observation
        
        load P_wb_obs
        load E_wb_obs
        load Qin_wb_obs 
        
    elseif flag_run == 2 % evaluation

        load P_wb_ev
        load E_wb_ev
        load Qin_wb_ev    

    elseif flag_run == 3 % historical

        load P_wb_hist
        load E_wb_hist
        load Qin_wb_hist

    elseif flag_run == 4 % RCP 2.6 

        load P_wb_rcp26
        load E_wb_rcp26
        load Qin_wb_rcp26

    elseif flag_run == 5 % RCP 4.5

        load P_wb_rcp45
        load E_wb_rcp45
        load Qin_wb_rcp45

    elseif flag_run == 6 % RCP 8.5

        load P_wb_rcp85
        load E_wb_rcp85
        load Qin_wb_rcp85

    end

elseif flag_bc == 1 % QUANT
    
    if flag_run == 2 % evaluation

    E_wb_ev = csvread('data\biascorrection\QUANT\E_wb_ev_bc.csv',1)'; 
    P_wb_ev = csvread('data\biascorrection\QUANT\P_wb_ev_bc.csv',1)'; 
    Qin_wb_ev = csvread('data\biascorrection\QUANT\Qin_wb_ev_bc.csv',1)';    

    elseif flag_run == 3 % historical

    E_wb_hist = csvread('data\biascorrection\QUANT\E_wb_hist_bc.csv',1)'; 
    P_wb_hist = csvread('data\biascorrection\QUANT\P_wb_hist_bc.csv',1)'; 
    Qin_wb_hist = csvread('data\biascorrection\QUANT\Qin_wb_hist_bc.csv',1)';  

    elseif flag_run == 4 % RCP 2.6 

    E_wb_rcp26 = csvread('data\biascorrection\QUANT\E_wb_rcp26_bc.csv',1)'; 
    P_wb_rcp26 = csvread('data\biascorrection\QUANT\P_wb_rcp26_bc.csv',1)'; 
    Qin_wb_rcp26 = csvread('data\biascorrection\QUANT\Qin_wb_rcp26_bc.csv',1)';  

    elseif flag_run == 5 % RCP 4.5 

    E_wb_rcp45 = csvread('data\biascorrection\QUANT\E_wb_rcp45_bc.csv',1)'; 
    P_wb_rcp45 = csvread('data\biascorrection\QUANT\P_wb_rcp45_bc.csv',1)'; 
    Qin_wb_rcp45 = csvread('data\biascorrection\QUANT\Qin_wb_rcp45_bc.csv',1)';  

    elseif flag_run == 6 % RCP 8.5

    E_wb_rcp85 = csvread('data\biascorrection\QUANT\E_wb_rcp85_bc.csv',1)'; 
    P_wb_rcp85 = csvread('data\biascorrection\QUANT\P_wb_rcp85_bc.csv',1)'; 
    Qin_wb_rcp85 = csvread('data\biascorrection\QUANT\Qin_wb_rcp85_bc.csv',1)';  

    end
    
    E_wb_hist = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\QUANT\E_wb_hist_bc.csv',1)'; 
    P_wb_hist = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\QUANT\P_wb_hist_bc.csv',1)'; 
    Qin_wb_hist = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\QUANT\Qin_wb_hist_bc.csv',1)';  

    E_wb_rcp26 = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\QUANT\E_wb_rcp26_bc.csv',1)'; 
    P_wb_rcp26 = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\QUANT\P_wb_rcp26_bc.csv',1)'; 
    Qin_wb_rcp26= csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\QUANT\Qin_wb_rcp26_bc.csv',1)';  
    
    E_wb_rcp45 = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\QUANT\E_wb_rcp45_bc.csv',1)'; 
    P_wb_rcp45 = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\QUANT\P_wb_rcp45_bc.csv',1)'; 
    Qin_wb_rcp45 = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\QUANT\Qin_wb_rcp45_bc.csv',1)';  
    
    E_wb_rcp85 = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\QUANT\E_wb_rcp85_bc.csv',1)'; 
    P_wb_rcp85 = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\QUANT\P_wb_rcp85_bc.csv',1)'; 
    Qin_wb_rcp85 = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\QUANT\Qin_wb_rcp85_bc.csv',1)';  

    
elseif flag_bc == 2 % LINEAR PARAMETRIC TRANSFORMATION
    
     if flag_run == 2 % evaluation

    E_wb_ev = csvread('data\biascorrection\PFT_lin\E_wb_ev_bc.csv',1)'; 
    P_wb_ev = csvread('data\biascorrection\PFT_lin\P_wb_ev_bc.csv',1)'; 
    Qin_wb_ev = csvread('data\biascorrection\PFT_lin\Qin_wb_ev_bc.csv',1)';    

    elseif flag_run == 3 % historical

    E_wb_hist = csvread('data\biascorrection\PFT_lin\E_wb_hist_bc.csv',1)'; 
    P_wb_hist = csvread('data\biascorrection\PFT_lin\P_wb_hist_bc.csv',1)'; 
    Qin_wb_hist = csvread('data\biascorrection\PFT_lin\Qin_wb_hist_bc.csv',1)';  

    elseif flag_run == 4 % RCP 2.6 

    E_wb_rcp26 = csvread('data\biascorrection\PFT_lin\E_wb_rcp26_bc.csv',1)'; 
    P_wb_rcp26 = csvread('data\biascorrection\PFT_lin\P_wb_rcp26_bc.csv',1)'; 
    Qin_wb_rcp26 = csvread('data\biascorrection\PFT_lin\Qin_wb_rcp26_bc.csv',1)';  

    elseif flag_run == 5 % RCP 4.5 

    E_wb_rcp45 = csvread('data\biascorrection\PFT_lin\E_wb_rcp45_bc.csv',1)'; 
    P_wb_rcp45 = csvread('data\biascorrection\PFT_lin\P_wb_rcp45_bc.csv',1)'; 
    Qin_wb_rcp45 = csvread('data\biascorrection\PFT_lin\Qin_wb_rcp45_bc.csv',1)';  

    elseif flag_run == 6 % RCP 8.5

    E_wb_rcp85 = csvread('data\biascorrection\PFT_lin\E_wb_rcp85_bc.csv',1)'; 
    P_wb_rcp85 = csvread('data\biascorrection\PFT_lin\P_wb_rcp85_bc.csv',1)'; 
    Qin_wb_rcp85 = csvread('data\biascorrection\PFT_lin\Qin_wb_rcp85_bc.csv',1)';  

     end
    
    
    E_wb_hist = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\PFT_lin\E_wb_hist_bc.csv',1)'; 
    P_wb_hist = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\PFT_lin\P_wb_hist_bc.csv',1)'; 
    Qin_wb_hist = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\PFT_lin\Qin_wb_hist_bc.csv',1)';  

    E_wb_rcp26   = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\PFT_lin\E_wb_rcp26_bc.csv',1)'; 
    P_wb_rcp26   = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\PFT_lin\P_wb_rcp26_bc.csv',1)'; 
    Qin_wb_rcp26 = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\PFT_lin\Qin_wb_rcp26_bc.csv',1)'; 
    
    E_wb_rcp45i = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\PFT_lin\E_wb_rcp45_bc.csv',1)'; 
    P_wb_rcp45i = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\PFT_lin\P_wb_rcp45_bc.csv',1)'; 
    Qin_wb_rcp45i = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\PFT_lin\Qin_wb_rcp45_bc.csv',1)';  

    E_wb_rcp85 = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\PFT_lin\E_wb_rcp85_bc.csv',1)'; 
    P_wb_rcp85 = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\PFT_lin\P_wb_rcp85_bc.csv',1)'; 
    Qin_wb_rcp85 = csvread('C:\Users\ivand\Documents\MATLAB\Thesis\Rscripts\data\PFT_lin\Qin_wb_rcp85_bc.csv',1)';  
    
end