variable "aws_region" {
  type        = string
  default     = "us-west-2"
}

variable "environment_name" {
  type        = string
  default     = "dev"
}

variable "business_division" {
  type        = string
  default     = "retail"
}

variable "cluster_name" {
  type        = string
  default     = "eksdemo"
}

variable "cluster_version" {
  type        = string
  default     = null
}

variable "cluster_service_ipv4_cidr" {
  type        = string
  default     = null
}

variable "cluster_endpoint_private_access" {
  type        = bool
  default     = false
}

variable "cluster_endpoint_public_access" {
  type        = bool
  default     = true
}

# Currently, the public access CIDR blocks are set to allow all traffic
variable "cluster_endpoint_public_access_cidrs" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "tags" {
  type        = map(string)
  default     = {
    Terraform = "true"
  }
}

variable "node_instance_types" {
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_capacity_type" {
  type        = string
  default     = "ON_DEMAND" # or SPOT
}

variable "node_disk_size" {
  type        = number
  default     = 20
}