provider "aws" {
  region = "us-east-1"
  
}

//Creating a VPC
resource "aws_vpc" "dani-vpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
      Name = "production"
    }
}


//Creating internet gateway if want to connect to the internet
resource "aws_internet_gateway" "dani-gateway" {
  vpc_id = aws_vpc.dani-vpc.id

}

//Now, we will create a route table
resource "aws_route_table" "route-table-production" {
  vpc_id = aws_vpc.dani-vpc.id

//All the traffic from the internet will get to this gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dani-gateway.id
  }

//Only outbound traffic from here
  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.dani-gateway.id
  }

  tags = {
    Name = "production"
  }
}

//Creating a subnet to contain our EC2 instance
resource "aws_subnet" "subnet1" {
    vpc_id = aws_vpc.dani-vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tags ={
        Name = "production-subnet"
    }
  
}

//Associating subnet with route table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.route-table-production.id
}

//Security Group (port 22,80,443), and you can comment out what ever you need(Inbound, Outbound rules)
resource "aws_security_group" "allow_web" {
  name        = "allow_web_traffic"
  description = "Allow inbound traffic"
  vpc_id = aws_vpc.dani-vpc.id


  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    //You can add whatever cidr block you want
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    //-1 means any protocol is working 
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-web-traffic"
  }
}

//Network Interface
resource "aws_network_interface" "nic" {
  subnet_id       = aws_subnet.subnet1.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.allow_web.id]

  
}

//Elastic IP
resource "aws_eip" "one" {
  vpc                       = true
  network_interface         = aws_network_interface.nic.id
  associate_with_private_ip = "10.0.1.50"
  depends_on = [aws_internet_gateway.dani-gateway]
}

//Ubuntu Server 
resource "aws_instance" "server-instance" {
  ami = "ami-0885b1f6bd170450c"
  instance_type = "t2.xlarge"
  availability_zone = "us-east-1a"
  key_name = "main-key"

  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.nic.id


  }
}
