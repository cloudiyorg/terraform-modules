resource "aws_cloudfront_distribution" "project_main_distribution" {
  enabled = var.cloudfront_distribution_enable
  aliases = var.cloudfront_distribution_aliases
  default_cache_behavior {
    allowed_methods        = var.cloudfront_distribution_cache_allowed_methods
    cached_methods         = var.cloudfront_distribution_cache_cached_methods
    target_origin_id       = var.cloudfront_distribution_cache_target_origin_id
    viewer_protocol_policy = var.cloudfront_distribution_cache_viewer_protocol_policy

    compress = var.cloudfront_distribution_cache_compress
  }

  default_root_object = var.cloudfront_distribution_default_root_object

  origin {
    domain_name = var.cloudfront_distribution_origin_domain_name
    origin_id   = var.cloudfront_distribution_cache_target_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.s3_policies_oai.cloudfront_access_identity_path
    }
  }
  restrictions {
    geo_restriction {
      restriction_type = var.cloudfront_distribution_geo_restriction_type
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = var.cloudfront_distribution_viewer_certificate
  }

  tags = {
    Environment  = var.env
  }
}

resource "aws_cloudfront_origin_access_identity" "s3_policies_oai" {
  comment = "This is for to access S3 bucket through CloudFront"
}
