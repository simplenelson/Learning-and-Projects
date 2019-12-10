provider "aws" {
    region = "us-east-1"
    access_key = ""
    secret_key = ""
}


data "aws_ami" "amazon_linux" {
    most_recent = true
    owners = ["amazon"]

    filter {
        name = "owner-alias"
        values = ["amazon"]
    }
    filter {
        name = "name"
        values = ["amzn2-ami-hvm*"]
    }
}

resource "aws_security_group" "websg" {
    name = "websg"
    description = "Allow web traffic"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "webserver" {
    ami = "${data.aws_ami.amazon_linux.id}"
    instance_type = "t2.micro"
    key_name = "Ubuntu"
    user_data = "${file("install_httpd.sh")}"
    security_groups = ["websg"]
    

    tags = {
        Name = "WebServer"
    }
    

}

resource "aws_instance" "webserver2" {
    ami = "${data.aws_ami.amazon_linux.id}"
    instance_type = "t2.micro"
    key_name = "Ubuntu"
    user_data = "${file("install_httpd.sh")}"
    security_groups = ["websg"]


    tags = {
        Name = "WebServer2"
    }
    

}