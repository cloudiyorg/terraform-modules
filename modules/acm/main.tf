resource "aws_acm_certificate" "project_ssl_certificate" {
  domain_name       = var.acm_domain_name
  validation_method = "DNS"
}
