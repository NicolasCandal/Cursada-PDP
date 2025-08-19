% Cancion, Compositores, Reproducciones
cancion(bailanSinCesar, [pabloIlabaca, rodrigoSalinas], 10600177).
cancion(yoOpino, [alvaroDiaz, carlosEspinoza, rodrigoSalinas], 5209110).
cancion(equilibrioEspiritual, [danielCastro, alvaroDiaz, pabloIlabaca, pedroPeirano, rodrigoSalinas], 12052254).
cancion(tangananicaTanganana, [danielCastro, pabloIlabaca, pedroPeirano], 5516191).
cancion(dienteBlanco, [danielCastro, pabloIlabaca, pedroPeirano], 5872927).
cancion(lala, [pabloIlabaca, pedroPeirano], 5100530).
cancion(meCortaronMalElPelo, [danielCastro, alvaroDiaz, pabloIlabaca, rodrigoSalinas], 3428854).

% Mes, Puesto, Cancion
rankingTop3(febrero, 1, lala).
rankingTop3(febrero, 2, tangananicaTanganana).
rankingTop3(febrero, 3, meCortaronMalElPelo).
rankingTop3(marzo, 1, meCortaronMalElPelo).
rankingTop3(marzo, 2, tangananicaTanganana).
rankingTop3(marzo, 3, lala).
rankingTop3(abril, 1, tangananicaTanganana).
rankingTop3(abril, 2, dienteBlanco).
rankingTop3(abril, 3, equilibrioEspiritual).
rankingTop3(mayo, 1, meCortaronMalElPelo).
rankingTop3(mayo, 2, dienteBlanco).
rankingTop3(mayo, 3, tangananicaTanganana).
rankingTop3(junio, 1, dienteBlanco).
rankingTop3(junio, 2, tangananicaTanganana).
rankingTop3(junio, 3, lala).

% 1. Saber si una canción es un hit, lo cual ocurre si aparece en el ranking top 3 de todos los meses

esHit(Cancion):-
    cancion(Cancion,_,_),
    forall(rankingTop3(Mes,_,_),rankingTop3(Mes,_,Cancion)).


/* 2. Saber si una canción no es reconocida por los críticos, lo cual ocurre si tiene
muchas reproducciones y nunca estuvo en el ranking. Una canción tiene muchas
reproducciones si tiene más de 7000000 reproducciones. */

noReconocida(Cancion):-
    cancion(Cancion,_,Vistas),
    Vistas > 7000000,
    not(rankingTop3(_,_,Cancion)).

% 3. Saber si dos compositores son colaboradores, lo cual ocurre si compusieron alguna canción juntos.

colaboradores(UnCantante,OtroCantante):-
    cancion(_,Artistas,_),
    member(UnCantante,Artistas),
    member(OtroCantante,Artistas),
    UnCantante \= OtroCantante.

/* Trabajos
En el noticiero 31 Minutos cada trabajador puede tener múltiples trabajos. Algunos de los tipos
de trabajos que existen son:
● Los conductores, de los cuales nos interesa sus años de experiencia.
● Los periodistas, de los cuales nos interesa sus años de experiencia y su título, el cual
puede ser licenciatura o posgrado.
● Los reporteros, de los cuales nos interesa sus años de experiencia y la cantidad de
notas que hicieron a lo largo de su carrera */

% 4. Modelar en la solución a los siguientes trabajadores:

% Tulio, conductor con 5 años de experiencia.
trabaja(tulio, conductor(5)).

% trabaja(Nombre, trabajo()).

% Bodoque, periodista con 2 años de experiencia con un título de licenciatura, y 
% también reportero con 5 años de experiencia y 300 notas realizadas.
trabaja(bodoque, periodista(2, licenciatura)).
trabaja(bodoque, reportero(5, 300)).

% Mario Hugo, periodista con 10 años de experiencia con un posgrado.
trabaja(marioHugo, periodista(10, posgrado)).

/* 5. Conocer el sueldo total de una persona, el cual está dado por la suma de los sueldos
de cada uno de sus trabajos. El sueldo de cada trabajo se calcula de la siguiente forma: */

sueldoTotal(Persona,SueldoTotal):-
    trabaja(Persona,_),
    findall(Sueldo,(trabaja(Persona,Titulo),sueldo(Titulo,Sueldo)),Sueldos),
    sum_list(Sueldos,SueldoTotal).

sueldo(conductor(Exp),Sueldo):-
    Sueldo is Exp * 10000.

sueldo(reportero(Exp,Notas),Sueldo):-
    Sueldo is (Exp * 10000) + (Notas * 100).

sueldo(periodista(XP, licenciatura), Sueldo) :-
    Sueldo is (XP * 5000  * 1.2).

sueldo(periodista(XP, posgrado), Sueldo) :-
    Sueldo is (XP * 5000 * 1.35).

%! TERMINADO
