variable "aws_region" {
  type        = string
  description = "aws_myregion"
}

variable "projectname" {
  type        = string
  description = "projectname"
}

variable "project_env" {
  type        = string
  description = "project_env"
}

variable "emailid" {
  type        = string
  description = "emailid"
}

variable "myvpc" {
  type        = string
  description = "myvpc"

}

variable "ami" {
  type        = string
  description = "ami"

}

variable "type" {
  type        = string
  description = "type"
}

variable "webserver_allowports" {
  type        = list(string)
  description = "webserver_ports"
}

variable "mydomain_name" {
  type        = string
  description = "domain_name"

}
variable "myhostname" {
  type        = string
  description = "myhost_name"

}

