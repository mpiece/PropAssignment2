grammar2(Tree)-->
	value2(Tree).

grammar2(add(Tree1,Tree2))-->
	

	grammar2(Tree1),
	[+],
	value2(Tree2).



value2(Value)-->
	[Value],
	{atom(Value)}.

