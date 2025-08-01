% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/authenticate_sb.R
\name{token_stache_path}
\alias{token_stache_path}
\title{Get or set token stache data directory}
\usage{
token_stache_path(dir = NULL)
}
\arguments{
\item{dir}{path of desired token stache file. See description for behavior
if left unset.}
}
\value{
character path of data directory (silent when setting)
}
\description{
Will check the `SBTOOLS_TOKEN_STACHE` environment variable 
and will check if the `token_stache_path` has been set durring the current
session previously. If the environment variable or session-variable are not
found, returns `file.path(tools::R_user_dir(package = "sbtools"), "token")`.
}
