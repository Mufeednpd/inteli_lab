resource "aws_network_interface" "dev_jenkins" {
  subnet_id   = aws_subnet.subnet.id

    tags = {
      Name = "${var.Env}_jenagent"
      Env = var.Env
      Role = "jenkins"
    }
}

# eni for k8worker nodes

resource "aws_network_interface" "kubeworker" {
  count = 2
  subnet_id   = aws_subnet.subnet.id

    tags = {
      Name = "${var.Env}_kubeworker${count.index+1}"
      Env = var.Env
      Role = "kubeworker"
    }
}

resource "aws_instance" "dev_jenkins" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  key_name      = "newkey"

  network_interface {
    network_interface_id = aws_network_interface.jenkins.id
    device_index         = 0
  }

    tags = {
      Name = "${var.Env}_jenagent"
      Env = var.Env
      Role = "jenkins"
    }
}



# ec2 instace for k8 worker nodes

resource "aws_instance" "kubeorker" {
  count = 2
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  key_name      = "newkey"

  network_interface {
    network_interface_id = aws_network_interface.kubeworker[count.index].id
    device_index         = 0
  }

    tags = {
      Name = "${var.Env}_kubeworker${count.index+1}"
      Env = var.Env
      Role = "kubeworker"
    }
}

# query eni for k8worker nodes to get public ip
data "aws_network_interface" "kubeworker" {
  count = 2
  id = aws_network_interface.kubeworker[count.index].id
}


# query eni for Jenkins to get public ip
data "aws_network_interface" "jenkins" {
  id = aws_network_interface.jenkins.id
}
