object jugueteria {
    const juguetes = []  // Lista de juguetes en el carrito

    method agregarACompras(jueguete) {
        juguetes.add(jueguete)
    }

    method precioTotal() = juguetes.sum({juguete => juguete.precioFinal()}) // Sumatoria de todos los precios finales

}

class Juguete {
    const paisDeOrigen
    const tipoDeEdad

    method precioBase()

    method precioEstandar() = self.precioBase() * paisDeOrigen.recargoDelPais() // El precio final con el agregado del pais

    method preicoFinal() = tipoDeEdad.precioFinal(self.precioEstandar()) // El precio final con el agregado de la edad
}

class Pais {
    const property recargoDelPais // Porcentaje del valor agregado (ej: 1.25, recargo del 25%)
}

class Didactico inherits Juguete {
    const precioBase // Precio dado cuando se instancia la clase

    override method precioBase() = precioBase
}

class Peluche inherits Juguete{
    const tamanio

    override method precioBase() = tamanio * 10
}

object primeraInfancia {
    const agregado = 1.10 // Extra del 10% al precio final

    method precioFinal(precioEstandar) = precioEstandar * agregado
}

class EdadChicos {
    var tienePublicidad
    const agregado = 1.30 // Extra del 30% al precio final

    method precioFinal(precioEstandar) = if(tienePublicidad) (precioEstandar * agregado) else precioEstandar // aumento el precio final si tiene publicidad
}