% --------------------------------------------------------------------
% Subroutine to perform manipulations on observational variables
% --------------------------------------------------------------------

% manipulations on P
% ------------------------------------------------------------------------
%P = flipud(P); 
begin_p = length(P)-ndays; 
P = P(:,:,begin_p:length(P));
 
% convert to right units (from mm/m²day to m/m²day)

P = P .* 10^(-3);

   for i = 1:size(P,3)
   P_lake(:,:,i) = mask_lake.*P(:,:,i);
   P_basin(:,:,i) = mask_basin.*P(:,:,i);
   end
   
   
% manipulations on LHF of model
% ------------------------------------------------------------------------
% Based on montly mean LHF, determine value for every day

% interpolate on own grid
[Xq,Yq] = meshgrid(1:1:130); 

for i = 1:size(LHF_daymean,3)
  [LHF_intp(:,:,i), lat_intp, lon_intp] = ...
      remap2owngrid(LHF_daymean(:,:,i), lat_CCLM, lon_CCLM); 
end

% find the indices of the year array for every day in the whole period
[isday, ind_day]=ismember(date(:,2:3),month_day,'rows'); 
% extract the days
for i = 1:length(date_obs)
   LHF(:,:,i) = LHF_intp(:,:,ind_day(i)); 
end



E = -LHF/Lvap * 3600 * 24; 
E = E*10^(-3);


for i = 1:size(E,3)
 E_lake(:,:,i) = mask_lake_intp.*E(:,:,i);
end
