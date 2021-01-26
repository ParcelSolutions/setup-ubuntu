#!/bin/bash

if [ $1 = "desktop" ]
then
	source ./setup-ubuntu.sh
if [ $1 = "git" ]
then
	echo "=> Install git reps, Do one manually so you are logged in."
	cd ~
	mkdir -p functions
	mkdir -p nodeapp
	mkdir -p meteor
	cd ~/functions && git clone "https://github.com/ParcelSolutions/ibm-function-basis.git" && cd ibm-function-basis && npm install
	cd ~/functions && git clone "https://github.com/ParcelSolutions/simulaterate.git" && cd simulaterate && npm install
	cd ~/functions && git clone "https://github.com/ParcelSolutions/bigquery_module_transmate.git" && cd bigquery_module_transmate && npm install
	cd ~/functions && git clone "https://github.com/ParcelSolutions/imports-api-transmate.git" && cd imports-api-transmate && npm install
	cd ~/functions && git clone "https://github.com/ph-poppe/transmate-calculations.git" && cd transmate-calculations && npm install
	cd ~/nodeapp && git clone "https://github.com/ParcelSolutions/bull-worker.git" && cd bull-worker && npm install
	cd ~/meteor && git clone "https://github.com/ph-poppe/transmate-new.git" && cd transmate-new && npm install
fi

