run(Program):-
	parse(Tree, Program,[]),
	execute(Tree,[], Var).

parse(begin(ST1, ST)) --> [begin],states(ST1), s(ST).
 
s(state(ST, F)) --> states(ST), s(F).
s(0) --> [end].
 
states(assign(X,(EXP))) --> [X], {\+number(X)}, [:=], expression(EXP).
states(write(EXP)) --> [write], expression(EXP).
states(read(RE)) --> [read], reads(RE).
states(begin(ST)) --> [begin], s(ST).
 
states -->[].
 
reads(X) --> [X], {\+number(X)}.

expression(X) --> term(X). 
expression(add(X,Y)) --> term(X) , [+], expression(Y).
 
expression(sub(X,Y)) --> term(X) , [-], expression(Y).


term(X) --> [X], {\+number(X)}.
term(X) --> [X], {number(X)}.

 
endfeint --> [end].
writefeint --> [write].
readfeint --> [read].



execute(begin(X),L,Var):-
	execute(X,L,Re1).

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
		write(Y)
	; write(0).
		

execute(state(X,Y),L,Var):-
	execute(X,L,Re1),
	execute(Y,Re1,Var).


execute(0,L,Var).

re(Var,To,Li,Re):-
	member(Var, Li) ->
		
		nth0(N,Li,Var),
		E is N+1,
		replace(Li,E,To,Re)
	
	;	append(Li, [Var, To], Re).

	
replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > 0, I1 is I-1, replace(T, I1, X, R).


