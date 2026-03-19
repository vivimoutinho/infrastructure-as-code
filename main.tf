# Security Group: Cloud-level firewall rules for 3CX Telephony
resource "aws_security_group" "allow_3cx" {
  name        = "allow_3cx_traffic"
  description = "Inbound traffic control for VoIP and Management"
  vpc_id      = aws_vpc.main_vpc.id

  # SIP Signaling: Essential for call initialization (TCP/UDP)
  ingress {
    from_port   = 5060
    to_port     = 5061
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # 3CX Tunnel: Encapsulates VoIP traffic for remote extensions
  ingress {
    from_port   = 5090
    to_port     = 5090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS: Web management console and provisioning
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH: Remote management and Ansible automation access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound: Allow all egress traffic for updates and external SIP trunks
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "3CX-Security-Group"
  }
}

# EC2 Instance: The dedicated host for the 3CX Telephony System
resource "aws_instance" "telephony_server" {
  ami                    = "ami-0c55b159cbfafe1f0" # Ubuntu 22.04 LTS (Update based on region)
  instance_type          = "t3.medium"
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.allow_3cx.id]

  tags = {
    Name        = "3CX-Production-Server"
    Environment = "Production"
    Project     = "Telephony-Migration"
  }
}
