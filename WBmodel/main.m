% --------------------------------------------------------------------
% WBM_LakeVictoria 
% 
% Matlab code for the Water Balance Model for Lake Victoria
% Written by Inne Vanderkelen, March, 2018. 
% For more information check accompaying README.md file

% References:
% - Vanderkelen, I., van Lipzig, N. P. M., and Thiery, W., 2018a. Modelling 
% the water balance of Lake Victoria (East Africa) – Part 1: Observational 
% analysis, Hydrol. Earth Syst. Sci., accepted. 
% - Vanderkelen, I., van Lipzig, N. P. M. and Thiery, W., 2018b. Modelling 
% the water balance of Lake Victoria (East Africa) – Part 2: Future 
% projections, Hydrol. Earth Syst. Sci., accepted.
% --------------------------------------------------------------------

% clean up
clc;
clear all;
%close all;

tic

% add matlab scripts directory to path
addpath(genpath('C:\Users\ivand\Documents\MATLAB\WBM_LakeVictoria'));

% 1. User options 
% ------------------------------------------------------------------------

% initialise run:   # 1 : observation run       (1993-2014)
%                   # 2 : CORDEX evaluation run (1999-2008)
%                   # 3 : CORDEX historical run (1951-2005)
%                   # 4 : CORDEX RCP 26 run     (2005-2100)
%                   # 5 : CORDEX RCP 45 run     (2005-2100)
%                   # 6 : CORDEX RCP 85 run     (2005-2100)

flag_run = 4;

% initialise type run: # 1 : full run (calculate all terms from netcdf files; only for observation run)
%                      # 2 : load saved WB terms (goes quicker)


flag_type = 2; 

% initialise bias correction type: #0 : no bias correction
%                                  #1 : QUANT (empirical quantiles)
%                                  #2 : PFT linear (parametric
%                                  transformation) 
%                                  
flag_bc = 2; 

% initialise outflow scenario: #1: historical HPP (see script determ_Pel for value)
%                              #2: maximum HPP (see script determ_Pel for value)
%                              #3: constant lake level
%                              #4: according to Agreed Curve
% (not necessary when observational run: observed lake levels are taken) 
flag_outscen = 1; 


% 2. Initialisation
% --------------------------------------------------------------------

initialisation; 


% 3. Load and manipulate non-climatological data
% --------------------------------------------------------------------

load_data

manip_data


% 4. Load WB terms and calculate WB
% --------------------------------------------------------------------

if flag_run == 1
       
        if flag_type == 1  % calculate all WB terms (only for observational run) 

        
        % load observational data
        load_obsdata; 
        
        % manipulate observational data
        manip_obsdata; 
        
        % calculate observational WB terms
        calcWBterms_obs; 
        
        end
        
elseif flag_type == 2
    
        load_WBterms; 

end

WBmodel;

toc


% ------------------------------------------------------------------------
% 5. Plotting

main_plotting

% save the lake level simulation for plotting. 
%save_L