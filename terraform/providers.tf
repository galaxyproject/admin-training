provider "aws" {
}

data "aws_route53_zone" "training-gxp-oz" {
  name = "oz.galaxy.training."
}

data "aws_route53_zone" "training-gxp-us" {
  name = "us.galaxy.training."
}
