#creating key_pair
resource "aws_key_pair" "ssh_key" {
  key_name   = "ssh-dev"
  public_key = file("project_key.pub")
  tags = {
    name = "${var.projectname}-${var.project_env}"
  }
}
