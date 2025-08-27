object lapicera {

    var tinta = 500 
    method tinta()= tinta

    const marca = "Bic"
    method marca() = marca

    const grosor = 500
    method grosor() = grosor

    method escribir(palabras)  {
        tinta -= palabras * 3
    }
}

object prueba {
    const hoy = new Date()
    method hoy() = hoy
}