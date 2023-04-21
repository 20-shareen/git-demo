resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/24"
    tenancy = "default"
    enable_dns_hostnames = true
    assign_generated_ipv6_cidr_block = true
    Name = "newVPC"
}

resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_vpc.vpc.id
    Name = "newIG"
}

resource "aws_subnets" "public_subnets" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.0.0/24"
    Name = "newsubnet"
    availability_zone = "us-east-1a"
}

resource "aws_route_table" "route_table" {
    Name = "newroute"
    vpc_id = aws_vpc.vpc.id
    route = {
        cidr_block = "0.0.0.0/0"
        internet_gateway_id = aws_internet_gateway.internet_gateway
    }
}
resource "aws_route_table_association" "public_subnet_route_table_association" {
    subnet_id = aws_subnet.public_subnet_id
    route_table_id = aws_route_table.public_route_table.id
}

resource "aws_subnets" "private_subnets" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.2.0/20"
    availability_zone = "us-east-1a"
    Name = "newprivatesubnet"
}

resource "aws_load_balancer" "load_balancer" {
    vpc_id = aws_vpc.vpc.id 
    availability_zone = "us-east-1a"
    instance_id = aws_instance.instance.i
    Name = "newlb" 
}

resource "aws_instance" "EC2_instance" {
    Name = "ansible-instance"
    vpc_id = aws_vpc_id.vpc_id
    instance_type = "t2.micro"
    security_group = "default"
    region = "us-east-1"
    assign_public_ip = True
    image_id = aws_image_id.image.id
}







