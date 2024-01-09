## ----setup, include=FALSE-----------------------------------------------------

local <- (Sys.getenv("BUILD_VIGNETTES") == "TRUE")

knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width=6, 
  fig.height=4,
  eval=local
)

oldoption <- options(scipen = 9999)

## -----------------------------------------------------------------------------
## Examples

library(sbtools)

# Query ScienceBase for data about Antarctica
query_sb_text('Antarctica', limit=1)

# Query for a specific DOI
query_sb_doi('10.5066/P92U7ZUT')

# Inspect the contents of the above item
children <- item_list_children('5669a79ee4b08895842a1d47')

sapply(children, function(child) child$title)

item_get(children[[1]])

## -----------------------------------------------------------------------------

item <- item_get(children[[1]])

class(item)

class(unclass(item))


## ----eval=FALSE---------------------------------------------------------------
#  authenticate_sb(Sys.getenv("sb_user"))
#  
#  my_home_item <- user_id()
#  
#  new_item <- item_create(title = 'new test item', parent_id = my_home_item)
#  
#  test.txt <- file.path(tempdir(), 'test.txt')
#  
#  writeLines(c('this is','my data file'), test.txt)
#  
#  item_append_files(new_item, test.txt)
#  
#  item_list_files(new_item)$fname
#  
#  item_rm(new_item)
#  
#  unlink(test.txt)
#  
#  # restart or clean session to reauthenticate differently
#  sbtools:::clean_session()

## -----------------------------------------------------------------------------
user <- Sys.getenv("sb_user") # this should be your science base user id

initialize_sciencebase_session(user)

my_home_item <- user_id()

new_item <- item_create(title = 'new test item', parent_id = my_home_item)

test.txt <- file.path(tempdir(), 'test.txt')

writeLines(c('this is','my data file'), test.txt)

item_append_files(new_item, test.txt)

item_list_files(new_item)$fname

item_rm(new_item)

unlink(test.txt)

## ----teardown, include=FALSE--------------------------------------------------
options(oldoption)
sbtools:::clean_session()

