provider "aws" {
}

variable "zone_galaxyproject_eu" {
  default = "Z386N8B8JBC6TQ"
}

variable "zone_usegalaxy_eu" {
  default = "Z1C7L7XFF9613J"
}

data "aws_route53_zone" "training-gxp-eu" {
  name         = "training.galaxyproject.eu."
}


#variable "EU_OS_USERNAME" {
#type        = string
#description = "OS_USERNAME"
#}

#variable "EU_OS_PASSWORD" {
#type        = string
#description = "OS_PASSWORD"
#}

#provider "openstack" {
#auth_url = "https://localhost"
#region   = "regionOne"
#}

#provider "openstack" {
#alias               = "eu"
#auth_url            = "https://idm01.bw-cloud.org:5000/v3"
#project_domain_name = "Default"
#tenant_name         = "freiburg_galaxy"
#region              = "Freiburg"


#user_name = var.EU_OS_USERNAME
#password  = var.EU_OS_PASSWORD
#}
