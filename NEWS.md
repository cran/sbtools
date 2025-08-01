# version 1.4.1

- improved `item_rm_files()` to use the cloud file removal utility.  #334 and #336

# version 1.4.0

- removed `items_create()`, `items_upsert()`, and `items_update()` as they are no longer supported by sciencebase.
- Fixed bugs related to sciencebase updates.
- added `get_username()` as exported function.
- added `get_cached_token()` as exported function.
- added `token_stache_path()` as exported function.
- fixed bug related to file downloads #332 and #335

# version 1.3.2

- `item_rm_files()` now uses cloud end point. #315
- `initialize_sciencebase_session()` has less warnings. #319 and #323
- `initialize_sciencebase_session()` works at the terminal now. #317
- `initialize_sciencebase_session()` caching works better. #318
- improve test coverage #316

# version 1.3.1

Improved handling of cached token.

# version 1.3.0

In this release, sbtools underwent a significant migration from `josso` login to `keycloak`-based two factor authentication. See #314 for details of the changes.

A vignette showing the old and new login methods is now included see: `vignette("sbtools")`

In addition to login modifications, a pkgdown site was created, and the package code was reorganized significantly. 

- Added `initialize_sciencebase_session()` to support tokenized login.
- Sciencebase `session` object no longer returned by `authenticate_sb()`
- `current_session()` now returns the active login token.
- Removed `session_logout()` and `session_age_reset()` there is now an internal function `sbtools:::clean_session()` to accomplish the same goal.
- Removed `sbtools_DELETE()` as the method is no longer the accepted way to delete sciencebase items.
- Modified item deletion functions to use a delete helper that ensures files are removed from all locations.

# Version 1.2.0 (2023-04-28)

- added `item_publish_cloud()` to push files to S3 public cloud storage. #302
- update URLs for new repository. #303
- improved handling of authentication and invalid logins
- check error messages for firewall blocks

# Version 1.1.21 (2022-11-03)

- All web calls now use `httr::RETRY()` to be a bit more robust. #213
- Password management can now be done with the `keyring`
- File uploads for very large files should now be more robust with longer time out tolerances.

# Version 1.1.20 (2022-10-27)

Added checksum validation to both regular and cloud uploads.

# Version 1.1.19 (2022-07-14)

CRAN checks on failing donttest examples.

# Version 1.1.18 (2022-05-26)

- Added support for cloud file upload and download. See `item_upload_cloud()` and `item_list_files()` and `item_file_download()`. 
- Added ability to pull jossoSessionId from `session_details()`, This is useful for pulling files directly from sciencebase via R functions that do not use the sbtools session for authentication. See `session_details()` description for more.
- Removed deprecated `item_get_wfs()` function.
- Renamed `master` branch to `main`. 
- Added `facets` to locations that sciencebase files can be found. See `item_list_files()` description for more info. Note that the response from
`item_list_files()` has changed. A "facet" attribute which lists the name
of the facet the file came from is included. 

# Version 1.1.16/1.1.17 (2021-07-01)

Versions 1.1.16 and 1.1.17 were minor changes for CRAN.

# Version 1.1.15 (2021-06-07)

* Added `scrape_files` parameter to `item_upload_files()` and `item_append_files()`
* Fixed CRAN check issues with ScienceBase availability. 10 second timeout was added for all web service calls.

# Version 1.1.14 (2020-03-01)

Version 1.1.10 to 1.1.14 are all minor changes for CRAN.

# Version 1.1.9 (2020-01-07)

* Fixed travis build and addressed CRAN test failures.
* Deprecated item_get_wfs -- will be removed in a future version.
* Changed maintainer to dblodgett@usgs.gov
* See repository for other updates.

# Version 1.1.3 (2016-08-18)

* Fix items_create to properly handle cases creating one item

* Add sbtools to user agent string

* Alter `item_list_children` to use `query_sb` so item return limit can be > 1000. 
`raw` option removed to support this functionality.

# Version 1.0.3 (2016-06-30)

* Fix item_rm bug

# Version 1.0.2 (2016-06-22)

* Cleanup for CRAN release

# Version 0.19.3 (2016-06-17)

* Bunch of changes from reviews

* `item_get_parent` now returns `sbitem`, not just ID

* fixed probablem with `query_sb_doi`

* `query_sb_spatial` no longer has awkard bounding box specification, 
just uses lat/long arrays and determines box from those

* `sb_ping` returns boolean TRUE/FALSE for success/fail

* `set_endpoint` no longer includes verbose message and properly uses `match.arg`

* `item_list_children` now returns list of `sbitem` to be uniform with rest of `sbtools`

* Lots of documentation updates and new demos

# Version 0.18.5 (2016-06-01)

* Fixed issue with `query_sb_datatype`

* New and improved `item_get_wfs`. Better performance and 
no longer requires hard-to-install external dependencies.

# Version 0.18.0 (2016-04-10)

* Improved version of `query_sb()` now requests useful metadata so
`sbitem` list has key metadata

* `query_item_identifier()` now returns an `sbitem` list instead of a 
data.frame. Also, `*_item_identifier()` funcitons now have unified 
parameter order


# Version 0.17.0 (2016-04-10)

* On `item_replace_files()` changed default on `all` flag to FALSE
so it doesn't delete files by default.

* Added `item_rename_files()` to enable user to easily 
rename files attached to items directly. 


