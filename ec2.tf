# create a key pair

resource "aws_key_pair" "jenkins-web-server" {
  key_name   = "jenkins-server"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 dramane.hie@.com"
}

# create my EC2 with user data

resource "aws_instance" "web-server-instance" {
  ami= "ami-05e8e219ac7e82eba"
  instance_type = var.instance_type
  key_name = "${aws_key_pair.jenkins-web-server.key_name}"
  user_data = "${file("script.sh")}"
    tags = {
      Name = "web-server"
      Batch = "5AM"
  }
}