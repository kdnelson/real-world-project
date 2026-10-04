variable "aws_region" {
  type        = string
  default     = "us-west-2"
}

variable "environment_name" {
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
}

variable "tags" {
  type        = map(string)
  default     = {
    Terraform = "true"
  }
}

variable "subnet_newbits" {
  type        = number
  default     = 8
}