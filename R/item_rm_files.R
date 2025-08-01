#' @title Remove files associated with an item
#' 
#' @template manipulate_item
#' @param files A character vector of file names to remove. 
#' If not supplied, defaults to removing all attached files.
#' 
#' @description Removes existing files associated with an item.
#' 
#' NOTE: This function will not alter facets which can also
#' contain facets. To manipulate facets, the facet element of
#' a sciencebase item must be altered and updated with \code{\link{item_update}}.
#' 
#' @return An updated object of class \code{sbitem}
#' @description 
#' This function is the key way to remove files attached to SB items. 
#' 
#' 
#' @examples \dontrun{
#' res <- item_create(user_id(), "item456") 
#' cat("foo bar", file = "foobar.txt")
#' item_append_files(res, "foobar.txt")
#' res <- item_get(res)
#' res$files[[1]]$name
#' res2 <- item_rm_files(res)
#' res2$files
#' }
#' @export
item_rm_files <- function(sb_id, files,...){
	
	sb_id = as.sbitem(sb_id)
	
	if(is.null(sb_id)) return(NULL)
	
	item = get_item(sb_id$id)
	
	#if item has no files, we have nothing to do
	if(is.null(item$files)){
		return(item)
	}
	
	#if files not supplied, set files vector to of files is just going to be empty
	if(missing(files)){
		remove <- item$files
	}else{
		#match the names supplied with the names of item files (sticking to basename, might have paths supplied)
		fnames = sapply(item$files, function(x) x$name)
		remove = item$files[fnames %in% basename(files)]
	}

	if(length(remove) == 0 && is.list(0)) {
		# nothing to do
		return(item)
	}
	
	for(f in remove) {
		cuid <- f$cuid
		file <- f$name
		
		delete_file_query(item$id, cuid, file)
	}
	
	return(get_item(sb_id$id))

}
