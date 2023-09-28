resource "aws_instance" "test-server" {
  ami           = "ami-053b0d53c279acc90" 
  access_key = "AKIAZTHNJIIF4MLQY2RD"
  secret_key = "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"
  instance_type = "t2.micro" 
  key_name = "AWS-EC2-Key"
  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("./AWS-EC2-Key.pem")
    host     = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [ "echo 'wait to start instance' "]
  }
  tags = {
    Name = "test-server"
  }
  provisioner "local-exec" {
        command = " echo ${aws_instance.test-server.public_ip} > inventory "
  }
   provisioner "local-exec" {
  command = "ansible-playbook /var/lib/jenkins/workspace/Banking/my-serverfiles/finance-playbook.yml "
  } 
}
