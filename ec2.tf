# create a key pair

resource "aws_key_pair" "jenkins-web-servers" {
  key_name   = "jenkins-serveur"
  public_key = file("/Users/dramzy/.ssh/dmz-aws.pub")
}

# create my EC2 with user data



resource "aws_instance" "web-server-instance" {
  ami= "ami-05e8e219ac7e82eba"
  instance_type = var.instance_type
  key_name = aws_key_pair.jenkins-web-servers.key_name
  user_data = file("script.sh")
    tags = {
      Name = "web-servers"
      Batch = "5AM"
  }
  depends_on = [
  aws_key_pair.jenkins-web-servers
]
}