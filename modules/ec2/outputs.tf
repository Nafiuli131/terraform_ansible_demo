output "instance_public_ip" {
  value = aws_eip.web_eip.public_ip
}
output "instance_private_ip" {
  value = aws_instance.web.private_ip
}
output "instance_id" {
  value = aws_instance.web.id
}
