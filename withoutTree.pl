run(Program):-
	s1(Program, []).


s1 --> [begin], s.

s--> states, endfeint.

states --> [begin], s.
states --> [read], reads, states.
states --> [X], {\+number(X)}, [:=], expression, states. 
states, [end] --> endfeint.
states --> [write], expression, states.

reads --> [X], {\+number(X)}.

expression --> term, factor.

term --> [X], {\+number(X)}.
term --> [X], {number(X)}.

factor, [end] --> endfeint.
factor, [read] --> readfeint.
factor --> [+], expression.
factor --> [-], expression.

readfeint --> [read].
endfeint --> [end].