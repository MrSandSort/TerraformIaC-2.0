variable "vpc_cidr"{
    type= string 
    default= "10.0.0.0/20"
}
variable "access_key" {
  type      = string
  sensitive = true
}

variable "secret_key" {
  type      = string
  sensitive = true
}

variable "region"{
    type= string
    default= "us-east-1"
}

variable "zone"{
    type= string
    default="us-east-1b"
}

variable "public_cidr"{
    type= string
    default="10.0.1.0/24"
}

variable "key_name"{
    type= string
}

variable "private_cidr"{
    type=string
    default="10.0.2.0/24"
}