//Create firewall to allow IAP tunnel
resource "google_compute_firewall" "tunnel-iap-firewal" {
    name = "tunnel-iap-firewall"
    network = google_compute_network.jonathan-gen-vpc.self_link
    project = var.project

    allow {
        protocol = "tcp"
        ports = [ "22" ]
    }

    source_ranges = ["35.235.240.0/20"] 

    target_tags = [ "test-server", "gke-cluster" ]
}

//Create firewall to allow IAP tunnel
resource "google_compute_firewall" "tunnel-iap-all-firewal" {
    name = "tunnel-iap-all-firewall"
    network = google_compute_network.jonathan-gen-vpc.self_link
    project = var.project

    allow {
        protocol = "all"
    }

    source_ranges = ["35.235.240.0/20"]  

    target_tags = [ "test-server", "gke-cluster" ]
}

//Create firewall rule going to Kubernetes control plane
resource "google_compute_firewall" "allow-443-egress" {
  name = "allow-443-egress"
  network = google_compute_network.jonathan-gen-vpc.self_link
  project = var.project
  direction = "EGRESS"
  destination_ranges = [ "172.19.0.32/28" ]

  allow {
    protocol = "tcp"
    ports = [ "443" ]
  }

  target_tags = [ "test-server" ]
  
}