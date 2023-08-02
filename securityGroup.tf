# Security Groups
resource "aws_security_group" "nf_sg_bastion"{
    vpc_id = aws_vpc.nf_vpc.id
    name = "nf_securityGrouplatest"
    tags = {
        Name = "nf_sg_bastion"
    }     
}

# Ingress Security Port 80 (Inbound)
resource "aws_security_group_rule" "nf_ingress_http"{
    from_port = 22
    protocol = "tcp"
    security_group_id = aws_security_group.nf_sg_bastion.id
    to_port= 22
    type = "ingress"
    cidr_blocks = ["0.0.0.0/0"] # <Specify the CIDR> instead of allowing it to public
}

# Allow Access All (Outbound)
resource "aws_security_group_rule" "nf_outbound_all"{
    from_port = 22
    protocol = "tcp"
    security_group_id = aws_security_group.nf_sg_bastion.id
    to_port= 22
    type = "egress"
    cidr_blocks = ["0.0.0.0/0"]
}
# Security Group for Loadbalancer
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
    resource "aws_security_group_rule" "alb-sg-https-in"{
        from_port                   = 443
        protocol                    = "tcp"
        security_group_id           = aws_security_group.nf-alb-sg.id
        to_port                     = 443
        type                        = "ingress"
        cidr_blocks                 = ["0.0.0.0/0"]
    }
    resource "aws_security_group_rule" "alb-sg-all-out"{
        from_port                   = 0
        protocol                    = "all"
        security_group_id           = aws_security_group.nf-alb-sg.id
        to_port                     = 65535
        type                        = "egress"
        cidr_blocks                 = ["0.0.0.0/0"]
    }
# Autoscaling Security Group
resource "aws_security_group" "nf-autoscaling-sg"{
        vpc_id                      = aws_vpc.nf_vpc.id
        name                        = "autoscaling-sg"
        tags = {
            Name = "autoscaling-sg"
        }
    }
    resource "aws_security_group_rule" "autoscaling-sg-ssh-in"{
        from_port                   = 22
        protocol                    = "tcp"
        security_group_id           = aws_security_group.nf-autoscaling-sg.id
        to_port                     = 22
        type                        = "ingress"
        cidr_blocks                 = ["0.0.0.0/0"]
    }
    resource "aws_security_group_rule" "autoscaling-sg-http-in"{
        from_port                   = 80
        protocol                    = "tcp"
        security_group_id           = aws_security_group.nf-autoscaling-sg.id
        to_port                     = 80
        type                        = "ingress"
        cidr_blocks                 = ["0.0.0.0/0"]
    }
    resource "aws_security_group_rule" "autoscaling-sg-mysql-in"{
        from_port                   = 3306
        protocol                    = "tcp"
        security_group_id           = aws_security_group.nf-autoscaling-sg.id
        to_port                     = 3306
        type                        = "ingress"
        source_security_group_id    = aws_security_group.nf-mysqldb-sg.id
    }

    resource "aws_security_group_rule" "autoscaling-sg-all-out"{
        from_port                   = 0
        protocol                    = "all"
        security_group_id           = aws_security_group.nf-autoscaling-sg.id
        to_port                     = 65535
        type                        = "egress"
        cidr_blocks                 = ["0.0.0.0/0"]
    }
resource "aws_security_group" "nf-mysqldb-sg"{
        vpc_id                      = aws_vpc.nf_vpc.id
        name                        = "nf-mysqldb-sg"
        tags = {
            Name = "nf-mysqldb-sg"
        }
    }
    resource "aws_security_group_rule" "mysql-sg-bastion-in"{
        from_port                   = 3306
        protocol                    = "tcp"
        security_group_id           = aws_security_group.nf-mysqldb-sg.id
        to_port                     = 3306
        type                        = "ingress"
        source_security_group_id    = aws_security_group.nf_sg_bastion.id
    }
    resource "aws_security_group_rule" "mysql-sg-autoscaling-in"{
        from_port                   = 3306
        protocol                    = "tcp"
        security_group_id           = aws_security_group.nf-mysqldb-sg.id
        to_port                     = 3306
        type                        = "ingress"
        source_security_group_id    = aws_security_group.nf-autoscaling-sg.id
    }
    resource "aws_security_group_rule" "mysql-sg-autoscaling-out"{
        from_port                   = 3306
        protocol                    = "tcp"
        security_group_id           = aws_security_group.nf-mysqldb-sg.id
        to_port                     = 3306
        type                        = "egress"
        source_security_group_id    = aws_security_group.nf-autoscaling-sg.id
    }