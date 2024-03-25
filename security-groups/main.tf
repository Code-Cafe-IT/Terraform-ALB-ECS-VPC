resource "aws_security_group" "alb_security_group" {
  vpc_id = var.cidr_block_ids
  description = "allow http, https"
  name = "alb security groups"

  ingress {
    from_port = 80
    to_port = 80
    cidr_blocks = [ "0.0.0.0/0" ]
    protocol = "tcp"

  }
  ingress {
    from_port = 443
    to_port = 443
    cidr_blocks = [ "0.0.0.0/0" ]
    protocol = "tcp"

  }
  egress {
    from_port = 0
    to_port = 0
    cidr_blocks = [ "0.0.0.0/0" ]
    protocol = -1
  }
}

resource "aws_security_group" "ecs_security_groups" {
  vpc_id = var.cidr_block_ids
  name = "ecs security groups"
  description = "allow http https "

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [ aws_security_group.alb_security_group.id ]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [ aws_security_group.alb_security_group.id ]
  }
  egress {
    from_port = 0
    to_port = 0
    cidr_blocks = [ "0.0.0.0/0" ]
    protocol = -1
  }
  
}
