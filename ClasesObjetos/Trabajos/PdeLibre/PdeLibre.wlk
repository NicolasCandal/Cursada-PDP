class Producto {
    const nombre
    const precioBase
    const iva = 1.21

    method precio() = precioBase * iva

    method nombreDeOferta() = "SUPER OFERTA " + nombre
}

class Mueble inherits Producto {
   override method precio() = super() + 1000
}

class Indumentaria inherits Producto {
    var estaEnTemporada

    override method precio() {
        if(estaEnTemporada){
            return super() * 1.10
        } 
        return super()
    }
}

class Gangas inherits Producto {
    override method precio() =  0

    override method nombreDeOferta() = super() + " COMPRAME POR FAVOR"
}

class Cupon {
   var property noFueUsado = true

   const property descuento // devuelve un valor del estilo 0.50
}

object sistema {
  method precioTotalCarrito(usuario) = usuario.carrito().sum({producto => producto.precio()})

  method cuponesDisponibles(usuario) = usuario.cupones().filter({cupon => cupon.noFueUsado()})

  method buscarCupon(usuario){
    if(self.cuponesDisponibles(usuario).isEmpty()){
        throw new Exception(message = "No quedan cupones disponibles")
    }

    const primerElemento = self.cuponesDisponibles(usuario).first()
    primerElemento.noFueUsado(false)
    usuario.cupones().remove(primerElemento)
    return primerElemento.descuento()
  }

  method modificarPuntos(usuario,modificacion) {
    usuario.puntos(modificacion) 
  }

  method sumarPuntos(usuario){
   self.modificarPuntos(usuario,usuario.puntos() + self.precioTotalCarrito(usuario) * 0.10) 
  }

  method precioConCupon(usuario) = self.precioTotalCarrito(usuario) * (1 - self.buscarCupon(usuario))

  method actualizarNivel(usuario){
    if(usuario.puntos() > 15000) {
        usuario.nivel(oro)
    } else if(usuario.puntos() > 5000) {
        usuario.nivel(plata)
    } else {
    usuario.nivel(bronce)
    }
  }

  method reducirPuntos(usuario){
    if(usuario.dineroDisponible() < 0) {
      self.modificarPuntos(usuario,usuario.puntos() - 1000)
    }
  }

   method nombreDeOfertas(producto) {
     return producto.nombreDeOferta()
   }    
}

class Usuarios {
  const nombre
  var dineroDisponible
  method dineroDisponible() =  dineroDisponible

  var property puntos 

  var property nivel 

  var carrito = []
  method carrito() = carrito

  const property cupones = []

  method agregarPruducto(producto){
    sistema.actualizarNivel(self)
    if(nivel.tieneEspacio(carrito)){
        carrito.add(producto)
    } else {
    throw new Exception(message = "Tu nivel no te permite agregar mas productos")
    }
  }

  method vaciarCarrito() {
    carrito = []
  }

  method comprarProductos(){
     dineroDisponible -= sistema.precioConCupon(self)
     self.vaciarCarrito()
     sistema.sumarPuntos(self)
  }
}

object bronce {
  method tieneEspacio(carrito) = carrito.length() < 1
}
object plata {
  method tieneEspacio(carrito) = carrito.length() < 5
}
object oro {
  method tieneEspacio(carrito) = true
}
