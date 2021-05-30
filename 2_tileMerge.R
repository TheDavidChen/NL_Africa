#############################################################################
# Date: August 5th, 2020
# Author: David Chen 

# Purpose: 
#   This program combines the Tile2 and Tile5 data for each month into one
#     raster file, named based on the year-month.
#   Run this file after running 1_NL_download.R.

# Input:
#   Folders `Tile2` and `Tile5` with the respective Night Light values.
#   Note that both folders must match exactly in the years/months chosen. 
#     In other words, you can't have 2014 for Tile2 and then 2015 for Tile5 only

# Output:
#   All the night light images combined and stored in "./NLData/CombinedTiles"


# Note: 
#   The merge works like the following:
#   1. Create a list of all the tile2 and tile5 data, order them
#   2. Match the files in pairs
#   3. Merge the two files together, cropping to just the Africa extent
#   4. Save the result as a .RData

#############################################################################

# Load in packages
library(raster)
library(sp)

# Where the tile data are stored
data_folder <- "./NLData/"

# Where you want the output to go
output_loc <- "./NLData/CombinedTiles"

# Make the directory if necessary
if (file.exists(output_loc) == FALSE) {
  dir.create(output_loc)
}

# Read in list of Tile2 files
tile2_files <- sort(list.files(paste0(data_folder, "Tile2")))

# Read in list of Tile5 files
tile5_files <- sort(list.files(paste0(data_folder, "Tile5")))

print("Tile2 files: ")
print(tile2_files)

print("Tile5 files: ")
print(tile5_files)

# Mark the extent limits
# I manually identified this as covering all of Africa
ext_Africa <- extent(-30, 65, -40, 40)


# Check to make sure both folders contain the same number of files
# If not, cause an error and quit here
stopifnot(length(tile5_files) == length(tile2_files))

# Loop through the two files and merge + output all the resulting files
for (file_num in 1:length(tile5_files)) {
  
  print(paste0("working on file number: ", file_num)) #debugging
  
  # Get the name for the output file
  # This takes the year-month as the output name 
  output_name <- substr(tile2_files[file_num], 11, 16)
  
  # Read in the rasters
  tile2_r <- raster(paste0(data_folder, "Tile2/", tile2_files[file_num]))
  tile5_r <- raster(paste0(data_folder, "Tile5/", tile5_files[file_num]))
  
  print("Merging the rasters!") #debugging
  
  # Merge the two rasters, keep only the extent outlining Africa
  combined_tile <- raster::merge(tile2_r, tile5_r, ext = ext_Africa)
  
  print("Done merging!") #debugging

  # Set negative values to 0
  combined_tile[combined_tile < 0] <- 0

  
  combined_tile <- readAll(combined_tile) # Load into memory so we can actually export it

  # Output as an .RData file with the year-month as the name. 
  # note that we add NL_ to the start of the name since it'd break when reading the file in otherwise. 
  saveRDS(combined_tile, file = paste0(output_loc, "/NL_", output_name, '.rds'))
  
  print(paste0("Done saving: ", output_name)) #debugging
}

print("We went through everything and we're done!") #debugging
