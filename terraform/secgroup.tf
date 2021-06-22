resource "openstack_networking_secgroup_v2" "gat" {
  provider = openstack.vsc
  name                 = "gat"
  description          = "[tf] Allow GAT port"
  delete_default_rules = "true"
}

resource "openstack_networking_secgroup_rule_v2" "gat-ping" {
  provider = openstack.vsc
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  security_group_id = openstack_networking_secgroup_v2.gat.id
}

variable "gat-ports" {
  provider = openstack.vsc
  description = "GAT ports"
  type        = list(string)
  default     = ["22", "80", "443", "5671", "8080"]
}

resource "openstack_networking_secgroup_rule_v2" "gat-ports4" {
  provider = openstack.vsc
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  security_group_id = openstack_networking_secgroup_v2.gat.id

  count          = 5
  port_range_min = element(var.gat-ports, count.index)
  port_range_max = element(var.gat-ports, count.index)
}

resource "openstack_networking_secgroup_rule_v2" "gat-ports6" {
  provider = openstack.vsc
  direction         = "ingress"
  ethertype         = "IPv6"
  protocol          = "tcp"
  security_group_id = openstack_networking_secgroup_v2.gat.id

  count          = 5
  port_range_min = element(var.gat-ports, count.index)
  port_range_max = element(var.gat-ports, count.index)
}

resource "openstack_networking_secgroup_rule_v2" "gat-egress6" {
  provider = openstack.vsc
  direction         = "egress"
  ethertype         = "IPv6"
  security_group_id = openstack_networking_secgroup_v2.gat.id
}

resource "openstack_networking_secgroup_rule_v2" "gat-egress4" {
  provider = openstack.vsc
  direction         = "egress"
  ethertype         = "IPv4"
  security_group_id = openstack_networking_secgroup_v2.gat.id
}

