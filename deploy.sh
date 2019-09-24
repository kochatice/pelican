#!/usr/bin/env bash
BRANCH=master
TARGET_REPO=git@github.com:kochatice/pelican.git
PELICAN_OUTPUT_FOLDER=output

echo -e "Testing travis-encrypt"
echo -e "$VARNAME"

if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
    echo -e "Starting to deploy to Github Pages\n"
    if [ "$TRAVIS" == "true" ]; then
        git config --global user.email "kochhatice@gmail.com"
        git config --global user.name "kochhatice"
    fi
    #using token clone gh-pages branch
    git clone --quiet --branch=$BRANCH https://${61fb4ad744d1c0c17ba28f85352951412aae5984}@github.com/
    $TARGET_REPO built_website > /dev/null
    #go into directory and copy data we're interested in to that directory
    cd built_website
    rsync -rv --exclude=.git  ../$PELICAN_OUTPUT_FOLDER/* .
    #add, commit and push files
    git add -f .
    git commit -m "Travis build $TRAVIS_BUILD_NUMBER pushed to Github Pages"
    git push -fq origin $BRANCH > /dev/null
    echo -e "Deploy completed\n"
fi