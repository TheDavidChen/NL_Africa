#############################################################################
# Date: 1 Dec 2020
# Author: David Chen 

# Purpose: 
#   For the specified shapefile, calculate the summary statistics, then export
#     as a dataframe with the file name as the month/year. 
# Input:
#   year - what year should be processed. Only one year at a time.
#   shapefile_path - path to the desired shapefile. Shapefile must be an RDS.
#   output_folder - name of the output folder. Does not have to already exist.

# Output:
#   summary_[yearmonth].RDS stored in the specified folder. 
#   It is a df with the summary statistics for the shapefile specified.

# Notes: 
#   + If you want to aggregate to a different function (e.g. just mean), 
#      change the `fun` argument in `raster::extract()` and the colname(). 
#   + You must first run 1_NL_Download.R and 2_tileMerge.R
#   + If you want to expand past Africa, you must change the two previous files
#   + The shapefile provided must be manually inserted, and in .RDS format
#   + For all of Africa, one month took 1h20m. 

#############################################################################

# Load in packages
library(raster)
library(sp)

# Summary statistics
# Used for raster::extract. na.rm must be specified here. 
quant_summary <- function(x, na.rm){
  return(
    c(mean = mean(x, na.rm = na.rm), 
      quants = quantile(x, probs = c(0.05, 0.5, 0.95), na.rm = na.rm)
    )
  )
}

aggregateNL <- function(year, shapefile_path, output_folder, start=1, end=12) {
  # Purpose: Obtain the night light summary statistics for the specified shapefile
  # Inputs:
  ### year - string, desired year for processing. Must only be one
  ### shapefile_path - path to the desired shapefile. Must be within Africa.
  ### output_folder - Path for the output folder. If it doesn't exist, 
  ###                 it will be created. Do not add "/" to the end. 
  ###                 E.g. - output_folder = "./FinalOutput"
  # Outputs:
  ### summary_yearmonth.RDS - df with the summary statistics 
  
  
  # Specify desired shapefile (must be within Africa)
  ## ctry.shps <- readRDS("./Shapefiles/gadm36_adm1_africa.rds")
  ctry.shps <- readRDS(shapefile_path)
  
  
  # Where the combined tiles are location (created in 2_tileMerge.R)
  data_folder <- "./NLData/CombinedTiles/"
  
  # Create the output folder if necessary
  # output_folder <- "./FinalOutput"
  
  if (file.exists(output_folder) == FALSE) {
    dir.create(output_folder)
  }
  
  # Get the list of combined tiles
  all_tiles <- sort(list.files("./NLData/CombinedTiles"))
  
  # Keep only tiles that match the desired year
  combinedTiles <- all_tiles[grep(year, all_tiles)]
  combinedTiles <- combinedTiles[start:end]

  print(Sys.time())
  print("We're about to start the loop!")
  print(combinedTiles)
  
  # Loop through all the combined tiles and extract the values
  for (image_path in combinedTiles) {
    
    print(Sys.time())
    
    # Get month (e.g. NL_201304.rds gives 201304). Add type of aggregation fun
    year_month <- substr(image_path, 4, 9)
    
    print(paste0("Starting on: ", image_path))
    
    # Read in the data. It is a raster saved as an RDS 
    image <- readRDS(paste0(data_folder, image_path))
    
    print("Starting the extract")
    print(Sys.time())

    # Extract the values based on the shapefile, set as a df. 
    # values_df <- raster::extract(image, ctry.shps, fun = quant_summary, df= T)
    
    ## Let's get the above with the rasterize function (but no parallel)
    print(Sys.time())
    values_df = matrix(NA, nrow = nrow(ctry.shps), ncol = 4)
    for(ind in 1:nrow(ctry.shps)) {
      ctry.shps.tmp = ctry.shps[ind,]
      image.crop = try(crop(image, extent(ctry.shps.tmp)))
      if(class(image.crop) == "try-error"){
        next
      }
      ctry.shps.sub.rasterize = rasterize(ctry.shps.tmp, image.crop, mask = TRUE)
      ext = getValues(ctry.shps.sub.rasterize)
      
      values_df[ind,] = quant_summary(ext, TRUE)
      if(ind %% 25 == 0){
        print(ind)
      }
    }
    print(Sys.time())
    values_df = data.frame(values_df)
    
    # Debugging
    print(head(values_df))
    
    print(Sys.time())
    print("Extract done!")
       
    # Rename column names to reflect summary statistics
    colnames(values_df) <- c("mean", "quant05", "quant50", "quant95") # Removed ID
    print("Exporting!")

    # Export summary statistics to the output folder
    saveRDS(values_df, paste0(output_folder, "/summary_", year_month, ".RDS"))
    
    print(Sys.time())
    print(paste0("We completed: ", image_path))
  }
  
  print("Out of the loop!")
}

#########################################################################


# Get the arguments directly from the .PBS file
# For example - "Rscript 3_pointExtraction.R 2014 1 12" -> passes "2014", "1", "12" as arguments
args <- commandArgs(trailingOnly=TRUE)

# Check to make sure arguments were all supplied
if(length(args)==0){
    print("No arguments supplied.")
} else {
  year <- args[1]
  shapefile_loc <- args[2]
  output_folder_loc <- args[3]
  start <- as.numeric(args[4])
  end <- as.numeric(args[5])
 
  # Run the desired function. There is no return(), so no variable assignment
  # aggregateNL("2013", "./Shapefiles/gadm36_adm1_africa.rds", "./FinalOutput_gadm36_par", 1, 12)
  aggregateNL(year, shapefile_loc, output_folder_loc, start, end)
}


