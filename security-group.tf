# create a security group to allow port 22; 80; 443

resource "aws_security_group" "allow_web" {
  name = "allow_web_traffic"
  description = "allow web inbound traffic"
  vpc_id = aws_vpc.prod-vpc.id


  ingress  {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "HTTPS"
    from_port = 443
    to_port = 443
    protocol = "tcp"
  }
  ingress  {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
  }
 
  ingress  {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "HTTP"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    
  } 
}


