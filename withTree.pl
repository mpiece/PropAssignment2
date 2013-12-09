run(Program):-
	s1(ParseTree,Program, []).


s1(begin(ST)) --> [begin], s(ST).

s(ST) --> states(ST), endfeint.

states(begin(ST)) --> [begin], s(ST).
states(assign(X,(EXP))) --> [X], {\+number(X)}, [:=], expression(EXP), states.
states(h), [end] --> endfeint.

expression(exp(TRM,FC)) --> term(TRM), factor(FC).

term(X) --> [X], {\+number(X)}.
term(X) --> [X], {number(X)}.

factor(0), [end] --> endfeint.
factor(add(EXP)) --> [+], expression(EXP).
factor(sub(EXP)) --> [-], expression(EXP).

endfeint --> [end].