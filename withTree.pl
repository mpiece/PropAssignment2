run(Program):-
	parse(Tree, Program,[]),
	execute(Tree).

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



execute(begin(X,Y)):-
	execute(X),
	execute(Y).

execute(read(X)):-
	write(X+':'),
  	nl,
  	read(Y),
	X = Y.

execute(write(X)):-
	write($X).

execute(state(X,Y)):-
	execute(X),
	execute(Y).



execute(0).
