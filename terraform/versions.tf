terraform {
  required_version = ">= 0.13"
  required_providers {
    openstack = {
      source                = "terraform-provider-openstack/openstack"
      configuration_aliases = [openstack.vsc, openstack.eu]
    }
  }
}
