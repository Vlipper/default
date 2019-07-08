#! /bin/bash
set -e

# load miniconda into /tmp
cd /tmp
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

# install miniconda into common dir /opt/miniconda
## guide: https://docs.anaconda.com/anaconda/install/silent-mode/
sudo mkdir /opt/miniconda && sudo chmod -R 777 /opt/miniconda
bash Miniconda3-latest-Linux-x86_64.sh -b -f -p /opt/miniconda

# add conda to PATH
sudo echo "export PATH=$PATH:/opt/miniconda/bin" >> /etc/environment # /etc/profile
export PATH="$PATH:/opt/miniconda/bin"

# add new priority channel
conda config --prepend channels conda-forge

# install packages from requirements.txt
conda install --file /tmp/git_default/vm_installation/requirements.txt --yes

# make done file
touch /opt/.conda_done
