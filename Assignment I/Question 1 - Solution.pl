individual(john, male, albert, rose).
individual(jenny, female, wilson, arden).
individual(zac, male, ken, kayla).
individual(nelson, male, ken, kayla).
individual(henry, male, ken, kayla).
individual(ken, male, john, jenny).
individual(mason, male, francis, uzma).
individual(michelle, female, francis, uzma).
individual(mike, male, francis, uzma).
individual(francis, male, john, jenny).
individual(alexia, female, inglewood, huma).
individual(fatima, female, inglewood, huma).
individual(adison, female, inglewood, huma).
individual(rachel, female, inglewood, huma).
individual(maria, female, inglewood, huma).
individual(miles, male, inglewood, huma).
individual(huma, female, john, jenny).
individual(yusra, female, ian, atiya).
individual(hamdan, male, ian, atiya).
individual(ali, male, ian, atiya).
individual(atiya, female, john, jenny).
individual(faiza, female, danish, fauzia).
individual(azeem, male, danish, fauzia).
individual(muhab, male, danish, fauzia).
individual(danish, male, john, jenny).



is_male(X) :- individual(X, male, _, _).
is_female(X) :- individual(X, female, _, _).

is_father(X, Y) :- individual(Y, _, X, _).
is_mother(X, Y) :- individual(Y, _, _, X).
siblings(X, Y) :- individual(X, _, A, B), individual(Y, _, A, B), X \= Y.


offspring(X, Y) :- individual(X, _, Y, _);individual(X, _, _, Y).
niblings(X, Y) :- individual(Y, _, A, B), individual(N, _, A, B), offspring(X, N), \+is_father(Y, X), \+is_mother(Y, X).
puncle(X, Y) :- individual(Y, _, F, _), is_male(X), siblings(F, X), \+is_father(X, Y).
modrige(X, Y) :- individual(Y, _, _, M), is_female(X), siblings(M, X), \+is_mother(X, Y).
avuncle(X, Y) :-  individual(Y, _, _, M), is_male(X), siblings(M, X).
