variable "VSC_OS_APPLICATION_CREDENTIAL_ID" {
  type        = string
  description = "OS_APPLICATION_CREDENTIAL_ID"
}

variable "VSC_OS_APPLICATION_CREDENTIAL_SECRET" {
  type        = string
  description = "OS_APPLICATION_CREDENTIAL_SECRET"
}

variable "EU_OS_USERNAME" {
  type        = string
  description = "OS_USERNAME"
}

variable "EU_OS_PASSWORD" {
  type        = string
  description = "OS_PASSWORD"
}

provider "openstack" {
  auth_url = "https://localhost"
  region   = "regionOne"
}

provider "openstack" {
  alias                         = "vsc"
  auth_url                      = "https://cloud.vscentrum.be:13000"
  region                        = "regionOne"
  application_credential_id     = var.VSC_OS_APPLICATION_CREDENTIAL_ID
  application_credential_secret = var.VSC_OS_APPLICATION_CREDENTIAL_SECRET
}

provider "openstack" {
  alias               = "eu"
  auth_url            = "https://idm01.bw-cloud.org:5000/v3"
  project_domain_name = "Default"
  tenant_name         = "freiburg_galaxy"
  region              = "Freiburg"


  user_name = var.EU_OS_USERNAME
  password  = var.EU_OS_PASSWORD
}
