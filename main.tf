# configured aws provider with proper credentials
provider "aws" {
  region  = "ap-south-1"
  access_key = "AKIATMW4RMT4OXB5SNK7"
  secret_key = "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"
}


# create default vpc if one does not exit
resource "aws_default_vpc" "default_vpc" {

  tags = {
    Name = "default vpc"
  }
}


# use data source to get all avalablility zones in region
data "aws_availability_zones" "available_zones" {}


# create default subnet if one does not exit
resource "aws_default_subnet" "default_az1" {
  availability_zone = data.aws_availability_zones.available_zones.names[0]

  tags = {
    Name = "default subnet"
  }
}


# create security group for the ec2 instance
resource "aws_security_group" "ec2_security_group" {
  name        = "docker server sg"
  description = "allow access on ports 80 and 22"
  vpc_id      = aws_default_vpc.default_vpc.id

  ingress {
    description = "http access"
    from_port   = 85
    to_port     = 85
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "docker server sg"
  }
}


# use data source to get a registered amazon linux 2 ami
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}


# launch the ec2 instance
resource "aws_instance" "ec2_instance" {
  ami                    = "ami-09ba48996007c8b50"
  instance_type          = "t2.micro"
  subnet_id              = aws_default_subnet.default_az1.id
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]
  key_name               = "kyros"

  tags = {
    Name = "docker server"
  }
}


# an empty resource block
resource "null_resource" "name" {

  # ssh into the ec2 instance 
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("C:/Users/delll/Downloads/kyros.pem")
    host        = aws_instance.ec2_instance.public_ip
  }


  # copy the build_docker_image.sh from your computer to the ec2 instance 
  provisioner "file" {
    source      = "web.sh"
    destination = "/home/ec2-user/web.sh"
  }

  # set permissions and run the build_docker_image.sh file
  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /home/ec2-user/web.sh",
      "sh /home/ec2-user/web.sh",
    ]
  }

  # wait for ec2 to be created
  depends_on = [aws_instance.ec2_instance]

}


# print the url of the container server
output "container_url" {
  value = join("", ["http://", aws_instance.ec2_instance.public_dns])
}
