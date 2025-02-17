#!/bin/bash
#set -o errexit -o nounset
#BASE_REPO=$PWD

setup_git() {
Rscript -e 'source("R/pyladies.R")'
Rscript -e 'source("R/pyladies_hosts.R")'

git config --global user.name "benubah"
git config --global user.email "ben@rpowerlabs.org"

}

commit_files() {
  git checkout master
  # Current month and year, e.g: May 2019
  dateAndMonth=`date "+%b %Y"`
  # Stage the modified files in dist/output
  git add -f docs/data/pyladies.csv
  git add -f docs/data/pyladies_hosts.csv
  git add -f docs/data/pyladies_summary.json
  git add -f docs/data/pyladies_cumulative.json
  git add -f docs/data/pyladies_map_data.geojson
  # Create a new commit with a custom build message
  # with "[skip ci]" to avoid a build loop
  # and Travis build number for reference
  git commit -m "Travis Cron Jobs Update: $dateAndMonth (Build $TRAVIS_BUILD_NUMBER)" -m "[skip ci]"
}

upload_files() {
  # Remove existing "origin"
  git remote rm origin
  # Add new "origin" with access token in the git URL for authentication
  git remote add origin https://${GITTOKEN}@github.com/${TRAVIS_REPO_SLUG}.git > /dev/null 2>&1
  git push origin master --quiet
}

setup_git

#commit_files

#upload_files
