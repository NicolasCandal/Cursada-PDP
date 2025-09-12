object sprinfild {
    var vientos = 10
    method vientos() = vientos

    const property riqueza = 0.9

    var nesesidadEnergetica = 20
    method nesesidadEnergetica(cantidad) = cantidad

    const centrales = #{exBosque,burns,elSuspiro}

    method produccionDeUnaCentral(central) = central.produccionEnergetica()

    method mejorCentral(){
        return centrales.max({central => self.produccionDeUnaCentral(central)})
    }

    method centralesContaminantes() {
       return centrales.filter({central => central.contamina()})
    }

    method cubrioSusNesesidades() {
        return self.produccionEnergeticaTotal(centrales) > nesesidadEnergetica
    }

    method produccionEnergeticaTotal(coleccion) {
        return coleccion.map({central => self.produccionDeUnaCentral(central)}).sum()
    }

    method estaAlHorno(){
        return self.todasCentralesContaminantes() or self.muchoAporteContaminante()
    }

    method muchoAporteContaminante() {
        return self.aporteContaminante() > nesesidadEnergetica/2
    }

    method aporteContaminante() {
        return self.produccionEnergeticaTotal(self.centralesContaminantes())
    }

    method cantidadDeCentrales(coleccion) {
       return coleccion.size()
    }

    method todasCentralesContaminantes() {
        return self.cantidadDeCentrales(centrales) == self.cantidadDeCentrales(self.centralesContaminantes())
    }
}

object albuquerque{
    var caudal = 150
    method caudal() = caudal

    const centrales = #{hidroElectrica}

    method mejorCentral(){
        return centrales.max({central => central.produccionEnergetica()})
    }
}

// Hay 3 centrales electricas
object burns {
    var varillaUranio = 10

    method produccionEnergetica() = 0.1 * varillaUranio

    method contamina() =  varillaUranio > 20
}

object exBosque {
    var capacidad = 20

    method produccionEnergetica() = self.calculoEnergetico()

    method calculoEnergetico() = 0.5 + (capacidad * sprinfild.riqueza())

    method contamina() = true
}

object elSuspiro {
    var turbinas = 1

    method produccionEnergetica() = turbinas * turbina.produccionEnergetica()

    method contamina() = false
}

object turbina{
    method produccionEnergetica() = 0.2 * sprinfild.vientos()
}

object hidroElectrica{
    method produccionEnergetica() = 2 * albuquerque.caudal()
}

object region {
    const ciudades = #{sprinfild,albuquerque}

    method MejorCentralPorCiudad(){
        return ciudades.map({ciudad => ciudad.mejorCentral()})
    }
}