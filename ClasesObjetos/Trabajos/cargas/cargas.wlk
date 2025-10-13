object verdurin {
    var property cajones = 10 

    method peso() = 50 * cajones

    var kilometraje = 700000

    method velocidadMaxima() = 80 - (self.peso().div(500)) 

    method atravesarPeaje() {
        
    }

}

object scanion {
    const capacidad = 5000

    const velocidadMaxima = 140
}

object cerealitas {
    var deterioro = 0

    method velocidadMaxima() {
        if(deterioro < 10) {
            return 40
        } 
        else {
            return 0.max(60 - deterioro)
        }
    }
}

object rutaAtlantica {
    var precio = 7000

    method pasarPeaje(transporte) {
        transporte.atravesarPeaje()
    }
}