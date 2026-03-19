output "instance_public_ip" {
  description = "Public IP of the 3CX Server"
  value       = aws_instance.telephony_server.public_ip
}
