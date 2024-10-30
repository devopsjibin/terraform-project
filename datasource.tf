data "aws_route53_zone" "selected_mydomain" {
  name         = var.mydomain_name
  private_zone = false
}
