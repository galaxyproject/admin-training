data "openstack_images_image_v2" "gat-image-be" {
  name     = "Ubuntu-20.04"
  provider = openstack.vsc
}

output "test-be" {
  value = ["${data.openstack_images_image_v2.gat-image-be.id}"]
}

data "openstack_images_image_v2" "gat-image-eu" {
  name     = "Ubuntu 20.04"
  provider = openstack.eu
}

output "test-eu" {
  value = ["${data.openstack_images_image_v2.gat-image-eu.id}"]
}
