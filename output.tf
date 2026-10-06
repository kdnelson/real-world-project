output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = [for s in aws_subnet.public : s.id]
}

output "private_subnet_ids" {
  value = [for s in aws_subnet.private : s.id]
}

output "public_subnet_map" {
  value = { for az, subnet in aws_subnet.public : az => subnet.id }
}

output "tfstate_bucket_arn" {
  value = data.aws_s3_bucket.tfstate_bucket.arn
}

output "tfstate_bucket_id" {
  value = data.aws_s3_bucket.tfstate_bucket.id
}