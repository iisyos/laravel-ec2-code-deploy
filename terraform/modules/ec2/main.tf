resource "aws_iam_instance_profile" "app" {
  name = "${var.app_name}-profile"
  role = aws_iam_role.app.name
}


resource "aws_instance" "app" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.app.id]
  iam_instance_profile   = aws_iam_instance_profile.app.id

  associate_public_ip_address = true
  user_data                   = file("${path.module}/user-data.sh")

  tags = {
    Name = var.app_name
  }
}

resource "aws_ec2_instance_state" "app_state" {
  instance_id = aws_instance.app.id

  state = var.instance_state
}
