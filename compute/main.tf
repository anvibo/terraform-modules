variable "name"  {}
variable "type" {}
variable "boot_disk_type" {}
variable "boot_disk_size" {}
variable "image" {}
variable "subnetwork" {}
variable "network_tags" {
    type = "list"
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

    tags = "${var.network_tags}"

    network_interface {
        subnetwork = "${var.subnetwork}"
    }
}


