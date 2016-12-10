% Extraido desde http://wiki.clarolab.com/thread/1203
% Editado y ejecutado por:
% Gustavo Mejía
% CI: 25.302.093

% El acertijo de Einstein: Albert Einstein planteó el siguiente acertijo y advirtió que 
%                          no más del 2% de la población del mundo podría resolverlo.

% Condiciones iniciales:              
 
%    * Tenemos cinco casas, cada una de un color.
%    * Cada casa tiene un dueño de nacionalidad diferente.
%    * Los 5 dueños beben una bebida diferente, fuman marca diferente y tienen mascota diferente.
%    * Ningún dueño tiene la misma mascota, fuma la misma marca o bebe el mismo tipo de bebida que otro.
 
% 1.     El noruego vive en la primera casa, junto a la casa azul.
% 2.     El que vive en la casa del centro toma leche.
% 3.     El inglés vive en la casa roja.
% 4.     La mascota del sueco es un perro.
% 5.     El danés bebe té.
% 6.     La casa verde es la inmediata de la izquierda de la casa blanca.
% 7.     El de la casa verde toma café.
% 8.     El que fuma PallMall cría pájaros.
% 9.     El de la casa amarilla fuma Dunhill.
% 10.    El que fuma Blend vive junto al que tiene gatos.
% 11.    El que tiene caballos vive junto al que fuma Dunhill.
% 12.    El que fuma BlueMaster bebe cerveza.
% 13.    El alemán fuma Prince.
% 14.    El que fuma Blend tiene un vecino que bebe agua.

%        ¿Quién tiene peces por mascota?


/******************************************************************************/


% C_(Numero,Color,Pais,Bebida,Mascota,Fuma).
% Este predicado intenta coincidir pares de vecinos en el mismo orden en que los recibe (es necesario).
% Es recursivo, se llama a sí mismo hasta que encuentra una coincidencia.

vecino_izq([H|[Ht|T]],Vecino_Izq,Vecino_Der):-
(
H = Vecino_Izq,
Ht = Vecino_Der
);
vecino_izq([Ht|T],Vecino_Izq,Vecino_Der). 

% Para los datos en que no especifica si el vecino es izquierdo o derecho, este predicado prueba con ambos.

vecino([H|T],Pista_1,Pista_2):-
vecino_izq([H|T],Pista_1,Pista_2);
vecino_izq([H|T],Pista_2,Pista_1).

% Este procedimiento coincide cada casa con su contenido.
% Sin embargo la primera puede no ser la correcta. En ese entonces, fallará más adelante, y comienza a retroceder
% buscando otras alternativas. Al final, dará con la correcta.

% Se puede ejecutar desde el prolog así, obteniendo algo claro:
% ?- villa([Casa1,Casa2,Casa3,Casa4,Casa5]).
% O bien:
% ?- villa(X).

villa(Villa):-
Villa = [
[1,_,noruego,_,_,_],
[2,azul,_,_,_,_],
[3,_,_,leche,_,_],
[4,_,_,_,_,_],
[5,_,_,_,_,_]
],
member([_,roja,ingles,_,_,_],Villa),
member([_,_,sueco,_,perro,_],Villa),
member([_,_,danes,te,_,_],Villa),
vecino_izq(Villa,[_,verde,_,_,_,_],[_,blanca,_,_,_,_]),
member([_,verde,_,cafe,_,_],Villa),
member([_,_,_,_,pajaros,pallmall],Villa),
member([_,amarilla,_,_,_,dunhill],Villa),
vecino(Villa,[_,_,_,_,_,blend],[_,_,_,_,gatos,_]),
vecino(Villa,[_,_,_,_,caballos,_],[_,_,_,_,_,dunhill]),
member([_,_,_,cerveza,_,bluemaster],Villa),
member([_,_,aleman,_,_,prince],Villa),
vecino(Villa,[_,_,_,_,_,blend],[_,_,_,agua,_,_]),
member([_,_,_,_,peces,_],Villa).

% Finalmente, para responder a la pregunta del acertijo, se hace la consulta desde PROLOG:
% ?- mascota(peces,X).

mascota(Mascota,Persona):-
villa(Villa),
member([_,_,Persona,_,Mascota,_],Villa).
