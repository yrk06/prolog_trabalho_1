menu:-
    write('\e[2J'),
    nl,
    write('***************************************'),
    nl,
    write('*    DOMÍNIO INSTITUIÇÃO DE ENSINO    *'),
    nl,
    write('***************************************'),
    nl,
    writeln('Escolha qual a opcao deseja executar: '),
    nl,
    writeln('1-Incluir Estudante.'),
    writeln('2-Incluir Notas do Estudante.'),
    writeln('3-Localizar Estudante pela Matricula'),
    writeln('4-Excluir Estudante e suas Notas.'),
    writeln('5-Relatorio dos Estudantes.'),
    writeln('6-Salvar Dados em Arquivo.'),
    writeln('7-Carregar Dados em Arquivo.'),
    writeln('8-Limpar Banco de Dados.'),
    writeln('0-Sair.'),
    nl,
    writeln('Informe a opcao: '),
    read(Entrada),
    nl,
    Entrada =\= 8,
    executa( Entrada ),
    menu.

menu :-
    nl,
    write('***************************************'),
    nl,
    write('*    DOMÍNIO INSTITUIÇÃO DE ENSINO    *'),
    nl,
    write('***************************************'),
    nl,
    write('Saindo!'), 
    nl,
    abort.

executa( 1 ) :-
    op1.

executa( 2 ) :- 
    op2.

executa( 3 ) :-
    op3.

executa( 4 ) :-
    op4.

executa( 5 ) :-
    op5.

executa( 6 ) :-
    op6.

executa( 7 ) :-
    op7.

executa( 8 ) :-
    op8.


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