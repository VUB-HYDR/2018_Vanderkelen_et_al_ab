# 2018_Vanderkelen_et_al_ab

Data analysis and modelling used in Vanderkelen et al., 2018 a and b.


## For users
This repository includes the processing scripts of the Water Balance Model 
(WBM) for Lake Victoria. The main analysis is performed in *Matlab 2017b*. 
The four different components of the repository are described below. 

### 1. WBmodel
This folder contains all the necessary scripts to run the WBM forced by 
observations as done in Vanderkelen et al. (2018a) and evaluation, historical 
and 
future simulations of the COordinated Regional Downscaling EXperiment 
(CORDEX) as done in Vanderkelen et al. (2018b). It inlcudes the preprocessing 
scripts for 
the observational WBM. The preprocessing scripts for the evaluation, 
historical and future CORDEX simulations can be found in the folder 
[calculateWBterms](./calculateWBterms). Preprocessed data necessary to direcly 
run the model is 
available upon request. This data includes the calculated WBterms, lake levels 
and outflow for the observational, evaluation, historical and future runs; 
shapefiles of the lake and the data used in the CN method. 

Run the WB model in the 
[main.m](./WBmodel/main.m)
script. Here, users can also choose different options for the model. 

### 2. calculateWBterms
Folder containing the scripts to calculate the WB terms for the CORDEX 
evaluation, historical and future simulations.

### 3. biascorrection
Folder containing scripts in the R language to apply a bias correction on 
the calculated WBterms in matlab. First, the `.mat` 
files are converted to `.csv` through the matlab script 
[bc_preprocess.m](./biascorrection/bc_preprocess.m) 
which can be found in the [biascorrection](./biascorrection) 
folder. Then, by running the 
[PFT_lin.R ](./biascorrection/PFT_lin.R ) or 
[QUANT.R](./biascorrection/QUANT.R) scripts, a linear parametric bias correction 
or a quantile mapping bias correction method is applied on the WB terms using 
the R package [qmap](https://cran.r-project.org/web/packages/qmap/index.html). 
For details on these methods, see Vanderkelen et 
al., 2018b; section 2.4. 

### 4. plotting
This folder contains all the scripts used for plotting the figures in 
Vanderkelen et al., 2018 a and b. For an overview, open 
[main_plotting.m](./plotting/main_plotting.m). 


## Versions
Version 0.1.0 - April 2018  

## License
This project is licensed under the MIT License. See also the 
[LICENSE](./LICENSE.md) 
file.

## References
Vanderkelen, I., van Lipzig, N. P. M., and Thiery, W.: Modelling the water 
balance of Lake Victoria (East Africa) – Part 1: Observational analysis, Hydrol. 
Earth Syst. Sci. Discuss., 
[https://doi.org/10.5194/hess-2018-11](https://doi.org/10.5194/hess-2018-11), 
accepted, 2018. 

Vanderkelen, I., van Lipzig, N. P. M., and Thiery, W.: Modelling the water 
balance of Lake Victoria (East Africa), part 2: future projections, Hydrol. 
Earth Syst. Sci. Discuss., 
[https://doi.org/10.5194/hess-2018-160](https://doi.org/10.5194/hess-2018-160]), 
in review, 2018. 

