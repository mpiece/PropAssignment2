run(Program):-
	s1(ParseTree,Program, []).


s1(begin(ST)) --> [begin], s(ST).

s(ST) --> states(ST), endfeint.



states(assign(X,(EXP)), ST) --> [X], {\+number(X)}, [:=], expression(EXP), states(ST).
states(write(EXP), ST) --> [write], expression(EXP), states(ST).
states(read(RE), ST) --> [read], reads(RE), states(ST).
states(begin(ST)) --> [begin], s(ST).
states(0), [end] --> endfeint.

reads(X) --> [X], {\+number(X)}.

expression(exp(TRM,FC)) --> term(TRM), factor(FC).

term(X) --> [X], {\+number(X)}.
term(X) --> [X], {number(X)}.

factor(0), [end] --> endfeint.
factor(0), [read] --> readfeint.
factor(0), [write] --> writefeint.
factor(add(EXP)) --> [+], expression(EXP).
factor(sub(EXP)) --> [-], expression(EXP).

endfeint --> [end].
writefeint --> [write].
readfeint --> [read].