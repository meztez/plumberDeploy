# Development Version

# plumberDeploy 0.2.1

* Added `do_ip` for example to get IP address to browse.

# plumberDeploy 0.2.0

* Submitted to CRAN.
* Added `do_install_plumber` function.
* Fix `do_deploy_api` using localPath `./`.
* Print api url to console after successful `do_deploy_api`.
* Set Dpkg::Options to `--force-confnew` to avoid prompt during apt-get update.

# plumberDeploy 0.1.4

* Removed `swagger` as an argument for deployment.
* Added checks to see if the application was already present.

# plumberDeploy 0.1.3

* Added a `NEWS.md` file to track changes to the package.
* Added passthrough for `do_deploy_api` so that `keyfile` works, fixing #12 (@muschellij2).
