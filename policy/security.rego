package terraform
import input as tfplan

# Política 1: No permitir SSH público (0.0.0.0/0) [cite: 81]
deny[msg] {
    input.resource_changes[_].change.after.ingress[_].cidr_blocks[_] == "0.0.0.0/0"
    msg := "ERROR: Seguridad fallida. No se permite SSH abierto al mundo."
}

# Política 2: Solo permitir t2.micro [cite: 82]
deny[msg] {
    input.resource_changes[_].change.after.instance_type != "t2.micro"
    msg := "ERROR: Configuración fallida. Solo se permite instancia tipo t2.micro."
}
