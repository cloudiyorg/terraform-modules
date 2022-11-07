output "s3_policies_oai_iam_arn" {
  value = aws_cloudfront_origin_access_identity.s3_policies_oai.iam_arn
}

output "cloudfront_project_main_distribution_arn" {
  value = aws_cloudfront_distribution.project_main_distribution.arn
}
