object huellitas {
    const capacidadMaxima = 10
    const botiquin = ["venda","venda","jeringa","gasa"]
    const pacientes = #{pepita,kali,nano}

    method cantidadDePacientes() = pacientes.size()

    method darDeAlta(animal) {
        pacientes.remove(animal)
    }

    method agregarALista(elemento,lista){
        lista.add(elemento)
    }

    method estaLleno() = self.cantidadDePacientes() >= capacidadMaxima

    method pacienteEnergico() {
        return pacientes.max({paciente => paciente.energia()})
    }

    method estaRecuperado(){
        return pacientes.filter({paciente => paciente.feliz()})
    }

    method responsables(){
        return pacientes.map({paciente => paciente.responsable()}).asSet()
    }

    method curarPacientes(){
        pacientes.forEach({paciente => paciente.recuperar()})
    }
}

object pepita {
var energia = 1000
method energia() = energia
}

object kali {
var energia = 10000
method energia() = energia
}

object nano {
var energia = 100
method energia() = energia
}