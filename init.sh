#!/bin/bash

WORKING=`pwd`
function clone() {
	PROJECT=$1
	URL=$2

	mkdir -p $PROJECT
	cd $PROJECT
	
	REPO=`echo $URL | sed -E "s/^.*\/(.*)\.git$/\1/g"`
	if [ -d "$REPO" ]; then
		echo "skip existing repository $PROJECT/$REPO"
	else
		git clone $URL
	fi	
	cd "$WORKING"
}

clone app git@github.com:alfredyctan/metric-collector.git
clone app git@github.com:alfredyctan/garmin-map.git
clone app git@github.com:alfredyctan/skr.git

clone lib git@github.com:alfredyctan/afc.git
clone lib git@github.com:alfredyctan/carril.git
clone lib git@github.com:alfredyctan/afc-maven.git

clone util git@github.com:alfredyctan/archetype-webpack.git
clone util git@github.com:alfredyctan/home.git
clone util git@github.com:alfredyctan/trash.git
clone util git@github.com:alfredyctan/environment.git

clone poc git@github.com:alfredyctan/example.git
clone poc git@github.com:alfredyctan/docker-example.git
clone poc git@github.com:alfredyctan/study.git

clone exercise git@github.com:alfredyctan/bus.git
clone exercise git@github.com:alfredyctan/filuname.git
