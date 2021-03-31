#!/bin/sh

exit_on_error() {
	if [ "$1" -ne "0" ] ; then
		echo "$2"
		exit $1
	fi
}
ROOT=$1
FROM=$2

echo "rebuild $ROOT from $FROM tag"
cd $ROOT
for TAG in `git tag --sort=taggerdate | tail -n $FROM`
do
	echo $TAG	
	if [[ $TAG =~ `basename $ROOT`* ]]; then
		DIR=.
	else 
		DIR=`echo $TAG | sed -E 's/(^.*)-.*$/\1/g'`
	fi
	git reset --hard
	git checkout $TAG
	mvn -DskipTests=true clean deploy -f $DIR/pom.xml
	exit_on_error $? "$TAG build error"
	continue;
	git reset --hard
	git checkout $TAG
	mvn -DskipTests=true clean install -f $DIR/pom.xml
	exit_on_error $? "$TAG build error"
	if [ -z "`git status | grep 'nothing to commit'`" ]; then
		echo "half on $TAG"
		exit;
	else
		echo "nothing changed, proceed mvn deploy"
	fi
	mvn -DskipTests=true clean deploy -f $DIR/pom.xml
	git reset --hard
done
git reset --hard
git checkout master
