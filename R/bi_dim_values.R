#' @rdname bi_dim_values
#' @name bi_dim_values
#' @title NetCDF dimension values
#' @description
#' This function returns the values of a dimension in a NetCDF file.
#' @param filename path to a NetCDF file
#' @param dim name of the dimension to check
#' @return dimension values
#' @export
#' @importFrom ncdf4 nc_open nc_close
#' 
bi_dim_values <- function(filename, dim){
  ncfile <-  nc_open(tools::file_path_as_absolute(filename), verbose = FALSE)  
  vals <- ncfile$dim[[which(names(ncfile$dim) == dim)]]$vals
  nc_close(ncfile)
  return(vals)
}
