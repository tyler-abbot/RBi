#' @rdname bi_write
#' @name bi_write
#' @aliases bi_write
#' @title Create (init or observation) files for LibBi
#' @description
#' This function creates an init file to specify 
#' parameter values and initial conditions. This file
#' can then be passed to \code{libbi} using the \code{--init-file} option.
#' 
#' @param filename a path to a NetCDF file to write the variables into, which will be overwritten
#' if it already exists.
#' @param variables a \code{list} object, which names should be the variable names and values should be either single values, vectors of equal length, or data frames
#' @param time_dim name of the time dimension, if one exists
#' @return None, but creates a NetCDF file at the specified path.
#' @export
bi_write <- function(filename, variables, ...){
  filename <- normalizePath(filename, "/", FALSE)
  if (length(variables) == 0){
    stop("please provide a non-empty list to bi_write")
  }
  vector_variables <-
    variables[sapply(variables, function(x) {is.numeric(x) && length(x) > 1})]
  variablelengths <- as.numeric(unlist(lapply(X=vector_variables, FUN=length)))
  if (!all(variablelengths == variablelengths[1])){
    stop("please provide to bi_write a list of vectors of equal length")
  }
  variables_with_dim <- variables
  for (name in names(vector_variables)){
    variables_with_dim[[name]] <- list(values = variables[[name]], dimension = "ns")
  }
  netcdf_create_from_list(filename, variables_with_dim, ...)
}

##' Create init files for LibBi, retained for backwards compatibility
##'
##' Users should use \code{bi_write} instead
##' @param ... parameters passed to \code{bi_write}
##' @return whatever \code{bi_write} returns
##' @seealso \code{\link{bi_write}}
bi_init_file <- function(...) {
  warning("'bi_init_file' is deprecated, use 'bi_write' instead.")
  bi_write(...)
}