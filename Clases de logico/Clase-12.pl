escribio(elsaBornemann, socorro).
escribio(neilGaiman, sandman).
escribio(alanMoore, watchmen).
escribio(brianAzarello, cienBalas).
escribio(warrenEllis, planetary).
escribio(frankMiller, elCaballeroOscuroRegresa).
escribio(frankMiller, batmanAnioUno).
escribio(neilGaiman, americanGods).
escribio(neilGaiman, buenosPresagios).
escribio(terryPratchett, buenosPresagios).
escribio(isaacAsimov, fundacion).
escribio(isaacAsimov, yoRobot).
escribio(isaacAsimov, elFinDeLaEternidad).
escribio(isaacAsimov, laBusquedaDeLosElementos).
escribio(joseHernandez, martinFierro).
escribio(stephenKing, it).
escribio(stephenKing, misery).
escribio(stephenKing, carrie).
escribio(stephenKing, elJuegoDeGerald).
escribio(julioCortazar, rayuela).
escribio(jorgeLuisBorges, ficciones).
escribio(jorgeLuisBorges, elAleph).
escribio(horacioQuiroga, cuentosDeLaSelva).
escribio(horacioQuiroga, cuentosDeLocuraAmorYMuerte).

tieneNacionalidad(elsaBornemann, argentina).  
tieneNacionalidad(neilGaiman, reinoUnido).  
tieneNacionalidad(alanMoore, reinoUnido).  
tieneNacionalidad(brianAzarello, estadosUnidos).  
tieneNacionalidad(warrenEllis, reinoUnido).  
tieneNacionalidad(frankMiller, estadosUnidos).  
tieneNacionalidad(terryPratchett, reinoUnido).  
tieneNacionalidad(isaacAsimov, estadosUnidos).  
tieneNacionalidad(joseHernandez, argentina).  
tieneNacionalidad(stephenKing, estadosUnidos).  
tieneNacionalidad(julioCortazar, argentina).  
tieneNacionalidad(jorgeLuisBorges, argentina).  
tieneNacionalidad(horacioQuiroga, uruguay). 

esComic(sandman).
esComic(cienBalas).
esComic(watchmen).
esComic(planetary).
esComic(elCaballeroOscuroRegresa).
esComic(batmanAnioUno).

copiasVendidas(socorro, 10000).
copiasVendidas(sandman, 20000).
copiasVendidas(watchmen, 30000).
copiasVendidas(cienBalas, 40000).
copiasVendidas(planetary, 50000).
copiasVendidas(elCaballeroOscuroRegresa, 60000).
copiasVendidas(batmanAnioUno, 70000).
copiasVendidas(americanGods, 80000).
copiasVendidas(buenosPresagios, 90000).
copiasVendidas(buenosPresagios, 10000).
copiasVendidas(fundacion, 20000).
copiasVendidas(yoRobot, 30000).
copiasVendidas(elFinDeLaEternidad, 30000).
copiasVendidas(laBusquedaDeLosElementos, 40000).
copiasVendidas(martinFierro, 50000).
copiasVendidas(it, 60000).
copiasVendidas(it, 70000).
copiasVendidas(misery, 70000).
copiasVendidas(carrie, 80000).
copiasVendidas(elJuegoDeGerald, 90000).
copiasVendidas(rayuela, 10000).
copiasVendidas(ficciones, 20000).
copiasVendidas(elAleph, 30000).
copiasVendidas(cuentosDeLaSelva, 40000).
copiasVendidas(cuentosDeLocuraAmorYMuerte, 50000).

% Lo siguiente se conoce como REGLA

esArtistaDelNovenoArte(Artista):-   % Recibe un artista
  escribio(Artista,Obra),    % Ese asrtista escribio una obra?
  esComic(Obra).     % Esa obra es un comic?

% Es bestseller si vendio mas de 50000 copias de una obra
esBestSeller(Obra) :-
    copiasVendidas(Obra,Ventas),
    Ventas > 50000.   % comparo si ese valor es mayor a 50000

% es recidente si un artista hizo mas de una obra
esRecidente(Artista):-
    escribio(Artista,Obra),
    escribio(Artista,Obra2),
    Obra \= Obra2.  % comparo que esas 2 obras sean distintas

% vale la pena contrar si es best seller, si es recidente o si es neilGaiman
convieneContratar(Artista):-
    escribio(Artista,Obra),
    esBestSeller(Obra).

convieneContratar(Artista):-
    esRecidente(Artista).

convieneContratar(neilGaiman).  % Lo ponemos como un hecho mediante una clausula.

% Queremos saber si a Gus le gusta una obra. A Gus le gusta todo lo que escribió Asimov y sandman.

leGustaAGus(sandman).

leGustaAGus(Obra):-
    escribio(asimov,Obra).

% Queremos saber si una obra es rioplatense, que es cuando la nacionalidad de su artista es Uruguay o Argentina

esRioplatense(Artista):-
    tieneNacionalidad(Artista,argentina).

esRioplatense(Artista):-
    tieneNacionalidad(Artista,uruguaya).