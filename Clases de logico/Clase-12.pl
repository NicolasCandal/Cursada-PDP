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

leGustaAGus(Obra):-
    escribio(isaacAsimov,Obra).
    leGustaAGus(sandman).

% Queremos saber si una obra es rioplatense, que es cuando la nacionalidad de su artista es Uruguay o Argentina

esRioplatense(Obra):-
    escribio(Artista,Obra),
    tieneNacionalidad(Artista,Pais),
    rioplatense(Pais).
%Paises

rioplatense(argentina).
rioplatense(uruguay).

esLibro(Obra):-
    escribio(_,Obra),
    not(esComic(Obra)).

esComiquero(Artista):-
    escribio(Artista,_),
    forall(escribio(Artista,Obra),esComic(Obra)).

esDeGenero(it,novela(terror,11)).
esDeGenero(buenosPresagios,novela(fantasia,6)).
esDeGenero(sunrise,libroDeCuentos(12)).

/* novela(tipoDeNovela,paginas).
libroDeCuentos(cantidadDeCuentos).
libroCientifico(disciplinaCientifica).
bestSeller(precio,cantPaginas). */

/* % Una obra esta buena cuando 
1. Es una novela policial y tiene menos de 12 paginas 
2. Es novela de terror 
3. Los libros con mas de 10 cuentos 
4. Obras de ciencia ficcionCuantica 
5. Es bestSeller y el precio por pagina es menor a 50 */


estaBuena(Obra):-
    esDeGenero(Obra,Genero),
    generoBueno(Genero).

generoBueno(novela(terror,_)).

generoBueno(novela(policial,Capitulos)):-
    Capitulos < 12.

generoBueno(libroDeCuentos(Cantidad)):-
    Cantidad > 10.

generoBueno(libroCientifico(ficcionCuantica)).

generoBueno(bestSeller(Precio,Pags)):-
    (Precio/Pags) < 50.