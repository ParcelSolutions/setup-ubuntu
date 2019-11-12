#!/bin/bash

if [ $1 = "desktop" ]
then
	# add user to vboxsf group
	sudo adduser $USER vboxsf
	#set brussels timezone
	sudo timedatectl set-timezone Europe/Brussels
	sudo dpkg-reconfigure --frontend noninteractive tzdata
	#remove games
	sudo apt-get remove gnome-games gnome-games-common empathy
	sudo apt-get remove unity-lens-shopping
	sudo apt purge -y ubuntu-web-launchers
	sudo apt purge -y aisleriot gnome-mahjongg gnome-mines gnome-sudoku
	sudo apt autoremove -y

	#add ntp time server
	sudo apt-get install -y ntp
	
	echo "=> set keyboard BE"
		#sudo loadkeys be
		#sudo setxkbmap be
		# REMOVE some unneeded apps #
		
		# set keyboard
		sudo dpkg-reconfigure keyboard-configuration
		sudo service keyboard-setup restart
		# set be on start
		sh -c "setxkbmap be"
		gsettings set org.gnome.desktop.input-sources sources '[]'
		# switch of screensaver
		gsettings set org.gnome.desktop.screensaver idle-activation-enabled false
		gsettings set org.gnome.desktop.session idle-delay 0

	echo "=> build essentials"
		sudo apt-get update && sudo apt-get install -y --no-install-recommends apt-utils && \
		sudo apt-get install -y build-essential && sudo apt-get install -y apt-transport-https ca-certificates
	echo "=> node"
		sudo apt install -y nodejs
		sudo apt install -y npm
		sudo npm install npm@latest -g
		sudo npm install -g webpack

	echo "=> build CF"


		echo "deb https://packages.cloudfoundry.org/debian stable main" | sudo tee /etc/apt/sources.list.d/cloudfoundry-cli.list && \
		  sudo apt-get update &&  sudo apt-get install cf-cli -y --allow-unauthenticated && cf -v && \ 
		  cf add-plugin-repo CF-Community https://plugins.cloudfoundry.org && \ 
		  cf install-plugin blue-green-deploy -r CF-Community -f && \ 
		  cf install-plugin -r CF-Community app-autoscaler-plugin -f 

	echo "=> build IBMCLOUD"
		curl -fsSL https://clis.cloud.ibm.com/install/linux | sh && \
		  ibmcloud plugin install cloud-functions -f && \ 
		  ibmcloud -v 

	echo "=> build Meteor"
	  	curl https://install.meteor.com | /bin/sh &&  meteor --version 



	# Update Repository Information
		echo 'Updating repository information...'
		sudo apt-get update -qq
	# Dist-Upgrade
		echo 'Performing system upgrade...'
		sudo apt-get dist-upgrade -y


	echo "we will install desktop software now."
	
		sudo apt-get install -y --no-install-recommends filezilla chromium-browser
	
	echo "=> Visual Code"
		sudo apt update
		sudo apt install -y --no-install-recommends  software-properties-common apt-transport-https wget
		wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
		sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
		sudo apt update
		sudo apt install -y --no-install-recommends  code
		sudo npm install -g eslint
		sudo npm install -g jshint
		code --install-extension christian-kohler.npm-intellisense
		code --install-extension dbaeumer.jshint
		code --install-extension dbaeumer.vscode-eslint
		code --install-extension developertejasjadhav.javascript-refactor--sort-imports
		code --install-extension esbenp.prettier-vscode
		code --install-extension HookyQR.beautify
		code --install-extension leizongmin.node-module-intellisense
		code --install-extension mikestead.dotenv
		code --install-extension ms-azuretools.vscode-docker
		code --install-extension ms-python.python
		code --install-extension oderwat.indent-rainbow
		# show installed code --list-extensions

	echo "=> Git"
		sudo apt install -y --no-install-recommends  git
		git config --global user.email "jan@parcelsolutios.eu"
		git config --global user.name "ParcelSolutions"
		git config --global credential.helper "cache --timeout=3600"
		#git cola
		sudo apt install -y git-cola
		#gitahead
		curl -s https://api.github.com/repos/gitahead/gitahead/releases/latest \
			| grep "GitAhead.*.sh" \
			| cut -d : -f 2,3 \
			| tr -d \" \
			| wget -qi -
		sh GitAhead* -y
		rm GitAhead*.sh
		#git hub desktop
		#  sudo rm -rf sources.list.d
		sudo apt update
		sudo apt install -y snapd
		sudo snap install github-desktop --beta --classic

	echo "=> docker"
		sudo apt install -y --no-install-recommends apt-transport-https ca-certificates curl software-properties-common
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
		sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
		curl -fsSL https://get.docker.com -o get-docker.sh
		sh get-docker.sh
	

	
	echo "=> cleanup"
		sudo apt-get purge
		sudo apt-get autoremove -y
		sudo apt-get clean
fi
if [ $1 = "git" ]
then
	echo "=> Install git reps, Do one manually so you are logged in."
	cd ~
	mkdir -p functions
	mkdir -p nodeapp
	mkdir -p meteor
	cd ~/functions && git clone "https://github.com/ParcelSolutions/ibm-function-basis.git" && npm install
	cd ~/functions && git clone "https://github.com/ParcelSolutions/simulaterate.git" && npm install
	cd ~/functions && git clone "https://github.com/ParcelSolutions/bigquery_module_transmate.git" && npm install
	cd ~/functions && git clone "https://github.com/ParcelSolutions/imports-api-transmate.git" && npm install
	cd ~/functions && git clone "https://github.com/ParcelSolutions/simulaterate.git" && npm install
	cd ~/nodeapp && git clone "https://github.com/ParcelSolutions/bull-worker.git" && npm install
	cd ~/meteor && git clone "https://github.com/ph-poppe/transmate-new.git" && npm install
fi
date
