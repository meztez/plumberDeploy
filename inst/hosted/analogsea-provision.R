library(analogsea)

source("analog-keys.R")

# pl <- droplet_create(name="plumber", ssh_keys="trestle-secure-rsa") %>% droplet_wait()
# pl <- droplet(13426136)

install <- function(droplet){
  droplet %>%
    ubuntu_add_swap() %>%
    ubuntu_install_r() %>%
    install_docker() %>%
    prepare_plumber()
}

install_docker <- function(droplet){
  droplet %>%
    # Deprecated (Shutting down dockerproject.org APT and YUM repos 2020-03-31)
    droplet_ssh(c("sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D",
                  "echo 'deb https://apt.dockerproject.org/repo ubuntu-focal main' > /etc/apt/sources.list.d/docker.list")) %>%
    ubuntu_apt_get_update() %>%
    droplet_ssh("sudo apt install linux-image-extra-$(uname -r)") %>%
    ubuntu_apt_get_install("docker-engine") %>%
    droplet_ssh(c("curl -L https://github.com/docker/compose/releases/download/1.7.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose",
                  "chmod +x /usr/local/bin/docker-compose"))
}

prepare_plumber<- function(droplet){
  droplet %>%
    droplet_ssh("git clone https://github.com/rstudio/plumber.git") %>%
    droplet_ssh("cd plumber/inst/hosted/ && docker-compose up -d --build")
}

# Update instructions for adding new images:
# - Update the docker-compose config file to include the new service. Test locally
# - Commit
# docker pull trestle/plumber #AFTER build is complete.
# git pull to get updates to docker-compose config
# docker-compose build NEW_IMAGE
# docker-compose up --no-deps -d NEW_IMAGE
# -  https://docs.docker.com/compose/production/
