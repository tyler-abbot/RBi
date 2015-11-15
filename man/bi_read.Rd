% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/bi_read.R
\name{bi_read}
\alias{bi_read}
\title{Bi Read}
\usage{
bi_read(read, vars, dims, missval.threshold, variables, time_dim)
}
\arguments{
\item{read}{either a path to a NetCDF file, or a NetCDF connection created using \code{nc_open}, or a \code{\link{libbi}} object from which to read the output}

\item{vars}{variables to read; if not given, all will be read}

\item{dims}{factors for dimensions}

\item{missval.threshold}{upper threshold for the likelihood}

\item{variables}{only extract given variables (for space saving)}

\item{time_dim}{name of time dimension (if any)}

\item{wrapper}{a \code{\link{libbi}} object; either this or \code{file} must be given.}

\item{quiet}{suppress progress bar}
}
\value{
list of results
}
\description{
This function reads all variable from a NetCDF file or the output of a
\code{\link{libbi}} object.
The file can be specified as a string to the filepath, in which
case a NetCDF connection is opened, or directly as a NetCDF connection.
}
