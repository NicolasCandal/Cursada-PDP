class Tripulante {
    var rolActual = libre

    var edad

    var fuerza
    method fuerza() = fuerza

    var property conocimiento

    method fuerzaMayorA(numero) = fuerza > numero

    method mayorDeEdad() = edad >= 18

    method prestigio() = rolActual.nivelPrestigio()

    method cambiarRol(otroRol) {
        if(otroRol.posibleCambiar(self)){
           rolActual = otroRol
        } else {
            throw new Exception(message = "No cumple las condiciones para cambio de rol")
        }
    }
}

object libre {

    const property nivelPrestigio = 0

    method posibleCambiar(tripulante) = true

}

object obrero {

    const property nivelPrestigio = 50

    method posibleCambiar(tripulante) = tripulante.mayorDeEdad() and tripulante.fuerzaMayorA(50)

}

class MrFusion {
    const property nivelPrestigio = 100

    method altoConocimiento(tripulante) = tripulante.conocimiento() > estacionEspacial.conocimientoPromedio() * 1.21

    method posibleCambiar(tripulante) = tripulante.mayorDeEdad() and self.altoConocimiento(tripulante)
    
}

object capitan inherits MrFusion {

    override method posibleCambiar(tripulante) = super(tripulante) and tripulante.fuerzaMayorA(73)

}

object estacionEspacial {
    var conocimientoPromedio = 50
    method conocimientoPromedio() = conocimientoPromedio
}