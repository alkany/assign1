
resource "aws_lightsail_instance" "lightsail1" {
  name              = var.myinstancename
  availability_zone = "us-east-1f"
  blueprint_id      = "centos_7"
  bundle_id         = "nano_2_0"
  user_data         = <<-EOF
                      #!/bin/bash
                      sudo yum update -y
                      sudo yum install unzip wget httpd -y
                      sudo wget https://github.com/utrains/static-resume/archive/refs/heads/main.zip
                      sudo unzip main.zip
                      sudo cp -r static-resume-main/* /var/www/html/
                      sudo systemctl start httpd
                      sudo systemctl enable httpd
                      EOF
}

output "public_ip" {
  value       = aws_lightsail_instance.lightsail1.public_ip_address
  description = "The public IP address of the Lightsail instance"
}
