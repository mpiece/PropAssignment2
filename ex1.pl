re(Var,T,L,R):-
	%L = [H|T],
	nth0(N,L,Var),
	write(N),
	E is N+1,
	replace(L,E,T,R).

	
replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > 0, I1 is I-1, replace(T, I1, X, R).



addtoList(X, L):-
	write($L),
	append([],[X],L),
	addtoList(B, L).