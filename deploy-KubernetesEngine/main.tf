//Create Kubernetes cluster and node pools
resource "google_container_cluster" "private-cluster-0" {
    provider = google
    name = "private-cluster-0"
    network = google_compute_network.jonathan-gen-vpc.name
    subnetwork = google_compute_subnetwork.my-subnet-0.name
    location = "us-west1-a"

    initial_node_count = 2

    master_authorized_networks_config {
        cidr_blocks {
          display_name = "from-default-network"
          cidr_block = "10.138.0.3/32"
        }

    }

    ip_allocation_policy {
      cluster_secondary_range_name = "pod-range"
      services_secondary_range_name = "service-range"

    }

    private_cluster_config {
      enable_private_endpoint = true
      enable_private_nodes = true
      master_ipv4_cidr_block = "172.19.0.32/28"

      master_global_access_config {
        enabled = true
      }

    }

    node_config {
      disk_size_gb = 10
      machine_type = "n1-standard-2"

      tags = [ "gke-cluster" ]

      shielded_instance_config {
        enable_secure_boot = true
        enable_integrity_monitoring = true
      }

          
    }

    enable_shielded_nodes = true
 
}

//Create test GCP instance 
resource "google_compute_instance" "jonathan-gen-instance" {
    name = "jonathan-gen-instance"
    machine_type = "f1-micro"
    zone = "us-west1-b"
    
    tags = [ "test-server" ]

    boot_disk {
      initialize_params {
        image = "debian-cloud/debian-9"

      }
    }

    network_interface {
      network = "default"
      subnetwork = "default"

    }
  
}

//Create test GCP instance number 2
resource "google_compute_instance" "jonathan-gen-instance-2" {
    name = "jonathan-gen-instance-2"
    machine_type = "f1-micro"
    zone = "us-west1-a"
    
    tags = [ "test-server" ]

    boot_disk {
      initialize_params {
        image = "debian-cloud/debian-9"

      }
    }

    network_interface {
      network = "jonathan-gen-vpc"
      subnetwork = "my-subnet-0"

    }
  
}

//Create test GCP instance number 3
resource "google_compute_instance" "jonathan-gen-instance-3" {
    name = "jonathan-gen-instance-3"
    machine_type = "f1-micro"
    zone = "us-west1-b"
    
    tags = [ "test-server" ]

    boot_disk {
      initialize_params {
        image = "debian-cloud/debian-9"

      }
    }

    network_interface {
      network = "jonathan-gen-vpc"
      subnetwork = "my-subnet-0"

    }

    metadata_startup_script = <<SCRIPT
    sudo apt install ufw
    sudo ufw enable
    sudo ufw allow 22
    sudo iptables-save
    SCRIPT
  
}

resource "google_compute_global_address" "test-global" {
  
}


resource "google_compute_firewall" "testFirewall" {
  
}
