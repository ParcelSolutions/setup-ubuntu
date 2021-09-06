export DEBIAN_FRONTEND=noninteractive
sudo apt update
sudo apt upgrade -y
	echo "=> BUILD"
		sudo apt-get update && sudo apt-get install -y --no-install-recommends apt-utils
		sudo apt-get install -y build-essential && sudo apt-get install -y apt-transport-https ca-certificates
	echo "=> node"
		sudo apt install -y nodejs
		sudo apt install -y npm
		sudo npm install npm@latest -g
		sudo npm install -g webpack mocha

	echo "=> build CF"
		wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | sudo apt-key add -
		echo "deb https://packages.cloudfoundry.org/debian stable main" | sudo tee /etc/apt/sources.list.d/cloudfoundry-cli.list 
		  sudo apt-get update &&  sudo apt-get install cf-cli -y --allow-unauthenticated && cf -v
		  cf add-plugin-repo CF-Community https://plugins.cloudfoundry.org  
		  cf install-plugin blue-green-deploy -r CF-Community -f 
		  cf install-plugin -r CF-Community app-autoscaler-plugin -f 

	echo "=> build IBMCLOUD"
		curl -fsSL https://clis.cloud.ibm.com/install/linux | sudo sh		  
		ibmcloud plugin install cloud-functions -f 
		ibmcloud plugin install cloud-databases -f
		ibmcloud -v 
	echo "=> build Meteor"
	  	curl https://install.meteor.com | /bin/sh &&  meteor --version 
		echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
				
	echo "-> setup python"

		sudo apt-get install -y python3
		sudo apt-get install -y python3-pip 
		sudo apt-get install -y python3-venv
		sudo python3 -m venv venv
		
	echo "=> Git"
		sudo apt install -y --no-install-recommends  git
		git config --global user.email "jan@transmate.eu"
		git config --global user.name "Jan Carpentier"
		#store passwords
		git config --global credential.helper "cache --timeout=3600"
	echo "=> DOPPLER"
		(curl -Ls --tlsv1.2 --proto "=https" --retry 3 https://cli.doppler.com/install.sh || wget -t 3 -qO- https://cli.doppler.com/install.sh) | sudo sh
