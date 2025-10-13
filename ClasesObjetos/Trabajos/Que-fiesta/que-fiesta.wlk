/* 1. A Mañic, la ñandú, le encanta la astronomía, por lo que lleva la cuenta de las estrellas que encuentra.
Hacer que Mañic encuentre estrellas. Siempre que las encuentra lo hace por constelación, de a 8 por vez.
Hacer que regale estrellas, siempre que lo hace, las regala de a una por vez */


// Saber si Mañic tiene todo listo para la fiesta, esto pasa cuando tiene al menos 4 estrellas.


object manic {
    var estrellas = 0
    method estrellas() = estrellas

    var property globos = 20

    method buscarEstrellas() {
        estrellas += 8
    }

    method regalarEstrellas() {
        estrellas -= 1
    }

   
    method listoParaFiesta() = self.estrellas() > 4
}

/* Quien organice la fiesta de Guyrá pondrá su casa y será responsable de tener una cantidad de globos para decorar. 
Queremos averiguar si la fiesta está preparada. 
Esto sucede cuando hay más de 50 globos y quien organiza tiene todo listo. */

object fiesta {
    
    method fiestaPreparada(organizador) = organizador.globos() > 50 and organizador.listoParaFiesta()
}

object chuy {
    var property globos = 80

    method listoParaFiesta() = true
}

object capy {
    var property globos = 0

    var latas = 0
    method latas() = latas
    
    method recolectar() {
        latas += 1
    }

    method reciclar() {
        latas = 0.max(latas - 5)
    }

    method listoParaFiesta() = self.latas().even()
}