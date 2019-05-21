resource "aws_launch_configuration" "webserver_launch_config" {
  image_id = "ami-0ac019f4fcb7cb7e6"
  instance_type = "${var.instance_type}"
  security_groups = ["${aws_security_group.webserver_sg.id}"]
  key_name = "${aws_key_pair.ec2_key.key_name}"
  user_data = <<-EOF
              #!/bin/bash
              set -e
              sudo apt-get update
              sudo apt-get install -y python3 python-pip virtualenv git
              git clone  https://github.com/pavangade17/pavankumar_Challenge.git
              cd pavankumar_Challenge
              virtualenv venv --python=/usr/bin/python3 && source venv/bin/activate
              pip install -r requirements.txt
              cd ansible && ansible-playbook default.yml -e 'ansible_python_interpreter=/usr/bin/python3 -i hosts'
              EOF

  lifecycle {
    create_before_destroy = true
  }
}
