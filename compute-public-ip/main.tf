variable "name"  {}
variable "type" {}
variable "boot_disk_type" {}
variable "boot_disk_size" {}
variable "image" {}
variable "subnetwork" {}
variable "network_tags" {
    type = "list"
}
variable "startup_script" {

}

resource "google_compute_address" "static" {
  name = "ipv4-address"
}

resource "google_compute_instance" "default" {
    name = "${var.name}"

    machine_type = "${var.type}"

    boot_disk {
        initialize_params {
            image = "${var.image}"
            size = "${var.boot_disk_size}"
            type = "${var.boot_disk_type}"
        }
        
    }

    service_account {
        scopes = [
            "https://www.googleapis.com/auth/cloud-platform.read-only",
            "https://www.googleapis.com/auth/servicecontrol",
            "https://www.googleapis.com/auth/devstorage.read_write",
            "https://www.googleapis.com/auth/logging.write",
            "https://www.googleapis.com/auth/monitoring.write",
            "https://www.googleapis.com/auth/trace.append"
        ]
        
    }

    tags = "${var.network_tags}"

    network_interface {
        subnetwork = "${var.subnetwork}"

        access_config {
            nat_ip = "${google_compute_address.static.address}"
        }
    }

    lifecycle {
        ignore_changes = [ "attached_disk" ]
    }

    metadata_startup_script = "${var.startup_script}"
}

output "instance_id" {
  value = "${google_compute_instance.default.name}"
}


