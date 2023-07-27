resource "aws_lb" "nf-load-balancer" {
  name                              = "Webserver-alb"
  internal                          = false
  load_balancer_type                = "application"
  security_groups                   = [aws_security_group.nf-alb-sg.id]
  subnets                           = [aws_subnet.nf_publicsubnet1.id, aws_subnet.nf_publicsubnet2.id]
  enable_deletion_protection        = false
    tags = {
        Environment                 = "production"
  }
}
resource "aws_lb_target_group" "target-group" {
  name                              = "CPUtest-tg"
  port                              = 80
  protocol                          = "HTTP"
  vpc_id                            = aws_vpc.nf_vpc.id
}
resource "aws_lb_listener" "listener" {
  load_balancer_arn                 = aws_lb.nf-load-balancer.arn
  port                              = "80"
  protocol                          = "HTTP"
  default_action {
    type                            = "forward"
    target_group_arn                = aws_lb_target_group.target-group.arn
  }
}
resource "aws_security_group" "nf-alb-sg"{
        vpc_id                      = aws_vpc.nf_vpc.id
        name                        = "alb-sg"
        tags = {
            Name = "alb-sg"
        }
    }
    resource "aws_security_group_rule" "alb-sg-http-in"{
        from_port                   = 80
        protocol                    = "tcp"
        security_group_id           = aws_security_group.nf-alb-sg.id
        to_port                     = 80
        type                        = "ingress"
        cidr_blocks                 = ["0.0.0.0/0"]
    }
    resource "aws_security_group_rule" "alb-sg-tcp-out"{
        from_port                   = 0
        protocol                    = "all"
        security_group_id           = aws_security_group.nf-alb-sg.id
        to_port                     = 65535
        type                        = "egress"
        cidr_blocks                 = ["0.0.0.0/0"]
    }