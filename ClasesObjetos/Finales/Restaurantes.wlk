class Restaurante {
    var property esPremiado
    const menu = #{}

    method agregarPlato(plato) {
        menu.add(plato)
    }

    method menuVariado() = menu.size() > 50

    method menuLight() = menu.all({plato => plato.esLight()})

}

class Plato {
    const origen
    const chef  
    const calorias
    const tieneGluten

    method esLight() = calorias < 300
}

class Critico {
    method preferencia(restaurante) = restaurante.esPremiado()
}

class Variedad inherits Critico {
    override method preferencia(restaurante) = super(restaurante) and restaurante.menuVariado()
}

class Light inherits Critico {
    override method preferencia(restaurante) = super(restaurante) and restaurante.menuLight()
}

object criticoCombinado {
    const estilosPreferencias = #{}

    method agregarEstilo(estilo) {
        estilosPreferencias.add(estilo)
    }

    method preferencia(restaurante) = estilosPreferencias.all({estilo => estilo.preferencia(restaurante)})
}