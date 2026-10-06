data "aws_s3_bucket" "tfstate_bucket" {
  bucket = "tfstate-${var.environment_name}-${var.aws_region}-${var.bucket_suffix}" 
}