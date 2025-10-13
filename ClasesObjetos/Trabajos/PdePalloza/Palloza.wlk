class Banda {
   const nombre
   const nacionalidad
   var aniosDeTrayectoria
   var cantidadIntegrantes
   method cantidadIntegrantes() = cantidadIntegrantes
   var reconocimiento
   var genero

   method genero(nuevoGenero) {
    genero = nuevoGenero
   }

   method presentarse(){
     return "Hola somos " + nombre + " y tocamos " + genero.nombre()
   }

   method laRompe() = reconocimiento > 70 and aniosDeTrayectoria > 10 and genero.energia(self) > 5

   method cantidadDeOyentes() = reconocimiento * nacionalidad.impronta(self) * genero.popularidad()
}

class Genero {
    var popularidad
    var nombre

    method nombre() = nombre

    method popularidad() = popularidad

    method energia(banda) 
}

object rock inherits Genero (popularidad = 8, nombre = "rock") {
   override method energia(banda){
     if(banda.cantidadIntegrantes() > 3) {
        return 10
     } else {
        return 8
     }
   }
}

object funk inherits Genero (popularidad = 7, nombre = "funk"){
    override method energia(banda){
        return 7
    }
}

object trap inherits Genero (popularidad = 10, nombre = "trap") {
   override method energia(banda){
        return 8
    }
}

object argentina {
      method impronta(banda){
        return 100 * banda.reconocimiento()
    }
}

object uruguay {
     method impronta(banda){
        return 400 * banda.cantidadIntegrantes()
    }
}

object show {
    const bandas = #{}

    method exito() = bandas.all({banda => banda.laRompe()}) or bandas.sum({banda => banda.cantidadDeOyentes() }) > 100000
}