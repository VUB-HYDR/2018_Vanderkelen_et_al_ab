% --------------------------------------------------------------------
% Subroutine to perform manipulations on loaded variables:
%       1. create lake mask and basin mask
%       2. calculate lake surface
%       3. manipulate lake level series
%       4. manipulate outflow series (based on outflow scenario)
%       5. manipulate lake bathymetry (regridding)
%                   
% --------------------------------------------------------------------

% 1. create lake mask and basin mask
% get lake pixel indices
shp_Vict = struct2cell(shp_Vict);
xv_lake = shp_Vict{3,3};
yv_lake = shp_Vict{4,3};

% find coordinates of grid (not possible through netcdf file)
define_grid; 
islake = inpolygon(lon,lat, xv_lake,yv_lake);

% create lake mask
mask_lake = zeros(size(islake))+1;
mask_lake(find(islake==0)) = NaN;

% get Lake Victoria BASIN pixel indices 
shp_basin = struct2cell(shp_basin);
xv_basin = shp_basin{3,1};
yv_basin = shp_basin{4,1};

% find coordinates of grid (not possible through netcdf file)
isbasin = inpolygon(lon,lat,xv_basin,yv_basin); 
isbasin(find(islake==1))=0; 
% create basin mask
mask_basin = zeros(size(isbasin))+1;
mask_basin(find(isbasin==0)) = NaN; 
mask_basin(find(islake==1))= NaN; 

mask_lakebasin = zeros(size(isbasin))+1;
mask_lakebasin(find(isbasin==0&islake==0)) = NaN; 


% Calculate lake surface
A_lake = res_m^2*sum(islake(:)); 

% Interpolate CCLM grid to own grid
[depth, lat_intp, lon_intp] = remap2owngrid(depth_CCLM, lat_CCLM, lon_CCLM); 

% Extract lake Victoria (define mask based on interpolated grid)
islake_intp = inpolygon(lon_intp,lat_intp,xv_lake,yv_lake); 
mask_lake_intp = zeros(size(islake_intp))+1;
mask_lake_intp(find(islake_intp==0)) = NaN;

% manipulate observed lakelevels
 manip_lakelevel

% 4. manipulate outflow 

if flag_run <=3 % observation, evaluation and historical run
    
    % Extract outflow series needed for model setup (date)
    [isdate_date, date_loc_date] = ismember(date_all,date,'rows'); 
    ind_min_Qout = min((find(date_loc_date>0))); 
    ind_max_Qout = max((find(date_loc_date>0))); 

    Qout = outflow(ind_min_Qout:ind_max_Qout); 
    
% define value in case of constant outflow
elseif flag_outscen < 3 
    Qout = NaN(1,ndays); 
    
    % calculate mean annual outflow 
    time_begin_outflow  = [1950, 1, 1, 0,0,0]; 
    time_end_outflow   = [2014,12,31,23,0,0];
    date_vec_outflow= datevec(datenum(time_begin_outflow):1:datenum(time_end_outflow));
    date_outflow = date_vec_outflow(:,1:3);
    years = 1954:2006;

    for t = 1:length(years)
        [~, ind_year(t)] = ismember(years(t),date_outflow(:,1)); 
    end


    for t = 1:(length(years)-1)
       outflow_yearmean(t) = nanmean(outflow((ind_year(t):(ind_year(t+1)-1))));    
    end 
    
    outflow_min = min(outflow_yearmean); 
    outflow_max = max(outflow_yearmean); 
    
    year_min = years(find(outflow_yearmean==min(outflow_yearmean)));
    year_max = years(find(outflow_yearmean==max(outflow_yearmean)));

    % choose which constant outflow 
    if flag_outscen ==1 
    Qout(1,:) =  outflow_max; 
    
    elseif flag_outscen ==2 
    Qout(1,:) =  outflow_min; 
    end
    
else
    Qout = 0;  % exact values are calculated within WB model
end

% 5. manipulate lake bathymetry
% (similar grid as LHF)

[depth_intp(:,:), lat_intp, lon_intp] = ...
      remap2owngrid(depth_CCLM(:,:), lat_CCLM, lon_CCLM); 

 depth_lake_temp(:,:) = mask_lake_intp.*depth_intp(:,:);

% regridding to own grid: define remapping lon and lat
pixel_owngrid = [62 47]; 
pixel_LHF = [27 37]; 
[indx_nan,~] = find(~isnan(lat_intp(:,1))); 
[~,indy_nan] = find(~isnan(lon_intp(1,:))); 
lat_pix_owngrid = lat_grid(pixel_owngrid(1));
lon_pix_owngrid = lon_grid(pixel_owngrid(2));

lat_begin_pix_LHF = lat_pix_owngrid-27*res_grid; 
lon_begin_pix_LHF = lon_pix_owngrid-37*res_grid; 
lat_end_pix_LHF = lat_begin_pix_LHF+(length(indy_nan)-1)*res_grid; 
lon_end_pix_LHF = lon_begin_pix_LHF+(length(indx_nan)-1)*res_grid; 

lat_LHF_remap = lat_begin_pix_LHF:res_grid:lat_end_pix_LHF; 
lon_LHF_remap = lon_begin_pix_LHF:res_grid:lon_end_pix_LHF; 

depth_lake = depth_lake_temp(1:length(lon_LHF_remap),1:length(lat_LHF_remap),:); 

