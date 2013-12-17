run(Program):-
	parse(Tree, Program,[]),
	write(Tree),
	execute(Tree,[], Var).

parse(begin(ST)) --> [begin], s(ST).
 
s(state(ST, F)) --> states(ST), s(F).
s(0) --> [end].
s(0) --> [].
 
states(assign(X,(EXP))) --> [X], {\+number(X)}, [:=], expression(EXP).
states(write(EXP)) --> [write], expression(EXP).
states(read(RE)) --> [read], reads(RE).
states(while(OPS ,BE)) --> [while], jmfOP(OPS), states(BE).
states(begin(ST)) --> [begin], s(ST).
states -->[].
 
reads(X) --> [X], {\+number(X)}.

expression(X) --> term(X).
expression(sub(X,Y)) --> term(X), [-], expression(Y).
expression(add(X,Y)) --> term(X) , [+], expression(Y).

jmfOP(isGreat(X,Y)) --> [X], {\+number(X)}, [>], expression(Y).
jmfOP(isLess(X,Y)) -->  [X], {\+number(X)},[<], expression(Y).
jmfOP(equals(X,Y)) -->  [X], {\+number(X)},[:=], expression(Y).
jmfOP(lessOrEqual(X,Y)) -->  [X], {\+number(X)},[<=], expression(Y).
jmfOP(greatOrEqual(X,Y)) -->  [X], {\+number(X)}, [>=], expression(Y).

term(X) --> [X], {\+number(X)}.
term(num(X)) --> [X], {number(X)}.

 
endfeint --> [end].
writefeint --> [write].
readfeint --> [read].

execute(begin(X),L,Var):-
	execute(X,L,Var).

execute(begin(X,Y),L,Var):-
	execute(X,L,Re1),
	execute(Y,Re1,Var).

execute(read(X),L,Var):-
	write(X+':'),
  	nl,
  	read(Y),
	re(X, Y, L, Var).
	

execute(write(X),L,Var):-
	member(X, L) ->
		nextto(X, Y, L),
		write(Y), nl,
		Var = L
	; write(0), Var = L.
		

execute(state(X,Y),L,Var):-
	execute(X,L,Re1),
	execute(Y,Re1,Var).

execute(while(X,Y),L,Var2):-
	execute(X,L,B),
	B = 1 -> execute(Y,L,Var),execute(while(X,Y),Var,Var2)
	; Var2 = L.

execute(equals(X,Y),L,B):-
	nextto(X, Z, L),
	execute(Y,O),
	Z = O -> B = 1
	; B = 0.

execute(isGreat(X,Y),L,B):-
	nextto(X, Z, L),
	execute(Y,O),
	Z @> O -> B = 1
	; B = 0.

execute(isLess(X,Y),L,B):-
	nextto(X, Z, L),
	execute(Y,O),
	Z @< O -> B = 1
	; B = 0.

execute(lessOrEqual(X,Y),L,B):-
	nextto(X, Z, L),
	execute(Y,O),
	Z @=< O -> B = 1
	; B = 0.

execute(greatOrEqual(X,Y),L,B):-
	nextto(X, Z, L),
	execute(Y,O),
	Z @>= O -> B = 1
	; B = 0.

execute(0,L,Var):-Var=L.

execute(assign(X,Y),L,Var):-
	execute(Y,O),
	re(X, O, L, Var).

execute(add(X,Y),O):-
	execute(X,L),
	execute(Y,R),
	O is L+R.

execute(sub(X,Y),O):-
	execute(X,L),
	execute(Y,R),
	O is L-R.



execute(num(X),X).

re(Var,To,Li,Re):-
	member(Var, Li) ->
		nth0(N,Li,Var),
		E is N+1,
		replace(Li,E,To,Re)
	
	;	append(Li, [Var, To], Re).

	
replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > 0, I1 is I-1, replace(T, I1, X, R).


