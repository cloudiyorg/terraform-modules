variable "region" {
  type        = string
  description = "Region"
}

variable "env" {
  type        = string
  description = "Environment namespace."
}

variable "cloudfront_distribution_aliases"{
  type = list(string)
}

variable "cloudfront_distribution_enable"{
  type = bool
}

variable "cloudfront_distribution_cache_allowed_methods"{
  type = list(string)
}

variable "cloudfront_distribution_cache_cached_methods"{
  type = list(string)
}

variable "cloudfront_distribution_cache_target_origin_id"{
  type = string
}

variable "cloudfront_distribution_cache_viewer_protocol_policy"{
  type = string
}

variable "cloudfront_distribution_cache_compress"{
  type = bool
}

variable "cloudfront_distribution_default_root_object"{
  type = string
}

variable "cloudfront_distribution_origin_domain_name"{
  type = string
}

variable "cloudfront_distribution_geo_restriction_type"{
  type = string
}

variable "cloudfront_distribution_viewer_certificate"{
  type = bool
}