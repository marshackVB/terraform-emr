#!/bin/bash

# Install miniconda includes only the Anaconda package installer and Python

# wget conda and save in a bash script with a shorter name
# If the wget operation is successful, then run the bash script
# -b : notify when jobs running in background terminate
# -p : run as Set User ID (SUID) - which allow anyone to accesses the file to access
# it as the owner

# Python 3 latest Anaconda install: https://repo.continuum.io/archive/Anaconda3-5.1.0-Linux-x86_64.sh

wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/conda.sh \
    && /bin/bash ~/conda.sh -b -p $HOME/conda


rm ~/conda.sh


# set environment variables
echo -e 'export PATH=$HOME/conda/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

# install packages
eval "pip install $1"
