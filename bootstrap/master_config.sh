#!/bin/bash

# Set Spark environment variabels 
echo -e "\nexport SPARK_HOME=/usr/lib/spark" >> ~/.bashrc
echo -e "\nexport PYSPARK_PYTHON=/home/hadoop/conda/bin/python" >> ~/.bashrc
echo -e "\n#export PYSPARK_DRIVER_PYTHON=/home/hadoop/conda/bin/jupyter-lab" >> ~/.bashrc
echo "export PYSPARK_DRIVER_PYTHON=/home/hadoop/conda/bin/ipython" >> ~/.bashrc


# JupyterLab configuration
# Create notebok password, replace "99999" with your password of choice
# Example port binding...
# ssh -i ./ssh/mykey.pem -NfL 8888:localhost:8888 hadoop@ec2-0-0-0-0.compute-1.amazonaws.com
# Additional EMR web interfaces and ports...
# https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-web-interfaces.html
# Unbind ports...
# lsof -n -i | grep :8888
# kill -9 <pid>


JUPYTER_PASSWORD=${1:-"mypassword"}
HASHED_PASSWORD=$(python -c "from notebook.auth import passwd; print(passwd('$JUPYTER_PASSWORD'))")


# Create SSL certificate - add this later
# See https://jupyter-notebook.readthedocs.io/en/stable/public_server.html
#mkdir $HOME/certs

#sudo openssl req -x509 -nodes -days 365 -newkey rsa:1024 \
#-subj "/C=GB/ST=London/L=London/O=Org Name/OU=Department Name/CN=Name/emailAddress=myemail@gmail.com" \
#-keyout $HOME/certs/mycert.pem  -out $HOME/certs/mycert.pem

# Create jupyter notebook config file
mkdir -p $HOME/.jupyter
touch ls $HOME/.jupyter/jupyter_notebook_config.py

echo "c = get_config()" >> $HOME/.jupyter/jupyter_notebook_config.py

echo "c.NotebookApp.password = u'${HASHED_PASSWORD}'" >> $HOME/.jupyter/jupyter_notebook_config.py #This isnt working properly for some reason

echo "c.NotebookApp.open_browser = False" >> $HOME/.jupyter/jupyter_notebook_config.py

echo "c.NotebookApp.ip = '0.0.0.0'" >> $HOME/.jupyter/jupyter_notebook_config.py

#echo "c.NotebookApp.certfile = u'${HOME}/certs/mycert.pem'" >> /$HOME/.jupyter/jupyter_notebook_config.py

echo "c.IPKernelApp.pylab = 'inline'" >> $HOME/.jupyter/jupyter_notebook_config.py


