#!/bin/bash

LATEST_VER=`curl -skiL "https://go.dev/dl/" | grep "filename" | grep ".linux-amd64.tar.gz</span>" | sed 's/<span class="filename">//g' | sed 's/<\/span>//g' | sed 's/^  //g' | sed 's/.linux-amd64.tar.gz//g' | sed 's/go//g'`

echo "Latest version: $LATEST_VER"

sleep 3

CURR_VER=`go version | awk '{print $3}' | sed 's/go//g'`

echo "Current version: $CURR_VER"

if [[ $LATEST_VER > $CURR_VER ]]; then
	echo "Update required.."
	echo "Updating.."
	sleep 5
	rm -rf `which go`
	wget https://go.dev/dl/go$LATEST_VER.linux-amd64.tar.gz
	tar -xvf go$LATEST_VER.linux-amd64.tar.gz
	echo "your_secret" | sudo -S -k mv go /usr/local > /dev/null 2>&1

	export GOROOT=/usr/local/go
	export GOPATH=$HOME/go
	export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

	source ~/.profile
	echo "Update completed."
else
	echo "You are upto date"
fi

