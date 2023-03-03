# configured aws provider with proper credentials
provider "aws" {
    region = "ap-south-1"
    access_key = "AKIATMW4RMT4OXB5SNK7"
    secret_key = "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"
}

resource "aws_vpc" "terra-vpc" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    tags = {
        Name = "terra"
    }
}

resource "aws_subnet" "terra_subnet" {
    vpc_id = aws_vpc.terra-vpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "ap-south-1a"
    tags = {
        Name = "terra-pub-subnet"
    } 
}

resource "aws_security_group" "terra_sg" {
    name        = "terra-sg"
    description = "Allow TLS inbound traffic"
    vpc_id      = aws_vpc.terra-vpc.id
  
    ingress {
      description      = "TLS from VPC"
      from_port        = 85
      to_port          = 85
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  
    egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  
    tags = {
      Name = "terra-sg"
    }
}

resource "aws_instance" "ec2_terra" {
    ami = "ami-09ba48996007c8b50"
    instance_type = "t2.micro"
    availability_zone = "ap-south-1a"
    key_name = "-----BEGIN RSA PRIVATE KEY-----
MIIEpQIBAAKCAQEAqj/kS+L161IETKOEpIWQGqk37cJz5s6XMNwEm8oZIgKz+Rhp
/gbQOrQ0eb13YNXFWqC0AnlewuZ+uMTMpxo1vqhwyufPd7xOp5ykKh8d6Sfho3Ic
2eQwNxIIuTYAwqi2OYLJOy7JEjRxqvh9lGymEqBREiNsZl1M/SDHMVuOJ6/ue/cz
Coa7n0HXkQ7NUhgoYldWbY0vHYmn1tS3XpxTANP2Xbvp3edrtaNoXfRntreq0TSN
SXSm8tWEtxIDT2z1ySCVk1EPirwqkyHy5n1xKkpFPyll1P99pG3AjjUpchqz7AKZ
58qULQUipBcpA6+aROW/cOfk6CyKHBDzlpXwWQIDAQABAoIBAGjF4S2Cg21KkDLJ
/vtw5vpBYZYEsWc9hHYhMQTfHxB7MV7+01vtvYAjHpg9LZZ+eHIJrD5JizPOvfXf
x0KfMqwe5Ss59cfuL0mfcLgrZjDyxj3cID1H3RRHGO9CeL1TLrG99zFg3YVCmSFq
w33wT1PvLXVIL5HfoV22KmAJxDZPYG1vkM6R5S2JOJEO1FSHVDR28kZvzDM07h5x
eFpQkMxCNEbCmJRrMmB+/6VjrI0n4vv51Zr/0AFEurTF7czz54yg45dr9kWTsJtj
fG7u6JiwzG8tGqnVUJLbcEIAZaW3j3ejQrVTqdDY1xK7OfVief/RLd0Z3pqOCizN
INv2qMECgYEA6sltTxG09VYXpzGcWRbnJL6uUZHnDGa//imIzmWHO6tOO7Ocoxd3
aJKkNZDEELOPKG4IsQiD53NHfrbGmnGia6aZ9hcR+KmMLrL/Vgl5caxxXjKqcrpI
SQpGiVlCBhHgRua9F7Vvqi4FbIgC3S6Wr91lyAdX5b8/2sJwvx6yB9UCgYEAuaG7
IaeBfssRA8zacI3I8F7CVw9HD7qqRfOtnZf2bTICVhduHUUbJMEJTW6xvJbrxv10
669f7xilvLfa3jkBBZL435DdiHYiQoOqucqwUWZg9NxZG6HjZJY3v+s9lO29h023
FdTh1otvebYZ9CJNpy8xEkJ9duSZEs6mPLAA7HUCgYEAorpvL6FXKb+87x3cfob4
N6iNi22zlQ3WPiOtdVg7LakitRBdHVDTa0BP3exzaBv7ugrhrUn4mj91KyclacAe
0bwL89uzkgR5a5iWjpxMdvQNMzuslY31MeKUVvftYeWb66hbIQaY2XvCOKHgUkrL
GCM8OzKTwmIWsNmZaW2t+O0CgYEAkPAITlSdNUSUOmVeQPdTZup1zsfs8gkLHacP
bbbS/5tGW7Xbkhr9AIuAGedN+zPTUAFhowvBWcvizCC5UT0s4Q9KJjTT49JpGYn4
aSwq0sOe/FB3eq3CAC2RxdWEtZ2Sl+xEAVXAJ2WjWmKmjQmjm9+q7tjfYU9HfXnA
Li416mkCgYEA2Z9BjeXWK5Eb8eIHWgWbnGleemdMjO/UkGc7jTKSg8gktZP/cl8d
fugm3IN3GSR3tfDW5llqhFWmksYEUtn3ZKpYOhwxaYHmPu6R2glhm51Zsj3Rqe9R
/MHdyHS43vrjReGcdtmDv3d7YynJ6RYbYwOJQqKaqMUYkkZHJ4YE4WM=
-----END RSA PRIVATE KEY-----"
    subnet_id              = aws_subnet.terra_subnet.id
    vpc_security_group_ids = [aws_security_group.terra_sg.id]
    tags = {
        Name = "terra-server"
    }
    
 provisioner "file" {
    source = "web.sh"
    destination = "/home/ec2-user/web.sh"
 }

 provisioner "remote-exec"{

    inline = [
        "sudo chmod +x /home/ec2-user/web.sh",
        "sh /home/ec2-user/web.sh",
    ]
 }
 
 connection {
    user = "ec2-user"
    private_key = file("C:/Users/delll/Downloads/terrakey.pem")
    host = aws_instance.ec2_terra.public_ip
 }
}

# print the url of the container server
output "container_url" {
  value = join("", ["http://", aws_instance.ec2_terra.public_dns])
}
