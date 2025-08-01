#' @noRd
#' @param q character gql query to embed into json body
#' @param gql handle to pass to POST
#' @param json character json to pass -- shoul include gql query and additional content. 
#' json is optional - it will default to just the query.
run_gql_query <- function(q, gql, json = jsonlite::toJSON(list(query = q), auto_unbox = TRUE)) {
	out <- RETRY("POST", pkg.env$graphql_url, get_token_header(), content_type_json(),
							 body = json,  
							 handle = gql)
	
	if(out$status_code == 200) {
		jsonlite::fromJSON(rawToChar(out$content))
	} else {
		stop(paste("Error making multipart session.\n code:", out$status_code,
							 "\n content:", rawToChar(out$content)))		
	}
	
}

#GraphQL Queries for interaction with ScienceBase Manager
create_multipart_upload_session <- function(s3_filepath, content_type, username, gql) {
	
	run_gql_query(sprintf(
		'query { createMultipartUploadSession(object: "%s" contentType: "%s" username: "%s") }', 
		s3_filepath, content_type, username), gql)$data$createMultipartUploadSession
	
}

get_presigned_url_for_chunk <- function(s3_filepath, upload_id, part_number, gql) {
	
	run_gql_query(sprintf(
		'query { getPreSignedUrlForChunk(object: "%s", upload_id: "%s", part_number: "%s") }',
		s3_filepath, upload_id, part_number), gql)$data$getPreSignedUrlForChunk
	
}

complete_multipart_upload <- function(item_str, upload_id, etag_payload, gql) {
	
	eta <- sapply(etag_payload, function(x) {
		sprintf('{ETag: "%s", PartNumber: %i}', gsub('"', "", x$ETag), x$PartNumber)
	})
	
	eta <- paste0("[", paste(eta, collapse = ","), "]")
	
	run_gql_query(sprintf(
		'query { completeMultiPartUpload(object: "%s" upload_id: "%s" parts_eTags: %s) }',
		item_str, upload_id, eta), gql)
}

get_cloud_download_url <- function(cr, gql) {
	
	query <- "query getS3DownloadUrl($input: SaveFileInputs){ getS3DownloadUrl(input: $input){ downloadUri }}"
	
	variables <- list(input = list(selectedRows = list(cuid = cr$cuid, key = cr$key, title = cr$title, useForPreview = as.logical(cr$useForPreview))))
	
	json <- jsonlite::toJSON(list(query = query, variables = variables), auto_unbox = TRUE)
	
	run_gql_query(query, gql, json = json)
}

publish_cloud_object <- function(sb_id, fname, gql) {
	
	query <- "mutation handleMFActions($input: ManageFileInput!) {\n  handleMFActions(input: $input) {\n    percent\n    error\n    __typename\n  }\n}\n"	
		
	variables <- list(input = list(itemId = sb_id, filename = fname, 
																 action = "publish", pathOnDisk = "__s3__"))
	
	json <- jsonlite::toJSON(list(operationName = "handleMFActions", 
																variables = variables, query = query),
													 auto_unbox = TRUE)
	
	run_gql_query(query, gql, json = json)
	
}

delete_item_query <- function(id) {
	query <- "mutation DeleteItemQuery($input: DeleteItemInput!){\n deleteItem(input: $input){\n itemId\n  __typename }\n}\n"
	
	variables <- list(input = list(itemId = id))
	
	json <- jsonlite::toJSON(list(operationName = "DeleteItemQuery", 
																query = query,
																variables = variables),
													 auto_unbox = TRUE)
	
	run_gql_query(query, httr::handle(url = pkg.env$graphql_url), json = json)
}

# {"operationName":"DeleteQuery","variables":{"input":{"cuid":null,"key":"65cbc0b3d34ef4b119cb37e9/rf1.csv"}},"query":"mutation DeleteQuery($input: DeleteFileInput!) {\n  deleteFile(input: $input) {\n    id\n    __typename\n  }\n}\n"}
delete_file_query <- function(id, cuid, file) {
	query <- "mutation DeleteQuery($input: DeleteFileInput!) {\n  deleteFile(input: $input) {\n    id\n    __typename\n  }\n}\n"
	
	variables <- list(input = list(cuid = cuid, key = paste0(id, "/", file)))
	
	json = jsonlite::toJSON(list(operationName = "DeleteQuery",
															 query = query,
															 variables = variables),
													auto_unbox = TRUE, null = 'null')
	
	run_gql_query(query, httr::handle(url = pkg.env$graphql_url), json = json)
}
