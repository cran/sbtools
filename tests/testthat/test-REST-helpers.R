test_that("REST_helpers tests", {
	skip_on_cran()
	
	item <- sbtools_GET("https://www.sciencebase.gov/catalog/item/5c4f4a04e4b0708288f78e07")
	
	expect_warning(sbtools_GET("https://www.sciencebase.gov/catalog/item/a04e4b0708288f78e07"), 
								 "item doesn't exist or is secured")
	
	assign("keycloak_expire", NULL, envir = sbtools:::pkg.env)
	assign("keycloak_token", "baddy", envir = sbtools:::pkg.env)
	
	expect_warning(sbtools_GET("https://www.sciencebase.gov/catalog/item/a04e4b0708288f78e07"),
								 "item doesn't exist or is secured")
	
	expect_warning(expect_warning(try(sbtools_GET("https://www.sciencebase.go/catalog/item/5c4f4a04e4b0708288f78e07"), silent = TRUE)))
	
	put_test <- suppressWarnings(sbtools_PUT("https://www.sciencebase.gov/catalog/item/5c4f4a04e4b0708288f78e07", "test"))
	
	expect_equal(put_test, NULL)
	
	delete_test <- suppressWarnings(item_rm("https://www.sciencebase.gov/catalog/item/5c4f4a04e4b0708288f78e07"))
	
	expect_equal(delete_test, NULL)
	
	expect_warning(post_test <- sbtools_POST("https://www.sciencebase.gov/catalog/item/5c4f4a04e4b0708288f78e07", "test"))
	
	expect_equal(post_test, NULL)
	
	assign("keycloak_token", NULL, envir = sbtools:::pkg.env)
})