#!/bin/bash
#set -o errexit -o nounset
#BASE_REPO=$PWD

Rscript -e 'getwd()'
Rscript -e 'dir()'
Rscript -e 'source("./R/pyladies.R")'
Rscript -e 'source("R/pyladies_hosts.R")'