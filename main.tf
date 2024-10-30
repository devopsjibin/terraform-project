#creating key_pair
resource "aws_key_pair" "ssh_key" {
  key_name   = "ssh-dev"
  public_key = file("project_key.pub")
  tags = {
    name = "${var.projectname}-${var.project_env}"
  }
}

#creating security group mywebserver-sg
resource "aws_security_group" "frontend_sg" {
  name        = "frontend-sg"
  description = "Allow traffic for webserver"
  vpc_id      = var.myvpc
  tags = {
    name = "${var.projectname}-${var.project_env}-sg"
  } 
}

#adding ingress rule for mywebserversg
resource "aws_vpc_security_group_ingress_rule" "webserver_ingress_rule" {
  for_each          = toset(var.webserver_allowports)
  security_group_id = aws_security_group.frontend_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = each.key
  to_port           = each.key
  ip_protocol       = "tcp"
}

#adding egress rule for mywebserversg
resource "aws_vpc_security_group_egress_rule" "webserver_egress_rule" {
  security_group_id = aws_security_group.frontend_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

#creating ec2
resource "aws_instance" "mywebserver" {
  ami                         = var.ami
  instance_type               = var.type
  key_name                    = aws_key_pair.ssh_key.key_name
  monitoring                  = false
  vpc_security_group_ids      = [aws_security_group.frontend_sg.id]
  user_data                   = file("user-data.sh")
  user_data_replace_on_change = true
  tags = {
    name = "${var.projectname}-${var.project_env} -webserver"
  }
}
