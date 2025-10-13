object bobEsponja {
    var energia = 1000
    method energia() = energia

    var felicidad = 100
    method felicidad() = felicidad

    var dinero = 10000

    method propina() {
        if(energia > 600) {
            return 10 * energia
        }
        else {
            return 100
        }
    }

    method comer() {

        energia += 1000 * felicidad

    }

    const property listoParaTrabajar = true
}

object patricio {
    var masaMuscular = 40

    var dinero = 0
    method dinero() = dinero

    method propina() = dinero

    method comer() {
        masaMuscular += 10
    }

}

object calamardo {
    var horasDeSuenio = 5

    var dinero = 5000

    method comer() {}

    method propina() = 0

    method listoParaTrabajar() = horasDeSuenio.even()
}

object donCangrejo {
    var dinero = 1000000

    method gastarEnPerlita(cantidad) {
        dinero -= cantidad
    }

    method ganarDinero(cantidad) {
        dinero += cantidad
        self.gastarEnPerlita(cantidad/2)
    }
}

object tienda {
  var limpieza = 100

  var empleado = calamardo
  method empleado() = empleado

  const precioBurger = 1000
  
  method abrirPuertas() = limpieza.between(50,95) and empleado.listoParaTrabajar()

  method vender(personaje) {
    donCangrejo.ganarDinero((precioBurger + personaje.propina())* 0.95)
    personaje.comer()
  }
}