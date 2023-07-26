# Capstone Project 
# Date of Creation : 26/07/2023
# Team : DEHAM6

#Create a Virtual private cloud with CIDR 10.0.0.0/16 in the region us-west-2
resource "aws_vpc" "nf_vpc"{
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames=true
    enable_dns_support = true
    tags = {
        Name = "nf_vpc"
    }
     provisioner "local-exec"{
    command = "echo vpc ID=${self.id} >> metadata"
  }
}

# Query all available Availability Zone; we will use specific availability zone using index - The Availability Zones data source
# provides access to the list of AWS availabililty zones which can be accessed by an AWS account specific to region configured in the provider.

data "aws_availability_zones" "nf_vpc_azs"{}

# Public subnet 1
resource "aws_subnet" "nf_publicsubnet1"{
    cidr_block = "10.0.1.0/24" # 256 IPs
    vpc_id = aws_vpc.nf_vpc.id
    map_public_ip_on_launch = true
    availability_zone = data.aws_availability_zones.nf_vpc_azs.names[1]

    tags = {
        Name = "nf_capstone"
    }
}

# Private Subnet 1
resource "aws_subnet" "nf_privatesubnet1"{
    cidr_block = "10.0.2.0/24"
    vpc_id = aws_vpc.nf_vpc.id
    map_public_ip_on_launch = false
    availability_zone = data.aws_availability_zones.nf_vpc_azs.names[1]
    
    tags = {
            Name = "nf_capstone"
    }
}

# Public subnet 2
resource "aws_subnet" "nf_publicsubnet2"{
    cidr_block = "10.0.3.0/24" # 256 IPs
    vpc_id = aws_vpc.nf_vpc.id
    map_public_ip_on_launch = true
    availability_zone = data.aws_availability_zones.nf_vpc_azs.names[2]

    tags = {
        Name = "nf_capstone"
    }
}

# Private Subnet 2
resource "aws_subnet" "nf_privatesubnet2"{
    cidr_block = "10.0.4.0/24"
    vpc_id = aws_vpc.nf_vpc.id
    map_public_ip_on_launch = false
    availability_zone = data.aws_availability_zones.nf_vpc_azs.names[2]
    
    tags = {
            Name = "nf_capstone"
    }
}

# Internet Gateway - to have Internet traffic in public subnets
resource "aws_internet_gateway" "nf_IGW"{
    vpc_id = aws_vpc.nf_vpc.id
    tags = {
        Name = "vpc_igw"
    }
}

# Routing tables

# Provides a resource to create a VPC routing table
resource "aws_route_table" "nf_publicRouteTable1"{
    vpc_id = aws_vpc.nf_vpc.id
    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.nf_IGW.id
    }
    tags = {
        Name = "nf_publicRoute1"
    }
}

# Provides a resource to create an association between a Public Route Table and a Public Subnet
resource "aws_route_table_association" "nf_publicSubnetAssociation1" {
    route_table_id = aws_route_table.nf_publicRouteTable1.id
    subnet_id = aws_subnet.nf_publicsubnet1.id
    depends_on = [aws_route_table.nf_publicRouteTable1, aws_subnet.nf_publicsubnet1]
}

# Provides a resource to create an association between a Public Route Table and a Public Subnet
resource "aws_route_table_association" "nf_publicSubnetAssociation2" {
    route_table_id = aws_route_table.nf_publicRouteTable1.id
    subnet_id = aws_subnet.nf_publicsubnet2.id
    depends_on = [aws_route_table.nf_publicRouteTable1, aws_subnet.nf_publicsubnet2]
}