resource "aws_instance" "myec21" {
  ami           = var.var1
  instance_type = var.var2
  key_name      = "nexus"
  subnet_id     = aws_subnet.myvpc-subnet-public-1.id
  vpc_security_group_ids = [aws_security_group.myvpc-sg.id]

  user_data = <<-EOF
  #!/bin/bash
  sudo apt-get update -y
  sudo apt update
  sudo apt install snapd
  sudo snap install trivy
  sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
  echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
  sudo apt-get update -y
  sudo apt-get install -y fontconfig openjdk-17-jre jenkins
  sudo systemctl start jenkins
  sudo systemctl enable jenkins
  EOF

  root_block_device {
    volume_size = var.var3
    volume_type = "gp2"
  }
  tags ={
    name = "myec21"
  }
}


resource "aws_instance" "myec22" {
  ami           = var.var1
  instance_type = var.var2
  key_name      = "nexus"
  subnet_id     = aws_subnet.myvpc-subnet-public-2.id
  vpc_security_group_ids = [aws_security_group.myvpc-sg.id]

  user_data = <<-EOF
  #!/bin/bash
  sudo apt-get update -y
  sudo apt-get install -y maven
  sudo wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.93/bin/apache-tomcat-9.0.93.tar.gz
  sudo tar -xvzf apache-tomcat-9.0.93.tar.gz -C /opt/
  EOF

  root_block_device {
    volume_size = var.var3
    volume_type = "gp2"
  }
  tags ={
    name="myec22"
  }
}

resource "aws_instance" "myec23" {
  ami           = var.var1
  instance_type = var.var2
  key_name      = "nexus"
  subnet_id     = aws_subnet.myvpc-subnet-public-2.id
  vpc_security_group_ids = [aws_security_group.myvpc-sg.id]

  user_data = <<-EOF
  #!/bin/bash
  sudo apt-get update -y
  sudo apt-get install -y maven
  sudo wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.93/bin/apache-tomcat-9.0.93.tar.gz
  sudo tar -xvzf apache-tomcat-9.0.93.tar.gz -C /opt/

  EOF

  root_block_device {
    volume_size = var.var3
    volume_type = "gp2"
  }
  tags ={
    name="myec23"
  }
}