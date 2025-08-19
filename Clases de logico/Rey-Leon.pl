%comio(Personaje, Bicho)

comio(pumba, vaquitaSanAntonio(gervasia,3)).
comio(pumba, hormiga(federica)).
comio(pumba, hormiga(tuNoEresLaReina)).
comio(pumba, cucaracha(ginger,15,6)).
comio(pumba, cucaracha(erikElRojo,25,70)).

comio(timon, vaquitaSanAntonio(romualda,4)).
comio(timon, cucaracha(gimeno,12,8)).
comio(timon, cucaracha(cucurucha,12,5)).

comio(simba, vaquitaSanAntonio(remeditos,4)).
comio(simba, hormiga(schwartzenegger)).
comio(simba, hormiga(niato)).
comio(simba, hormiga(lula)).

comio(shenzi,hormiga(conCaraDeSimba)).

pesoHormiga(2).

% persigue(hiena,personaje)

persigue(scar, timon).
persigue(scar, pumba).
persigue(shenzi, simba).
persigue(shenzi, scar).
persigue(banzai, timon).

%peso(Personaje, Peso)

peso(pumba, 100).
peso(timon, 50).
peso(simba, 200).

peso(scar, 300).
peso(shenzi, 400).
peso(banzai, 500).


% bicho(Tipo,ElBicho()).

/* bicho(vaquitaSanAntonio(gervasia,3)).
bicho(vaquitaSanAntonio(remeditos,4)).
bicho(vaquitaSanAntonio(romualda,4)).

bicho(cucaracha(gimeno,12,8)).
bicho(cucaracha(cucurucha,12,5)).
bicho(cucaracha(ginger,15,6)).
bicho(cucarachacucaracha(erikElRojo,25,70)).

bicho(hormiga(federica)).
bicho(hormiga(tuNoEresLaReina)).
bicho(hormiga, schwartzenegger).
bicho(hormiga, niato).
bicho(hormiga, lula). */

% 1) A falta de pochoclos...

% a) Qué cucaracha es jugosita: ó sea, hay otra con su mismo tamaño pero ella es más gordita.

esJugosita(Bicho):-
    comio(_, Bicho),
    comio(_,cucaracha(_,Tamanio,Peso)),
    pesaMasCucaracha(Bicho,Tamanio,Peso).

pesaMasCucaracha(cucaracha(_,Tamanio,OtroPeso),Tamanio,Peso):-
    OtroPeso > Peso.

% b) Si un personaje es hormigofílico... (Comió al menos dos hormigas).

esHormigofilico(Personaje):-
    comio(Personaje,hormiga(Nombre)),
    comio(Personaje,hormiga(OtroNombre)),
    Nombre \= OtroNombre.

% c) Si un personaje es cucarachofóbico (no comió cucarachas).

esCucarachofobico(Personaje):-
    comio(Personaje,_),
    forall(comio(Personaje,Bicho),not(esCucaracha(Bicho))).

esCucaracha(cucaracha(_,_,_)).

/* d) Conocer al conjunto de los picarones. Un personaje es picarón si comió una cucaracha jugosita ó si se
come a Remeditos la vaquita. Además, pumba es picarón de por sí. */

sonPicarones(Personajes):-
    findall(Personaje,(comio(Personaje,_),esPicaron(Personaje)),PersonajesRepetidos),
    list_to_set(PersonajesRepetidos,Personajes).

esPicaron(pumba).

esPicaron(Personaje):-
    comio(Personaje,vaquitaSanAntonio(remeditos,_)).

esPicaron(Personaje):-
    comio(Personaje,Bicho),
    esJugosita(Bicho).

% 2) Pero yo quiero carne...

/* a) Se quiere saber cuánto engorda un personaje (sabiendo que engorda una cantidad igual a la suma de
los pesos de todos los bichos en su menú). Los bichos no engordan. */

cuantoEngorda(Personaje,Peso):-
    comio(Personaje,_),
    not(persigue(Personaje,_)),
    findall(UnPeso,calcularPeso(Personaje,UnPeso),Pesos),
    sum_list(Pesos,Peso).

calcularPeso(Personaje,UnPeso):-
    comio(Personaje,Bicho),
    cuantoPesa(Bicho,UnPeso).

cuantoPesa(hormiga(_),2).

cuantoPesa(cucaracha(_,_,Peso),Peso).

cuantoPesa(vaquitaSanAntonio(_,Peso),Peso).

/* b) Pero como indica la ley de la selva, cuando un personaje persigue a otro, se lo termina comiendo, y por lo
tanto también engorda. Realizar una nueva version del predicado cuantoEngorda. */

cuantoEngorda(Hiena,Peso):-
    persigue(Hiena,_),
    findall(UnPeso,calcularPesoHiena(Hiena,UnPeso),Pesos),
    sum_list(Pesos,Peso).

calcularPesoHiena(Hiena,UnPeso):-
    persigue(Hiena,Personaje),
    peso(Personaje,UnPeso).

calcularPesoHiena(Hiena,UnPeso):-
    calcularPeso(Hiena,UnPeso).