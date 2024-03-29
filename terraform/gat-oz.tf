# Generated by ./ip-to-dns.sh
resource "aws_route53_record" "training-vm-oz-0" {
  zone_id = var.training-gxp-oz
  name    = "gat-0.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.84.109"]
}
resource "aws_route53_record" "training-vm-oz-0-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-0.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-0.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-1" {
  zone_id = var.training-gxp-oz
  name    = "gat-1.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.85.1"]
}
resource "aws_route53_record" "training-vm-oz-1-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-1.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-1.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-2" {
  zone_id = var.training-gxp-oz
  name    = "gat-2.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.86.96"]
}
resource "aws_route53_record" "training-vm-oz-2-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-2.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-2.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-3" {
  zone_id = var.training-gxp-oz
  name    = "gat-3.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.85.189"]
}
resource "aws_route53_record" "training-vm-oz-3-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-3.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-3.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-4" {
  zone_id = var.training-gxp-oz
  name    = "gat-4.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.84.110"]
}
resource "aws_route53_record" "training-vm-oz-4-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-4.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-4.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-5" {
  zone_id = var.training-gxp-oz
  name    = "gat-5.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.85.95"]
}
resource "aws_route53_record" "training-vm-oz-5-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-5.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-5.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-6" {
  zone_id = var.training-gxp-oz
  name    = "gat-6.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.87.146"]
}
resource "aws_route53_record" "training-vm-oz-6-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-6.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-6.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-7" {
  zone_id = var.training-gxp-oz
  name    = "gat-7.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.84.82"]
}
resource "aws_route53_record" "training-vm-oz-7-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-7.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-7.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-8" {
  zone_id = var.training-gxp-oz
  name    = "gat-8.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.84.255"]
}
resource "aws_route53_record" "training-vm-oz-8-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-8.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-8.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-9" {
  zone_id = var.training-gxp-oz
  name    = "gat-9.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.87.169"]
}
resource "aws_route53_record" "training-vm-oz-9-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-9.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-9.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-10" {
  zone_id = var.training-gxp-oz
  name    = "gat-10.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.86.104"]
}
resource "aws_route53_record" "training-vm-oz-10-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-10.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-10.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-11" {
  zone_id = var.training-gxp-oz
  name    = "gat-11.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.84.221"]
}
resource "aws_route53_record" "training-vm-oz-11-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-11.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-11.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-12" {
  zone_id = var.training-gxp-oz
  name    = "gat-12.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.85.11"]
}
resource "aws_route53_record" "training-vm-oz-12-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-12.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-12.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-13" {
  zone_id = var.training-gxp-oz
  name    = "gat-13.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.84.179"]
}
resource "aws_route53_record" "training-vm-oz-13-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-13.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-13.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-14" {
  zone_id = var.training-gxp-oz
  name    = "gat-14.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.84.229"]
}
resource "aws_route53_record" "training-vm-oz-14-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-14.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-14.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-15" {
  zone_id = var.training-gxp-oz
  name    = "gat-15.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.87.175"]
}
resource "aws_route53_record" "training-vm-oz-15-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-15.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-15.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-16" {
  zone_id = var.training-gxp-oz
  name    = "gat-16.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.85.68"]
}
resource "aws_route53_record" "training-vm-oz-16-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-16.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-16.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-17" {
  zone_id = var.training-gxp-oz
  name    = "gat-17.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.85.129"]
}
resource "aws_route53_record" "training-vm-oz-17-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-17.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-17.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-18" {
  zone_id = var.training-gxp-oz
  name    = "gat-18.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.84.214"]
}
resource "aws_route53_record" "training-vm-oz-18-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-18.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-18.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-19" {
  zone_id = var.training-gxp-oz
  name    = "gat-19.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.84.10"]
}
resource "aws_route53_record" "training-vm-oz-19-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-19.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-19.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-20" {
  zone_id = var.training-gxp-oz
  name    = "gat-20.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.86.255"]
}
resource "aws_route53_record" "training-vm-oz-20-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-20.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-20.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-21" {
  zone_id = var.training-gxp-oz
  name    = "gat-21.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.86.88"]
}
resource "aws_route53_record" "training-vm-oz-21-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-21.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-21.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-22" {
  zone_id = var.training-gxp-oz
  name    = "gat-22.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.84.127"]
}
resource "aws_route53_record" "training-vm-oz-22-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-22.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-22.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-23" {
  zone_id = var.training-gxp-oz
  name    = "gat-23.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.84.123"]
}
resource "aws_route53_record" "training-vm-oz-23-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-23.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-23.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-24" {
  zone_id = var.training-gxp-oz
  name    = "gat-24.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.87.194"]
}
resource "aws_route53_record" "training-vm-oz-24-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-24.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-24.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-25" {
  zone_id = var.training-gxp-oz
  name    = "gat-25.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.85.112"]
}
resource "aws_route53_record" "training-vm-oz-25-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-25.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-25.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-26" {
  zone_id = var.training-gxp-oz
  name    = "gat-26.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.86.143"]
}
resource "aws_route53_record" "training-vm-oz-26-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-26.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-26.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-27" {
  zone_id = var.training-gxp-oz
  name    = "gat-27.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.84.130"]
}
resource "aws_route53_record" "training-vm-oz-27-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-27.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-27.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-28" {
  zone_id = var.training-gxp-oz
  name    = "gat-28.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.84.215"]
}
resource "aws_route53_record" "training-vm-oz-28-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-28.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-28.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-29" {
  zone_id = var.training-gxp-oz
  name    = "gat-29.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.86.193"]
}
resource "aws_route53_record" "training-vm-oz-29-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-29.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-29.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-30" {
  zone_id = var.training-gxp-oz
  name    = "gat-30.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.85.251"]
}
resource "aws_route53_record" "training-vm-oz-30-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-30.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-30.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-31" {
  zone_id = var.training-gxp-oz
  name    = "gat-31.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.84.40"]
}
resource "aws_route53_record" "training-vm-oz-31-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-31.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-31.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-32" {
  zone_id = var.training-gxp-oz
  name    = "gat-32.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.84.118"]
}
resource "aws_route53_record" "training-vm-oz-32-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-32.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-32.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-33" {
  zone_id = var.training-gxp-oz
  name    = "gat-33.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.85.145"]
}
resource "aws_route53_record" "training-vm-oz-33-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-33.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-33.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-34" {
  zone_id = var.training-gxp-oz
  name    = "gat-34.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.87.89"]
}
resource "aws_route53_record" "training-vm-oz-34-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-34.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-34.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-35" {
  zone_id = var.training-gxp-oz
  name    = "gat-35.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.85.88"]
}
resource "aws_route53_record" "training-vm-oz-35-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-35.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-35.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-36" {
  zone_id = var.training-gxp-oz
  name    = "gat-36.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.85.152"]
}
resource "aws_route53_record" "training-vm-oz-36-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-36.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-36.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-37" {
  zone_id = var.training-gxp-oz
  name    = "gat-37.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.84.74"]
}
resource "aws_route53_record" "training-vm-oz-37-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-37.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-37.oz.galaxy.training"]
}

resource "aws_route53_record" "training-vm-oz-38" {
  zone_id = var.training-gxp-oz
  name    = "gat-38.oz.galaxy.training"
  type    = "A"
  ttl     = "7200"
  records = ["115.146.85.222"]
}
resource "aws_route53_record" "training-vm-oz-38-wildcard" {
  zone_id = var.training-gxp-oz
  name    = "*.interactivetoolentrypoint.interactivetool.gat-38.oz.galaxy.training"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-38.oz.galaxy.training"]
}

