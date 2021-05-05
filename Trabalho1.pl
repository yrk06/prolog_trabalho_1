
load :-
    [dadostrabalho1].


display_aluno(X) :- 
    writef('/*********************************/
    Aluno: %t \n',[X]),
    retractall(acumulador_calc_quantidade_notas(_)),
    retractall(acumulador_calc_total_notas(_)),
    assert(acumulador_calc_quantidade_notas(0)),
    assert(acumulador_calc_total_notas(0)),
    calculate_notas(X),
    retract(acumulador_calc_quantidade_notas(A)),
    retract(acumulador_calc_total_notas(B)),
    C is B / A,
    writef('Nota media: %t \n',[C]).



calculate_notas(X) :-
    estudante(ID,X,_,_),
    nota(ID,DIS,ANO,NOTA),
    retract(acumulador_calc_quantidade_notas(NOTAS_AC)),
    retract(acumulador_calc_total_notas(NOTAS_TOTAL)),
    NEW_NOTAS_AC is NOTAS_AC + 1,
    NEW_NOTAS_TOTAL is NOTAS_TOTAL + NOTA,
    assert(acumulador_calc_quantidade_notas(NEW_NOTAS_AC)),
    assert(acumulador_calc_total_notas(NEW_NOTAS_TOTAL)),
    writef('Disciplina: %t Ano: %t Nota: %t \n',[DIS,ANO,NOTA]),
    fail.

calculate_notas(X).