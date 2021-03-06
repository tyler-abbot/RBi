% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bi_write.R
\name{bi_write}
\alias{bi_write}
\title{Create (init or observation) files for LibBi}
\usage{
bi_write(filename, variables, timed, ...)
}
\arguments{
\item{filename}{a path to a NetCDF file to write the variables into, which will be overwritten
if it already exists.}

\item{variables}{a \code{list} object, which names should be the variable names and values should be either single values, vectors of equal length, or data frames; or a single element of the type}

\item{timed}{if TRUE, any elements of \code{variables} that are vectors will be assumed to have a time dimension}

\item{...}{arguments passed to \code{\link{netcdf_create_from_list}}}
}
\value{
None, but creates a NetCDF file at the specified path.
}
\description{
This function creates an init file to specify
parameter values and initial conditions. This file
can then be passed to \code{libbi} using the \code{--init-file} option.
}

