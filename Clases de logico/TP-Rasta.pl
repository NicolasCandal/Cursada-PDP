estaEnElAula(rasta).
estaEnElAula(polito).
estaEnElAula(santi).

% Santi quiere a todos los que están en el aula, siempre que no los quiera el Rasta.

loQuiere(Persona,OtraPersona):-
    Persona = santi,
    estaEnElAula(OtraPersona),
    \+ loQuiere(rasta,OtraPersona).

% Rasta quiere a todos los que están en el aula salvo a Polito.
    
loQuiere(Persona,OtraPersona):-
    Persona = rasta,
    estaEnElAula(OtraPersona),
    OtraPersona \= polito.

% Quien está en el aula y no es querido por Polito, tiene menos suerte que el Rasta.

menosSuerteQueRasta(Persona):-
    estaEnElAula(Persona),
    \+ loQuiere(rasta,Persona).

% Quien ayuda a otra persona es porque la quiere y no tiene menos suerte que ella. Además, quien ayuda está en el aula.


