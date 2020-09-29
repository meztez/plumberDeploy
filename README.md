
<!-- README.md is generated from README.Rmd. Please edit that file -->

# plumberDeploy

<!-- badges: start -->

[![Travis build
status](https://travis-ci.com/muschellij2/plumberDeploy.svg?branch=master)](https://travis-ci.com/muschellij2/plumberDeploy)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/muschellij2/plumberDeploy?branch=master&svg=true)](https://ci.appveyor.com/project/muschellij2/plumberDeploy)
[![R build
status](https://github.com/muschellij2/plumberDeploy/workflows/R-CMD-check/badge.svg)](https://github.com/muschellij2/plumberDeploy/actions)
[![R build
status](https://github.com/meztez/plumberDeploy/workflows/R-CMD-check/badge.svg)](https://github.com/meztez/plumberDeploy/actions)
<!-- badges: end -->

First create a Digital Ocean account. Validate using
`analogsea::account()`.

Then configure an ssh key for your Digital Ocean account before using
methods included in this package. Use `analogsea::key_create` method or
see
<https://www.digitalocean.com/docs/droplets/how-to/add-ssh-keys/to-account/>.

## Deploy an api to a new droplet

`.api/plumber.R`

``` r
#* @get /
function() {
  Sys.Date()
}
```

Then run this code

``` r
id <- plumberDeploy::do_provision(example = FALSE)
# About 10 minutes
plumberDeploy::do_deploy_api(id, "date", "./api/", 8000, docs = TRUE)
```

Navigate to: `[[IPADDRESS]]/date/__docs__/`
