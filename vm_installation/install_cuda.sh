#! /bin/bash
set -e
cd /tmp

# CUDA
wget https://developer.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda-repo-ubuntu1604-10-1-local-10.1.168-418.67_1.0-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1604-10-1-local-10.1.168-418.67_1.0-1_amd64.deb
sudo apt-key add /var/cuda-repo-10-1-local-10.1.168-418.67/7fa2af80.pub
sudo apt-get update
sudo apt-get install cuda --yes -q

# cuDNN, get link on https://developer.nvidia.com/cudnn
cudnnlink="$1"
wget -O cudnn-10.1-linux-x64.tgz "$cudnnlink"
# check that downloaded file bigger than 10Mb
if ((10 > `du -m cudnn-10.1-linux-x64.tgz | cut -f1`))
then
    echo 'Downloaded file cudnn-10.1-linux-x64.tgz is lighter than 10Mb'
    exit 1
fi
# unzip and implement cuDNN
tar -xzvf cudnn-10.1-linux-x64.tgz
sudo cp cuda/include/cudnn.h /usr/local/cuda/include
sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64
sudo chmod a+r /usr/local/cuda/include/cudnn.h

# install pytorch
conda install pytorch torchvision cudatoolkit=10.0 -c pytorch --yes -q

# make done file
touch /opt/.cuda_done
