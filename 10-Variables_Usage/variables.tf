variable "instance_type" {
  description = "Instance Type"
  type        = string
  default     = "t2.micro"
}

variable "allow_ports" {
  description = "Open ports"
  type        = list(any)
  default     = ["80", "8080", "443"]
}

variable "allow_cidr" {
  description = "CIDR blocks"
  type        = list(any)
  default     = ["0.0.0.0/0"]
}

variable "allow_monitoring" {
  description = "Instance monitoring"
  type        = bool
  default     = false
}

variable "common_tags" {
  description = "Common Tags"
  type        = map(any)
  default = {
    Owner   = "A.Burov"
    Name    = "Linux Web Server"
    Project = "ABC Project"
  }
}
