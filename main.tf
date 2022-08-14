/*
TODO:
    - Create ACM certificate for *.lotusops.com
    - Target Group
    - Load Balancer
*/

provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_key_pair" "my_key_pair" {
  key_name = "jyothi_key_pair"
  public_key = file(pathexpand("~/.ssh/id_rsa.pub"))
}

resource "aws_instance" "jenkins" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  key_name      = "jyothi_key_pair"
  #security_groups = [aws_security_group.jenkins-master-sg.name]

  user_data = "IyEgL2Jpbi9zaA0KeXVtIHVwZGF0ZSDigJN5DQoNCiNpbnN0YWxsIGRvY2tlcg0KYW1hem9uLWxpbnV4LWV4dHJhcyBpbnN0YWxsIGRvY2tlcg0Kc2VydmljZSBkb2NrZXIgc3RhcnQNCnVzZXJtb2QgLWEgLUcgZG9ja2VyIGVjMi11c2VyDQpjaGtjb25maWcgZG9ja2VyIG9uDQoNCiNpbnN0YWxsIGdpdA0KeXVtIGluc3RhbGwgZ2l0IC15DQoNCiMgaW5zdGFsbCBtYXZlbg0Kd2dldCBodHRwOi8vcmVwb3MuZmVkb3JhcGVvcGxlLm9yZy9yZXBvcy9kY2hlbi9hcGFjaGUtbWF2ZW4vZXBlbC1hcGFjaGUtbWF2ZW4ucmVwbyAtTyAvZXRjL3l1bS5yZXBvcy5kL2VwZWwtYXBhY2hlLW1hdmVuLnJlcG8NCnNlZCAtaSBzL1wkcmVsZWFzZXZlci82L2cgL2V0Yy95dW0ucmVwb3MuZC9lcGVsLWFwYWNoZS1tYXZlbi5yZXBvDQp5dW0gaW5zdGFsbCAteSBhcGFjaGUtbWF2ZW4NCg0KIyBpbnN0YWxsIGplbmtpbnMNCndnZXQgLU8gL2V0Yy95dW0ucmVwb3MuZC9qZW5raW5zLnJlcG8gXA0KaHR0cHM6Ly9wa2cuamVua2lucy5pby9yZWRoYXQtc3RhYmxlL2plbmtpbnMucmVwbw0KDQpycG0gLS1pbXBvcnQgaHR0cHM6Ly9wa2cuamVua2lucy5pby9yZWRoYXQtc3RhYmxlL2plbmtpbnMuaW8ua2V5DQoNCnl1bSB1cGdyYWRlIC15DQoNCmFtYXpvbi1saW51eC1leHRyYXMgaW5zdGFsbCBqYXZhLW9wZW5qZGsxMSAteQ0KDQphbHRlcm5hdGl2ZXMgLS1zZXQgamF2YSAvdXNyL2xpYi9qdm0vamF2YS0xMS1vcGVuamRrLTExLjAuMTMuMC44LTEuYW16bjIuMC4zLng4Nl82NC9iaW4vamF2YQ0KDQp5dW0gaW5zdGFsbCBqZW5raW5zIC15DQoNCnN5c3RlbWN0bCBlbmFibGUgamVua2lucw0KDQpzeXN0ZW1jdGwgc3RhcnQgamVua2lucw0KDQpzbGVlcCAxbQ0KDQpta2RpciAtcCAvdG1wL2plbmtpbnMtcGx1Z2luLW1hbmFnZXINCg0KY2QgL3RtcC9qZW5raW5zLXBsdWdpbi1tYW5hZ2VyDQoNCndnZXQgaHR0cHM6Ly9naXRodWIuY29tL2plbmtpbnNjaS9wbHVnaW4taW5zdGFsbGF0aW9uLW1hbmFnZXItdG9vbC9yZWxlYXNlcy9kb3dubG9hZC8yLjEyLjMvamVua2lucy1wbHVnaW4tbWFuYWdlci0yLjEyLjMuamFyIC1PIGplbmtpbnMtcGx1Z2luLW1hbmFnZXIuamFyDQoNCmNwIC90bXAvcGx1Z2lucy55YW1sIC90bXAvamVua2lucy1wbHVnaW4tbWFuYWdlci9wbHVnaW5zLnlhbWwNCg0KI2phdmEgLWphciAvdG1wL2plbmtpbnMtcGx1Z2luLW1hbmFnZXIvamVua2lucy1wbHVnaW4tbWFuYWdlci0qLmphciAtLXdhciAvdXNyL3NoYXJlL2phdmEvamVua2lucy53YXIgLS1wbHVnaW4tZmlsZSBwbHVnaW5zLnlhbWwgLS1wbHVnaW4tZG93bmxvYWQtZGlyZWN0b3J5IC92YXIvbGliL2plbmtpbnMvcGx1Z2lucy8NCg0KamF2YSAtamFyIGplbmtpbnMtcGx1Z2luLW1hbmFnZXIuamFyIC0td2FyIC91c3Ivc2hhcmUvamF2YS9qZW5raW5zLndhciAtLXBsdWdpbi1maWxlIHBsdWdpbnMueWFtbCAtLXBsdWdpbi1kb3dubG9hZC1kaXJlY3RvcnkgL3Zhci9saWIvamVua2lucy9wbHVnaW5zLw0KDQpjaG93biAtUiBqZW5raW5zOmplbmtpbnMgL3Zhci9saWIvamVua2lucy9wbHVnaW5zLw0KDQpzeXN0ZW1jdGwgcmVzdGFydCBqZW5raW5zDQoNCnVzZXJtb2QgLWEgLUcgZG9ja2VyIGplbmtpbnM="
  
  connection {
    agent = false
    timeout = "1m"
    type = "ssh"
    user = "ec2-user"
    host = aws_instance.jenkins.public_ip
    private_key = file(pathexpand("~/.ssh/id_rsa"))
  }

  provisioner "file" {
    source      = "files/plugins.yaml"
    destination = "/tmp/plugins.yaml"
  }

  /*provisioner "remote-exec" {
    inline = [
      "cd /tmp",
      "sudo wget https://github.com/jenkinsci/plugin-installation-manager-tool/releases/download/2.12.3/jenkins-plugin-manager-2.12.3.jar",
    ]
  }*/

  tags = {
    Name = "jenkins"
  }
}

# aws_security_group.jenkins-master-sg:
# resource "aws_security_group" "jenkins-sg" {
#     description = "Jenkins Master security group"
#     egress      = [
#         {
#             cidr_blocks      = [
#                 "0.0.0.0/0",
#             ]
#             description      = ""
#             from_port        = 0
#             ipv6_cidr_blocks = []
#             prefix_list_ids  = []
#             protocol         = "-1"
#             security_groups  = []
#             self             = false
#             to_port          = 0
#         },
#     ]
#     ingress     = [
#         {
#             cidr_blocks      = [
#                 "0.0.0.0/0",
#             ]
#             description      = ""
#             from_port        = 22
#             ipv6_cidr_blocks = []
#             prefix_list_ids  = []
#             protocol         = "tcp"
#             security_groups  = []
#             self             = false
#             to_port          = 22
#         },
#         {
#             cidr_blocks      = []
#             description      = ""
#             from_port        = 8080
#             ipv6_cidr_blocks = []
#             prefix_list_ids  = []
#             protocol         = "tcp"
#             security_groups  = []             
#             self             = false
#             to_port          = 8080
#         }
#     ]
#     name        = "jenkins-sg"
#     tags = {
#         Name = "jenkins-sg"
#     }
#     tags_all    = {}
#     vpc_id      = var.vpc_id
#     timeouts {}
# }