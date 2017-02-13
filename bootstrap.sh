#turn off inactivity settings
sudo -u vagrant gsettings set org.gnome.desktop.session idle-delay 0
sudo -u vagrant gsettings set org.gnome.desktop.screensaver lock-enabled false

#update locale
cp -f /vagrant_data/locale /etc/default/locale
source /etc/default/locale

#replace bashrc
cp -f /vagrant_data/.bashrc /home/vagrant/.bashrc
source /home/vagrant/.bashrc 

#Install Repository Manager
apt-get install software-properties-common

#Add Necessary Repositories
add-apt-repository "deb https://apt.dockerproject.org/repo/ ubuntu-$(lsb_release -cs) main"

#Sync Packages and Repositories
apt-get update

#Install Apache
apt-get install -y apache2

#Install Curl
apt-get install -y curl

#Install Docker
apt-get  install -y docker-engine --allow-unauthenticated
apt-get install -y docker-compose
#Need to set-up docker to run without sudo

#Install Java
apt-get install -y default-jdk
echo "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java" >> /etc/environment
source /etc/environment

#Install Node
apt-get install -y nodejs
apt-get install -y nodejs-legacy
echo "alias node='nodejs'" >> /home/vagrant/.bashrc

#Install Kubernetes
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

#Install VS Code
wget -O /home/vagrant/Downloads/vscode.deb http://go.microsoft.com/fwlink/?LinkID=760868
#Install Packages
dpkg -i /home/vagrant/Downloads/vscode.deb
apt-get install -f
echo "alias code='code --disable-gpu'" >> /home/vagrant/.bashrc
source /home/vagrant/.bashrc

#Install Chrome
sudo apt-get install libxss1 libappindicator1 libindicator7
wget -O /home/vagrant/Downloads/chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i /home/vagrant/Downloads/chrome.deb
sudo apt-get install -f

#Update launcher to include VS Code and Chrome
sudo -u vagrant gsettings set com.canonical.Unity.Launcher favorites "['unity://running-apps', 'unity://devices', 'application://code.desktop', 'application://gnome-terminal.desktop', 'application://google-chrome.desktop']"^C

