resource "aws_network_interface" "dev_jenkins" {
  subnet_id   = aws_subnet.subnet.id

    tags = {
      Name = "${var.Env}_jen_dev"
      Env = var.Env
      Role = "jenkins"
    }
}

# eni for k8 ec2

resource "aws_network_interface" "kubernetes" {
  subnet_id   = aws_subnet.subnet.id

    tags = {
      Name = "${var.Env}_kubernetes"
      Env = var.Env
      Role = "kubernetes"
    }
}
