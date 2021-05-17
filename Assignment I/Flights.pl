flightPath(lax, nrt, 12, 5439).
flightPath(sin, nrt, 7, 3329).
flightPath(jfk, nrt, 14, 6729).
flightPath(jfk, lax, 6, 2469).
flightPath(cdg, lax, 12, 5656).
flightPath(fco, sin, 12, 6245).
flightPath(cdg, jfk, 9, 3624).
flightPath(fco, jfk, 10, 4266).
flightPath(cdg, fco, 2, 684).
flightPath(lju, fco, 3, 743).
flightPath(lju, cdg, 2, 587).

transferTime(lax, 2).
transferTime(nrt, 1).
transferTime(cdg, 1).
transferTime(jfk, 4).
transferTime(sin, 3).
transferTime(fco, 2).
transferTime(lju, 1).

connection(Start, Destination) :- flightPath(Start, Destination, _, _).
connection(Start, Destination) :- flightPath(Start, X, _, _), connection(X, Destination).

flightTime(Start, Destination, Time, Path) :- flightPath(Start, Destination, Time, _), append([Start],[Destination],Path).

flightTime(Start, Destination, Time, Path) :- 
    flightPath(Start, A, T1, _),
    transferTime(A, T2),
    flightTime(A, Destination, T3, IntermediatePath),
    Time is T1+T2+T3,
    append([Start], IntermediatePath, Path).


checkPath([]).
checkPath([H|T]) :- (flightPath(H, _, _, _); flightPath(_, H, _, _)), checkPath(T).

pathLength(Path, Length) :- checkPath(Path), length(Path, Length).


flightDistance(Start, Destination, Distance, Path) :- flightPath(Start, Destination, _, Distance), append([Start],[Destination],Path).

flightDistance(Start, Destination, Distance, Path) :- 
    flightPath(Start, A, _, D1),
    flightDistance(A, Destination, D2, IntermediatePath),
    Distance is D1+D2,
    append([Start], IntermediatePath, Path).

shortestPath(Start, Destination) :-
    findall(Distance, flightDistance(Start, Destination, Distance, _), DistanceList),
    min_list(DistanceList, X),
    format('Minimum Distance: ~w', [X]).


