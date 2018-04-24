% ------------------------------------------------------------------------
% Correct the number of days in simulations
% 
% Total number of days in future period: 34698
% 
% Categories to correct
%      -  noleap : simulation without leap years (total: 34675) 
%      -  year360 : 360 days year
%      -  other
% ------------------------------------------------------------------------


% define the category of the model. 
noleap_GCM = [{'CanESM2'};{'NorESM1-M'}; {'MIROC5'};{'GFDL-ESM2M'}; {'CM5A-MR'}; {'CSIRO-Mk3-6-0'};{'CanESM2'}]; 
year360_GCM = [{'HadGEM2-ES'}];

% define P and LHF with correct number of days
nx = size(P_init,1); 
ny = size (P_init,2); 

P = zeros(nx,ny,ndays); 
LHF = zeros(nx,ny,ndays); 


% ---------- NO LEAP YEARS -----------------------------------------------
% no leap years

if ismember(GCM(i,1),noleap_GCM) == 1
       fprintf('Correcting RCM %d from %d \n', i, nm)

        % MIROC5 combined with REMO2009, leap years are taken into account. 
       
       if (strcmp(GCM(i,1),'MIROC5')==1 && strcmp(GCM(i,1),'REMO2009_')==1)
          
           P = P_init;
           LHF = LHF_init;
      
       else
           leap_location = locate_leapdays(date);
           leap_location(length(leap_location)+1)=length(P_init)+1; 
           start = 1;          

            % Loop over leap locations and add leap days within new P 
            for j = 1:length(leap_location) 

                ind_lp = leap_location(j); 
                stop = ind_lp-1; 

                % add all years untill leap location
               P(:,:,start+j-1:stop+j-1) = P_init(:,:,start:stop); 
               LHF(:,:,start+j-1:stop+j-1) = LHF_init(:,:,start:stop);
               
                % define start index
                start = ind_lp; 
            end
           
            % Fill in leap numbers
            for j = 1:length(leap_location) 
                ind_lp= leap_location(j); 
                P(:,:,ind_lp) = (P(:,:,ind_lp-1)+ P(:,:,ind_lp+1))/2; 
                LHF(:,:,ind_lp) = (LHF(:,:,ind_lp-1)+ LHF(:,:,ind_lp+1))/2;
            end 
       end
       if strcmp(RCM(i),[{'CRCM5_'}])==1
     
         P(:,:,length(P)) = P_init(:,:,length(P_init)); 
         LHF(:,:,length(P)) = LHF_init(:,:,length(P_init));
         
       end

% ---- CORRECT 360 YEARS -------------------------------------------------
% 5 extra days are added on every 72 days in the year (360/5
% = 73). Starting after the 36th day (72/2=36). 

elseif ismember(GCM(i,1),year360_GCM) == 1
   
    fprintf('Correcting RCM %d from %d for 360 days and an extra year \n', i, nm)

    xtra_location = locate_extradays(date);   
    xtra_location(length(xtra_location)+1) = length(P_init);    
       
    start = 1; 
    
       for j = 1:(length(xtra_location))
           
           ind_xtra = xtra_location(j)+1; 
           stop = ind_xtra-1; 
           
           P_temp(:,:,start+j-1:stop+j-1) = P_init(:,:,start:stop); 
           LHF_temp(:,:,start+j-1:stop+j-1) = LHF_init(:,:,start:stop);
                         
           start = ind_xtra+1; 
       end
      
       
       for j = 1:(length(xtra_location)-1)
            ind_xtra = xtra_location(j)+1; 
            P_temp(:,:,ind_xtra) = (mean(P_temp(:,:,(ind_xtra-36:ind_xtra-1)),3)+ mean(P_temp(:,:,(ind_xtra+1:ind_xtra+36)),3))./2; 
            LHF_temp(:,:,ind_xtra) = (mean(LHF_temp(:,:,(ind_xtra-36:ind_xtra-1)),3)+ mean(LHF_temp(:,:,(ind_xtra+1:ind_xtra+36)),3))./2;
            
       end
       
       % ----------- CORRECT BRITTISH MODEL FOR LEAP DAYS ----------------     
       leap_location = locate_leapdays(date);
       leap_location(length(leap_location)+1)= length(P_temp)+1;%+length(leap_location); 
       
       start = 1;          

       % Loop over leap locations and add leap days within new P 
       for j = 1:length(leap_location) 

                ind_lp = leap_location(j); 
                stop = ind_lp-1; 

                % add all years untill leap location
               P(:,:,start+j-1:stop+j-1) = P_temp(:,:,start:stop); 
               LHF(:,:,start+j-1:stop+j-1) = LHF_temp(:,:,start:stop);
               
                % define start index
                start = ind_lp; 
       end
           
            % Fill in leap numbers
       for j = 1:(length(leap_location)-1)
                ind_lp= leap_location(j); 
                P(:,:,ind_lp) = (P(:,:,ind_lp-1)+ P(:,:,ind_lp+1))/2; 
                LHF(:,:,ind_lp) = (LHF(:,:,ind_lp-1)+ LHF(:,:,ind_lp+1))/2;
       end    
       clear P_temp LHF_temp
      
       % ---------------- DEAL WITH EXCEPTIONS ON BRITISH MODEL ----------
     % 
       if flag_run == 5 | (flag_run==6 & strcmp(RCM(i),[{'CCLM4-8-17_'}]) ==1)
       
       ind_begindec = 34303; 
       ind_beginnov =ind_begindec-31; 
       
       P(:,:,ind_begindec:ind_begindec+30)=P(:,:,ind_beginnov:ind_beginnov+30); 
       LHF(:,:,ind_begindec:ind_begindec+30)=LHF(:,:,ind_beginnov:ind_beginnov+30); 
     

       % ---------------CORRECT BRITISH MODEL FOR MISSING YEAR -----------
      end

       % define boundary indices
       begin_2099 = length(P)-2*365+1;
       end_2099 = length(P)-365; 
       begin_2100 = length(P)-365+1; 
       end_2100 = length(P); 
       
       P(:,:,begin_2100:end_2100)=P(:,:,begin_2099:end_2099); 
       LHF(:,:,begin_2100:end_2100)=LHF(:,:,begin_2099:end_2099); 


 
 % ------------------ OTHER EXCEPTIONS -----------------------------------
 % 1 : REMO2009 EC-EARTH rcp26 starts on 2nd of Januari
elseif flag_run == 4 &  strcmp(RCM(i),[{'REMO2009_'}])==1 & strcmp(GCM(i),[{'EC-EARTH'}])==1
     
        P(:,:,2:length(P)) = P_init; 
        P(:,:,1) = P(:,:,2); 
        
        LHF(:,:,2:length(P)) = LHF(:,:,1:length(P)-1); 
        LHF(:,:,1) = LHF(:,:,2); 
 
 
 % 2: CRCM5 31 december 2100 misses. 
elseif strcmp(RCM(i),[{'CRCM5_'}])==1
   
   P = P_init;
   LHF = LHF_init;
    
   P(:,:,length(P)+1) = P_init(:,:,length(P_init)); 
   LHF(:,:,length(P)+1) = LHF_init(:,:,length(P_init));
    
% ---------------- No EXCEPTIONS ----------------------------------------- 
else
    % no exceptions
      P = P_init;
      LHF = LHF_init;
end

clear P_init LHF_init
 