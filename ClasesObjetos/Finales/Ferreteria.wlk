class Compra {
    const productos = []

    method totalAPagar() = productos.sum({producto => producto.precio()})
}

class Producto {
    var origen

    method precioBase()

    method precio() = self.precioBase() * origen.impuestoOrigen()
}

class Origen {
    const property impuestoOrigen // para un 25% se escribe 1.25
}

class Herramienta inherits Producto {
    var peso

    override method precioBase() = peso * 10
}

class HerramientaProfesional inherits Herramienta {
    override method precio() = super() + 10000
}

class Material inherits Producto {
    var precioMaterial

    override method precioBase() = precioMaterial 
}