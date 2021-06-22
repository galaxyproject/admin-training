data "openstack_images_image_v2" "hello-be" {
  name     = "Ubuntu-20.04"
  provider = openstack.vsc
}

output "test-be" {
  value = ["${data.openstack_images_image_v2.hello-be.id}"]
}

data "openstack_images_image_v2" "hello-eu" {
  name     = "Ubuntu 20.04"
  provider = openstack.eu
}

output "test-eu" {
  value = ["${data.openstack_images_image_v2.hello-eu.id}"]
}
