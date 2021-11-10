//Create cloud router for us-central1 region
resource "google_compute_router" "nat-router-usce1" {
    name = "nat-router-usce1"
    network = "default"
    region = "us-central1"
    
}

//Create cloud router for us-west1 region for default network
resource "google_compute_router" "nat-router-default-uswe1" {
  name = "nat-router-default-uswe1"
  network = "default"
  region = "us-west1"

}


//Create cloud router for us-west1 region
resource "google_compute_router" "nat-router-uswe1" {
  name = "nat-router-uswe1"
  network = google_compute_network.jonathan-gen-vpc.self_link
  region = "us-west1"

}

//Create cloud router NAT for us-central1 region
resource "google_compute_router_nat" "nat-config-usce1" {
    name = "nat-config-usce1"
    router = google_compute_router.nat-router-usce1.name
    region = google_compute_router.nat-router-usce1.region
    nat_ip_allocate_option = "AUTO_ONLY"
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
     
}

//Create cloud router NAT for us-west1 region
resource "google_compute_router_nat" "nat-config-uswe1" {
  name = "nat-config-uswe1"
  router = google_compute_router.nat-router-uswe1.name
  region = google_compute_router.nat-router-uswe1.region
  nat_ip_allocate_option = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

}

//Create cloud router NAT for us-west1 region for default network
resource "google_compute_router_nat" "nat-config-default-uswe1" {
  name = "nat-config-uswe1"
  router = google_compute_router.nat-router-default-uswe1.name
  region = google_compute_router.nat-router-default-uswe1.region
  nat_ip_allocate_option = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  
}

