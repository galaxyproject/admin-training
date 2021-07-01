variable "gat-count-be" {
  default = 80
}

variable "gat-be-flavour" {
  default = "UPSv1.large"
}

data "openstack_images_image_v2" "gat-image-be" {
  name     = "Ubuntu-20.04"
  provider = openstack.vsc
}

# The VMs themselves.
resource "openstack_compute_instance_v2" "training-vm-be" {
  name = "gat-${count.index}.be.training.galaxyproject.eu"

  # Not required when booting from volume
  image_id        = data.openstack_images_image_v2.gat-image-be.id
  flavor_name     = var.gat-be-flavour
  security_groups = ["gat"]

  key_pair = "cloud-be"

  network {
    name = "VSC_00018_vm"
  }

  count    = var.gat-count-be
  provider = openstack.vsc
}

# Outputs to be consumed by admins
output "training_ips-be" {
  value = ["${openstack_networking_floatingip_associate_v2.fip_1.*.floating_ip}"]
}

output "training_dns-be" {
  value = ["${aws_route53_record.training-vm-be.*.name}"]
}

variable "floatingips" {
  type = list(string)

  default = [
    "193.190.80.20",
    "193.190.80.21",
    "193.190.80.22",
    "193.190.80.23",
    "193.190.80.24",
    "193.190.80.25",
    "193.190.80.26",
    "193.190.80.27",
    "193.190.80.28",
    "193.190.80.29",
    "193.190.80.30",
    "193.190.80.31",
    "193.190.80.32",
    "193.190.80.33",
    "193.190.80.34",
    "193.190.80.35",
    "193.190.80.36",
    "193.190.80.37",
    "193.190.80.38",
    "193.190.80.39",
    "193.190.80.40",
    "193.190.80.41",
    "193.190.80.42",
    "193.190.80.43",
    "193.190.80.44",
    "193.190.80.45",
    "193.190.80.46",
    "193.190.80.47",
    "193.190.80.48",
    "193.190.80.49",
    "193.190.80.50",
    "193.190.80.51",
    "193.190.80.52",
    "193.190.80.53",
    "193.190.80.54",
    "193.190.80.55",
    "193.190.80.56",
    "193.190.80.57",
    "193.190.80.58",
    "193.190.80.59",
    "193.190.80.60",
    "193.190.80.61",
    "193.190.80.62",
    "193.190.80.63",
    "193.190.80.64",
    "193.190.80.65",
    "193.190.80.66",
    "193.190.80.67",
    "193.190.80.68",
    "193.190.80.69",
    "193.190.80.70",
    "193.190.80.71",
    "193.190.80.72",
    "193.190.80.73",
    "193.190.80.74",
    "193.190.80.75",
    "193.190.80.76",
    "193.190.80.77",
    "193.190.80.78",
    "193.190.80.79",
    "193.190.80.80",
    "193.190.80.81",
    "193.190.80.82",
    "193.190.80.83",
    "193.190.80.84",
    "193.190.80.85",
    "193.190.80.86",
    "193.190.80.87",
    "193.190.80.88",
    "193.190.80.89",
    "193.190.80.90",
    "193.190.80.91",
    "193.190.80.92",
    "193.190.80.93",
    "193.190.80.94",
    "193.190.80.95",
    "193.190.80.96",
    "193.190.80.97",
    "193.190.80.98",
    "193.190.80.99",
    "193.190.80.100",
  ]
}

data "openstack_networking_floatingip_v2" "floatingips" {
  count    = var.gat-count-be
  address  = element(var.floatingips, count.index)
  provider = openstack.vsc
}

data "openstack_networking_port_v2" "ports" {
  fixed_ip = element(
    openstack_compute_instance_v2.training-vm-be.*.access_ip_v4,
    count.index,
  )
  count    = var.gat-count-be
  provider = openstack.vsc
}

resource "openstack_networking_floatingip_associate_v2" "fip_1" {
  floating_ip = element(
    data.openstack_networking_floatingip_v2.floatingips.*.address,
    count.index,
  )
  port_id = element(data.openstack_networking_port_v2.ports.*.id, count.index)

  count    = var.gat-count-be
  provider = openstack.vsc
}

data "aws_route53_zone" "training-gxp-eu" {
  zone_id = "Z05016927AMHTHGB1IS2"
  #name         = "training.galaxyproject.eu"
}
resource "aws_route53_record" "training-vm-be" {
  zone_id = data.aws_route53_zone.training-gxp-eu.zone_id
  name    = "gat-${count.index}.be.training.galaxyproject.eu"
  type    = "A"
  ttl     = "3600"
  records = ["${element(data.openstack_networking_floatingip_v2.floatingips.*.address, count.index)}"]
  count   = var.gat-count-be
}

# Only for the REAL gat.
resource "aws_route53_record" "training-vm-be-gxit-wildcard" {
  zone_id = aws_route53_zone.training-gxp-be.zone_id
  name    = "*.interactivetoolentrypoint.interactivetool.gat-${count.index}.be.training.galaxyproject.eu"
  type    = "CNAME"
  ttl     = "3600"
  records = ["gat-${count.index}.be.training.galaxyproject.eu"]
  count   = var.gat-count-be
}
