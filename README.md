
<!-- README.md is generated from README.Rmd. Please edit that file -->

plumberDeploy
=============

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

The `plumberDeploy` package separated the deployment and the `do_*`
functions from `plumber`. The `plumberDeploy` package gives the ability
to automatically deploy a plumber API from R functions on ‘DigitalOcean’
and other cloud-based servers.

Installation
------------

You can install the released version of `plumberDeploy` from
[CRAN](https://CRAN.R-project.org) with (coming soon!):

    install.packages("plumberDeploy")

And the development version from [GitHub](https://github.com/) with:

    # install.packages("remotes")
    remotes::install_github("meztez/plumberDeploy")

Setup
-----

If you’re just getting started with hosting cloud servers, the
[DigitalOcean](https://www.digitalocean.com) integration included in
`plumberDeploy` will be the best way to get started. You’ll be able to
get a server hosting your custom API in just two R commands. Full
documentation is available at
<a href="https://www.rplumber.io/articles/hosting.html#digitalocean-1" class="uri">https://www.rplumber.io/articles/hosting.html#digitalocean-1</a>.

1.  [Create a DigitalOcean
    account](https://www.digitalocean.com/?refcode=add0b50f54c4&utm_campaign=Referral_Invite&utm_medium=Referral_Program&utm_source=CopyPaste)
2.  Install `plumberDeploy`. Validate your account with
    `analogsea::account()`.
3.  Run a test command like `analogsea::droplets()` to confirm that it’s
    able to connect to your DigitalOcean account.
4.  Run `mydrop <- plumberDeploy::do_provision()`. This will start a
    virtual machine (or “droplet”, as DigitalOcean calls them) and
    install Plumber and all the necessary prerequisite software. Once
    the provisioning is complete, you should be able to access port
    `8000` on your server’s IP and see a response from Plumber.
5.  Install any R packages on the server that your API requires using
    `analogsea::install_r_package()`.
6.  You can use `plumberDeploy::do_deploy_api()` to deploy or update
    your own custom APIs to a particular port on your server.
7.  (Optional) Setup a domain name for your Plumber server so you can
    use www.myplumberserver.com instead of the server’s IP address.
8.  (Optional) Configure SSL

Getting everything connected the first time can be a bit of work, but
once you have `analogsea` connected to your DigitalOcean account, you’re
now able to spin up new Plumber servers in DigitalOcean hosting your
APIs with just a couple of R commands. You can even write [scripts that
provision an entire Plumber
server](https://github.com/meztez/plumberDeploy/blob/master/inst/hosted-new.R)
with multiple APIs associated.

Deploy an api to a new droplet
------------------------------

`.api/plumber.R`

    #* @get /
    function() {
      Sys.Date()
    }

Then run this code

    id <- plumberDeploy::do_provision(example = FALSE)
    # About 10 minutes
    plumberDeploy::do_deploy_api(id, "date", "./api/", 8000, docs = TRUE)

Navigate to: `[[IPADDRESS]]/date/__docs__/`
