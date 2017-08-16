# update package list
sudo apt-get update

# install git
sudo apt-get -y install git

# clone repository
git clone https://github.com/chescos/vps-setup-ftp-client.git /root/setup

# start setup
/root/setup/setup.sh
