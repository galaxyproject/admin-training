data "aws_route53_zone" "training-gxp-eu" {
  zone_id = "Z05016927AMHTHGB1IS2"
  #name         = "training.galaxyproject.eu"
}

resource "aws_route53_record" "training-vm-jetstream-0" {
  zone_id = data.aws_route53_zone.training-gxp-eu.zone_id
  name    = "gat-0.jetstream.training.galaxyproject.eu"
  type    = "A"
  ttl     = "7200"
  records = ["129.114.16.211"]
}

resource "aws_route53_record" "training-vm-jetstream-1" {
  zone_id = data.aws_route53_zone.training-gxp-eu.zone_id
  name    = "gat-1.jetstream.training.galaxyproject.eu"
  type    = "A"
  ttl     = "7200"
  records = ["129.114.16.161"]
}

resource "aws_route53_record" "training-vm-jetstream-2" {
  zone_id = data.aws_route53_zone.training-gxp-eu.zone_id
  name    = "gat-2.jetstream.training.galaxyproject.eu"
  type    = "A"
  ttl     = "7200"
  records = ["129.114.16.172"]
}
