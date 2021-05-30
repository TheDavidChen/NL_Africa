
# Night Light Extraction - Summary Statistics

This repo extracts summary statistics (5-50-95th quantiles, mean) for a user-specified shapefile of all of Africa from the [VIIRS Day/Night Band Nighttime Lights](https://eogdata.mines.edu/download_dnb_composites.html) provided by the Earth Observations Group (EOG) and Payne Institute for Public Policy.

## Technologies

This makes use of `R` v3.5.2 and the following packages:

+ `sp` v1.4.1.      
+ `raster` v3.0.12.    

The code is designed to be run on the [Penn State Roar supercomputer](https://www.icds.psu.edu/computing-services/roar-user-guide/), although it can be run on any local computer. 

## How to Run

### On the cluster

**Note:** This assumes you already have `raster` working and have some basic understanding of how to work on Roar. See "Getting Raster Working" at the bottom of this README if you have not setup `raster`. 

1. Create a folder `./Shapefiles` that includes the desired shapefile in a .RDS format. 
    + The current code assumes the shapefile covers all of Africa. 
2. Using `qsub`, submit `1SSA_download.PBS` and `2PopExtraction.PBS`.
    + Note: You may have to edit lines 19-21 of the second PBS file to reflect current versions of gdal. 
    + 2PopExtraction.R sometimes fails for no reason - see description below. If this happens, rerun the file after editing the loop to start at the previous stop. 
3. Specify the desired year, shapefile, output location, and months in `3pointExtraction_nopar_args.PBS` file.
4. Modify the function call at the bottom of `4_combineToShapefile.R` to reflect the inputs/outputs from step 3, then run the corresponding PBS file.

## Files

There are 4 `R` files and 4 corresponding `PBS` files. The first `R` file downloads the data, the second combines and crops the data to just Africa, the third calculates the summary statistic, and then the fourth adds the statistics to the shapefile. 

### 1_NL_download.R

**Purpose:** Downloads Tile 2 and Tile 5 of the night light data from 2013-2018.

**Input:** N/A

**Output:** All the night light data downloaded into ./NLData.

**Notes:** 

Previous attempts took 2 hours to complete. 

### 2_tileMerge.R

**Purpose:** Merge Tile 2 and Tile 5 together, crop the image to just Africa. 

**Input:** Output from `1_NL_download.R`

**Output:** Folder ./NLData/CombinedTiles which includes tiles for each month combined in the following format: NL_<yearmonth>.RDS. For example: NL_201812.rds represents the night light data for December 2018. 

**Notes:** 

+ `1_NL_download.R` MUST be run first. 
+ The code sometimes breaks halfway through inexplicably. In those scenarios, review the .PBS output to see when it broke, then replace the loop starting index to the previous end. 
+ This process is 100% necessary if you include countries that are between tiles, but if not, this skip is technically not needed. Be careful of skipping this step, as `3_joinFiles.R` will expect the naming and output to be consistent. 

### 3_pointExtraction_nopar_args.R

**Purpose:** Extract the mean and quantiles for the specified shapefile. 

**Input:** Year desired, shapefile path location, output folder location, start month (1 = January), end month (12 = December). All these must be specified in the .PBS file. 

**Output:** The summary statistics as a data frame with the following naming: summary_<yearmonth>.RDS. 

**Notes:** 

+ The naming comes from the fact that no parallelization was included, and arguments come from the PBS file.
+ Parallelizing the extraction did not improve the processing time and ran into memory issues. 

### 4_combineToShapefile.R

**Purpose:** Join the summary statistics from `3_pointExtraction_nopar_args.R` to the desired shapefile. 

**Input:** Shapefile (.RDS format) to attach the data to, path to the summary statistics, desired name of the output. 

**Output:** An .RDS shapefile containing the summary statistics in shapefile@data. 

**Notes:** 

+ **IMPORTANT:** Line 49 must be manually changed for each shapefile - set the upper limit to the number of rows in shapefile@data.
+ User must specify the inputs at the bottom of the R script. 
+ The same shapefile used to create the summary statistics in `3_pointExtraction_nopar_args.R` must be used again. 

## Getting Raster Working

To get the raster package running on the server, there are a bit more technicalities. If you just attempt to install and call `raster`, you will find that it doesn’t work. Instead, you will need to do the following at least once first:

In order to install `rgdal` (required for `raster`) properly, use the following code in PuTTY (or terminal or any other related system) after logging into the ACI-b server: 

$ cd work  
$ module purge  
$ module use /gpfs/group/dml129/default/sw/modules  
$ ml gcc  
$ ml r/3.4  
$ ml openmpi  
$ mkdir sw  
$ cd sw  
$ mkdir gdal  
$ cd gdal  
$ git clone https://github.com/spack/spack.git  
$ . spack/share/spack/setup-env.sh  
$ spack install gdal  
$ cd spack  
$ source ./share/spack/setup-env.sh  
$ ml gdal-3.0.1-gcc-7.3.1-uxpvawq proj-6.1.0-gcc-7.3.1-odxlwcd  
$ R  
\> install.packages(“rgdal”)  

**NOTE:** The ml gdal-3.0.1 part gets updated, so you need to check both the packages and update them. You can use `module spider` to look at all the modules and update it accordingly. For example, I used:

ml gdal-3.0.4-gcc-7.3.1-ztomvd7 proj-6.2.0-gcc-7.3.1-3dqejei

When I installed packages, I stored them all temporarily here: 
The downloaded source packages are in
        ‘/tmp/RtmpBMKWUB/downloaded_packages’

Now, every time you want to use the raster package, you will still need to call the gdal part of the code. This is done for you in the `PBS` file. 
