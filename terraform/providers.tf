provider "aws" {
  region = "us-east-1"
}

#data "aws_route53_zone" "training-gxp-oz" {
#name = "oz.galaxy.training."
#}

#data "aws_route53_zone" "training-gxp-us" {
#name = "us.galaxy.training."
#}

variable "training-gxp-oz" {
  type    = string
  default = "Z06074271TNBSU75H5S3Y"
}

variable "training-gxp-us" {
  type    = string
  default = "Z022528316NCQCRTGOOLK"
}
