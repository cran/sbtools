context("authentication")

test_that("session validation works appropriately", {
	skip_on_cran()
	
  expect_false(session_validate(5))
	#expect_null(current_session())
	session <- httr::handle("https://google.com")
	attributes(session) <- c(attributes(session), list(birthdate=Sys.time()))
	expect_true(session_validate(session))
	set_expiration(as.difftime("00:00:01"))
	Sys.sleep(2)
	expect_false(session_validate(session))
	
})


