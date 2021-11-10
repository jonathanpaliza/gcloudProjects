//Create VPC network
resource "google_compute_network" "jonathan-gen-vpc" {
    project = var.project
    name = "jonathan-gen-vpc"
    auto_create_subnetworks = false
    mtu = 1460  
}

//Create subnetwork for jonathan-gen-vpc in us-central1
resource "google_compute_subnetwork" "jonathan-gen-usce1-sn" {
    name = "jonathan-gen-usce1-sn"
    ip_cidr_range = "172.16.0.0/28"
    region = "us-central1"
    network = google_compute_network.jonathan-gen-vpc.name

}

//Create subnetwork for private-cluster-0 in us-west1
resource "google_compute_subnetwork" "my-subnet-0" {
    name = "my-subnet-0"
    ip_cidr_range = "172.16.0.16/28"
    region = "us-west1"
    network = google_compute_network.jonathan-gen-vpc.name
    
    secondary_ip_range = [ {
      ip_cidr_range = "172.20.0.0/20",
      range_name = "pod-range"
    },
    { ip_cidr_range = "172.21.0.0/20",
      range_name = "service-range"
    }]

}
