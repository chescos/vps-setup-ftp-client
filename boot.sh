# update package list
sudo apt-get update

# install unzip
sudo apt-get -y install unzip

# download zip folder
wget -O /root/setup.zip https://github.com/chescos/vps-setup-ftp-client/archive/master.zip

# unzip folder
unzip /root/setup.zip -d /root/setup

# start setup
/root/setup/setup.sh
