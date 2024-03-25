#create application load banlancer

resource "aws_alb" "cmc_alb" {
  name = "${var.project_name}-cmc-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [ var.alb_security_group_ids ]
  subnets = [ var.public_subnet_az1_id, var.public_subnet_az2_id ]
  enable_deletion_protection = false

  tags = {
    Name = "${var.project_name}-cmc-alb"
  }
}

#create tagert group

resource "aws_alb_target_group" "cmc_alb_tgroup" {
    name = "${var.project_name}-tg"
    target_type = "ip"
    port = 80
    protocol = "HTTP"
    vpc_id = var.cidr_block_id

    health_check {
      enabled = true
      interval = 300
      path = "/"
      timeout = 60
      matcher = 200
      healthy_threshold = 5
      unhealthy_threshold = 5
    }

    lifecycle {
      create_before_destroy = true
    }
}

#create a listener on port 80 with redirect action

resource "aws_alb_listener" "cmc_alb_http_listener" {
  load_balancer_arn = aws_alb.cmc_alb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port = 443
      protocol = "HTTPS"
      status_code = "HTTP_301"
      
    }
  }
}

#create a listener on port 443 with forworad acction

resource "aws_alb_listener" "cmc_alb_https_listener" {
  load_balancer_arn = aws_alb.cmc_alb.arn
  port = "443"
  protocol = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn = var.certificate_arn
  default_action {
    type = "foward"
    target_group_arn = aws_alb_target_group.cmc_alb_tgroup.arn
  }
}
