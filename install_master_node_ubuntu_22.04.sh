./install_k8s_common.sh
ufw enable
sudo ufw allow 6443/tcp
sudo ufw allow 2379:2380/tcp
sudo ufw allow 10250/tcp
sudo ufw allow 10259/tcp
sudo ufw allow 10257/tcp
# Opening ports for Calico CNI
sudo ufw allow 179/tcp #allows incoming TCP traffic on port 179, 
#which is used by the Kubernetes API server for communication 
# with the etcd datastore
sudo ufw allow 4789/udp #allows incoming UDP traffic on port 4789, 
#which is used by the Kubernetes networking plugin (e.g. Calico) 
# for overlay networking.
sudo ufw allow 4789/tcp #allows incoming TCP traffic on port 4789, 
#which is also used by the Kubernetes networking plugin for 
# overlay networking.
sudo ufw allow 2379/tcp #allows incoming TCP traffic on port 2379, 
#which is used by the etcd datastore for communication 
# between cluster nodes.

sudo ufw status
