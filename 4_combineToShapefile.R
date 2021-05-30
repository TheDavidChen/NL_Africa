
#############################################################################
# Date: 6 Dec 2020
# Author: David Chen 

# Purpose: 
#   Combine the monthly summary data from 3_pointExtraction.R 
#     into one df and then insert into a SpatialPolygonsDataFrame. 

# Input:
#   Shapefile (in .RDS format) to be attached to.
#   Location of the monthly summary data
#   Desired name of the final output

# Output:
#   The provided shapefile with the summary statistics inserted into @data.
#   Columns are named according to: yearmonth_[summary_statistic]

# Note: 
#   You must provide the shapefile used to generate the summary statistics.
#   This code assumes the rows in the monthly summary statistics aligns
#   with the order in @data. 
#############################################################################


# Load in packages
library(sp)
library(raster)

combineSummary <- function(data_folder, shapefile_loc, out_name) {
  # Purpose: Combine all the monthly summary stats into one df
  # Inputs:
  ### data_folder - path to data folder, add a "/" to end
  ###   example - "./FinalOutput/"
  ### shapefile_loc - location of the shapefile to join the summary stats to
  ### out_name - name of the final output (the shapefile)
  # Output: 
  ### Shapefile with the summary statistics inserted into @data.
  ### columns are named yearmonth_[summary stats]
  
  # Read in shapefile (only used after loop. 
  # It is placed here to throw an error if it is forgotten
  shapefile <- readRDS(shapefile_loc)
   
  # Name of all the files
  All_NL_files <- list.files(data_folder)
  
  # Create an empty data frame to combine results to
  NLSummary <- data.frame(id = 1:870) # Must match number of rows, currently this is manual. 
  # NLSummary <- data.frame(id = 1:855) # for gadm28

  # Loop through all the data frames and apply summary stats.
  # Then join the results to NLSummary
  for (NL_file in All_NL_files) {
    
    print(paste0("Starting on: ", NL_file)) # debugging
    
    # Read in the data file
    rawSummary <- readRDS(paste0(data_folder, NL_file))
    
    # From the name of the file, extract the month/year
    time_val <- substr(NL_file, 9, 14)
    
    # Rename the columns to indicate month/year
    colnames(rawSummary) <- paste(time_val, colnames(rawSummary), sep = "_")
    
    # join monthly output to full table
    NLSummary <- cbind(NLSummary, rawSummary)
  }
  
  print("We are out of the loop!")
  
  print(names(NLSummary[1:10]))

  #############################################################
  
  ####### Adding the joined df back to the shapefile ##########
  
  # Make the final output directory if necessary
  if (file.exists("./Final") == FALSE) {
    dir.create("./Final")
  }
  
  # First, join the shapefile@data and the combined df together
  # This converts it from a shapefile to a data frame
  temp_df <- cbind(shapefile@data, NLSummary)
  
  # To return back to a shapefile, insert the updated df back to @data
  shapefile@data <- temp_df
  
  print("Exporting the updated shapefile!")
  
  # Export the newly updated shapefile
  saveRDS(shapefile, paste0("./Final/", out_name, ".RDS"))
}

combineSummary("./FinalOutput_gadm36_arg/", "./Shapefiles/gadm36_adm1_africa.rds", "gadm36_adm1_africa_mean_quant")

print("Second")

# combineSummary("./FinalOutput_gadm28_arg/", "./Shapefiles/gadm28_adm1_africa.rds", "gadm28_adm1_africa_mean_quant")

