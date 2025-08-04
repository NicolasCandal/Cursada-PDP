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

pesoHormiga(2).

%peso(Personaje, Peso)

peso(pumba, 100).
peso(timon, 50).
peso(simba, 200).

% bicho(Tipo,ElBicho()).

bicho(vaquitaSanAntonio, (gervasia,3)).
bicho(hormiga, federica).
bicho(hormiga, tuNoEresLaReina).
bicho(cucaracha, ginger).
bicho(cucaracha, erikElRojo).

bicho(vaquitaSanAntonio, romualda).
bicho(cucaracha, gimeno).
bicho(cucaracha, cucurucha).

bicho(vaquitaSanAntonio, remeditos).
bicho(hormiga, schwartzenegger).
bicho(hormiga, niato).
bicho(hormiga, lula).



% a) Qué cucaracha es jugosita: ó sea, hay otra con su mismo tamaño pero ella es más gordita.

esJugosita(Bicho):-
    comio(_, Bicho),
    comio(_,OtroBicho),
    esCucaracha(Bicho),
    esCucaracha(OtroBicho).

esCucaracha(Bicho):-
    ()