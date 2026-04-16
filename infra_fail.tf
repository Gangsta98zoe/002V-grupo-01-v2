# 1. Error de Instancia: Usamos t3.medium en lugar de t2.micro
resource "aws_instance" "servidor_no_permitido" {
  ami           = "ami-0e2c8ca47bde19811"
  instance_type = "t3.medium" 
  tags          = { Name = "002V-test-error-instancia" }
}

# 2. Error de Red: Abrimos un puerto distinto o mantenemos el 22 al mundo
resource "aws_security_group" "sg_inseguro" {
  name   = "002V-sg-inseguro"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Esto debería activar la alerta de OPA
  }
}
