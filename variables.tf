variable "vpc_config" {
  description = "To get the CIDR and name of VPC from User"
  type = object({
    name = string
    cidr_block = string
  })

  validation {
    condition = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "Invalid CIDR Format -${var.vpc_config.cidr_block}"
  }
}

variable "subnet_config" {
  # sub1={cidr=.. az=..} sub2={cidr=.. az=..} sub3={cidr=.. az=..}
  description = "Get the CIDR and AZ for Subnets"
  type = map(object({
    cidr_block = string
    az = string
    public = optional(bool, false)  # public nature is optional but bydefault its private
  }))

  validation {
    # sub1={cidr1=} sub2={cidr2=},   list -->  [true, true, false]  All must be ture to proceed
    condition = alltrue([for config in var.subnet_config : can(cidrnetmask(config.cidr_block))])
    error_message = "Invalid CIDR Format"
  }
}