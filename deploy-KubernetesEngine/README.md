# Deploy Kubernetes Engine

I divided my terraform files for every resources in GCP for better understanding. 
On the main.tf file which hold the container cluster resource, it specifies the initial number of node. 
The master authorized networks config block specified the CIDR block which is the instance that can connect to the master node or control plane that serves as API server which controls the whole Kubernetes cluster. 

The IP allocation policy block specifies the cluster and services IP range which will be use by cluster and services. This is derive from the secondary ip range of a subnetwork. 

