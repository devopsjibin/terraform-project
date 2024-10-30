#creating key_pair
resource "aws_key_pair" "ssh_key" {
  key_name   = "ssh-dev"
  public_key = file("project_key.pub")
  tags = {
    name = "${var.projectname}-${var.project_env}"
  }
}

#creating security group mywebserver-sg
resource "aws_security_group" "mywebserver_sg" {
  name        = "allow_mywebserver-sg"
  description = "Allow traffic for webserver"
  vpc_id      = var.myvpc
  tags = {
    name = "${var.projectname}-${var.project_env}-sg"
  } 
}

#adding ingress rule for mywebserversg
resource "aws_vpc_security_group_ingress_rule" "webserver_ingress_rule" {
  for_each          = toset(var.webserver_allowports)
  security_group_id = aws_security_group.mywebserver_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = each.key
  to_port           = each.key
  ip_protocol       = "tcp"
}

#adding egress rule for mywebserversg
resource "aws_vpc_security_group_egress_rule" "webserver_egress_rule" {
  security_group_id = aws_security_group.mywebserver_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
