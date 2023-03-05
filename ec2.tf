# data "aws_ami" "my_ami" {
#   most_recent = true
#   name_regex       = "^DevOpsClass-B25"
#   owners = ["721834156908","009412611595"]
# }

#Docker Swarm Master/Manager Servers
resource "aws_instance" "master-1" {
  #ami                         = data.aws_ami.my_ami.id
  ami = var.imagename
  availability_zone           = "us-east-1a"
  instance_type               = "t2.small"
  key_name                    = "dockey"
  subnet_id                   = aws_subnet.subnet1-public.id
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name       = "swarm-master-1"
    Env        = "Prod"
    Owner      = "Sree"
    CostCenter = "ABCD"
  }
}

resource "aws_instance" "master-2" {
  #ami                         = data.aws_ami.my_ami.id
    ami = var.imagename
  availability_zone           = "us-east-1a"
  instance_type               = "t2.small"
  key_name                    = "dockey"
  subnet_id                   = aws_subnet.subnet1-public.id
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name       = "swarm-master-2"
    Env        = "Prod"
    Owner      = "Sree"
    CostCenter = "ABCD"
  }
}

resource "aws_instance" "master-3" {
  #ami                         = data.aws_ami.my_ami.id
    ami = var.imagename
  availability_zone           = "us-east-1a"
  instance_type               = "t2.small"
  key_name                    = "dockey"
  subnet_id                   = aws_subnet.subnet1-public.id
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name       = "swarm-master-3"
    Env        = "Prod"
    Owner      = "Sree"
    CostCenter = "ABCD"
  }
}

#Docker Swarm Worker Servers
resource "aws_instance" "worker-1" {
  #ami                         = data.aws_ami.my_ami.id
    ami = var.imagename
  availability_zone           = "us-east-1a"
  instance_type               = "t2.small"
  key_name                    = "dockey"
  subnet_id                   = aws_subnet.subnet1-public.id
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name       = "swarm-worker-1"
    Env        = "Prod"
    Owner      = "Sree"
    CostCenter = "ABCD"
  }
}

resource "aws_instance" "worker-2" {
  #ami                         = data.aws_ami.my_ami.id
  ami = var.imagename
  availability_zone           = "us-east-1a"
  instance_type               = "t2.small"
  key_name                    = "dockey"
  subnet_id                   = aws_subnet.subnet1-public.id
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name       = "swarm-worker-2"
    Env        = "Prod"
    Owner      = "Sree"
    CostCenter = "ABCD"
  }
}

 resource "aws_instance" "worker-3" {
   #ami                         = data.aws_ami.my_ami.id
     ami = var.imagename
   availability_zone           = "us-east-1a"
   instance_type               = "t2.small"
   key_name                    = "dockey"
   subnet_id                   = aws_subnet.subnet1-public.id
   vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
   associate_public_ip_address = true
   tags = {
     Name       = "swarm-worker-3"
     Env        = "Prod"
     Owner      = "Sree"
     CostCenter = "ABCD"
   }
 }

# resource "aws_instance" "worker-4" {
#   #ami                         = data.aws_ami.my_ami.id
#     ami = var.imagename
#   availability_zone           = "us-east-1a"
#   instance_type               = "t2.small"
#   key_name                    = "dockey"
#   subnet_id                   = aws_subnet.subnet1-public.id
#   vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
#   associate_public_ip_address = true
#   tags = {
#     Name       = "swarm-worker-4"
#     Env        = "Prod"
#     Owner      = "Sree"
#     CostCenter = "ABCD"
#   }
# }

# resource "aws_instance" "worker-5" {
#   #ami                         = data.aws_ami.my_ami.id
#     ami = var.imagename
#   availability_zone           = "us-east-1a"
#   instance_type               = "t2.small"
#   key_name                    = "dockey"
#   subnet_id                   = aws_subnet.subnet1-public.id
#   vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
#   associate_public_ip_address = true
#   tags = {
#     Name       = "swarm-worker-5"
#     Env        = "Prod"
#     Owner      = "Sree"
#     CostCenter = "ABCD"
#   }
# }

