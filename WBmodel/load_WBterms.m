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

    E_wb_ev = csvread('QUANT\E_wb_ev_bc.csv',1)'; 
    P_wb_ev = csvread('QUANT\P_wb_ev_bc.csv',1)'; 
    Qin_wb_ev = csvread('QUANT\Qin_wb_ev_bc.csv',1)';    

    elseif flag_run == 3 % historical

    E_wb_hist = csvread('QUANT\E_wb_hist_bc.csv',1)'; 
    P_wb_hist = csvread('QUANT\P_wb_hist_bc.csv',1)'; 
    Qin_wb_hist = csvread('QUANT\Qin_wb_hist_bc.csv',1)';  

    elseif flag_run == 4 % RCP 2.6 

    E_wb_rcp26 = csvread('QUANT\E_wb_rcp26_bc.csv',1)'; 
    P_wb_rcp26 = csvread('QUANT\P_wb_rcp26_bc.csv',1)'; 
    Qin_wb_rcp26 = csvread('QUANT\Qin_wb_rcp26_bc.csv',1)';  

    elseif flag_run == 5 % RCP 4.5 

    E_wb_rcp45 = csvread('QUANT\E_wb_rcp45_bc.csv',1)'; 
    P_wb_rcp45 = csvread('QUANT\P_wb_rcp45_bc.csv',1)'; 
    Qin_wb_rcp45 = csvread('QUANT\Qin_wb_rcp45_bc.csv',1)';  

    elseif flag_run == 6 % RCP 8.5

    E_wb_rcp85 = csvread('QUANT\E_wb_rcp85_bc.csv',1)'; 
    P_wb_rcp85 = csvread('QUANT\P_wb_rcp85_bc.csv',1)'; 
    Qin_wb_rcp85 = csvread('QUANT\Qin_wb_rcp85_bc.csv',1)';  

    end
    
elseif flag_bc == 2 % LINEAR PARAMETRIC TRANSFORMATION
    
     if flag_run == 2 % evaluation

    E_wb_ev = csvread('PFT_lin\E_wb_ev_bc.csv',1)'; 
    P_wb_ev = csvread('PFT_lin\P_wb_ev_bc.csv',1)'; 
    Qin_wb_ev = csvread('PFT_lin\Qin_wb_ev_bc.csv',1)';    

    elseif flag_run == 3 % historical

    E_wb_hist = csvread('PFT_lin\E_wb_hist_bc.csv',1)'; 
    P_wb_hist = csvread('PFT_lin\P_wb_hist_bc.csv',1)'; 
    Qin_wb_hist = csvread('PFT_lin\Qin_wb_hist_bc.csv',1)';  

    elseif flag_run == 4 % RCP 2.6 

    E_wb_rcp26 = csvread('PFT_lin\E_wb_rcp26_bc.csv',1)'; 
    P_wb_rcp26 = csvread('PFT_lin\P_wb_rcp26_bc.csv',1)'; 
    Qin_wb_rcp26 = csvread('PFT_lin\Qin_wb_rcp26_bc.csv',1)';  

    elseif flag_run == 5 % RCP 4.5 

    E_wb_rcp45 = csvread('PFT_lin\E_wb_rcp45_bc.csv',1)'; 
    P_wb_rcp45 = csvread('PFT_lin\P_wb_rcp45_bc.csv',1)'; 
    Qin_wb_rcp45 = csvread('PFT_lin\Qin_wb_rcp45_bc.csv',1)';  

    elseif flag_run == 6 % RCP 8.5

    E_wb_rcp85 = csvread('PFT_lin\E_wb_rcp85_bc.csv',1)'; 
    P_wb_rcp85 = csvread('PFT_lin\P_wb_rcp85_bc.csv',1)'; 
    Qin_wb_rcp85 = csvread('PFT_lin\Qin_wb_rcp85_bc.csv',1)';  

    end
    
end