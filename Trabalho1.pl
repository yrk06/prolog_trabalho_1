:- dynamic estudante/4.
:- dynamic nota/4.

menu:-
    write('\e[2J'),
    nl,
    write('---------------------------------------'),
    nl,
    write('*    DOMÍNIO INSTITUIÇÃO DE ENSINO    *'),
    nl,
    write('---------------------------------------'),
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
    write('---------------------------------------'),
    nl,
    write('*    DOMÍNIO INSTITUIÇÃO DE ENSINO    *'),
    nl,
    write('---------------------------------------'),
    nl,
    write('Saindo!'), 
    nl,
    abort.

executa( 1 ) :-
    incluir_estudante.

executa( 2 ) :- 
    op2.

executa( 3 ) :-
    op3.

executa( 4 ) :-
    excluir_estudante_e_suas_notas.

executa( 5 ) :-
    op5.

executa( 6 ) :-
    op6.

executa( 7 ) :-
    op7.

executa( 8 ) :-
    op8.

incluir_estudante:-
    write('---------------------------------------'),
    nl,
    write('Incluir Estudante'),
    nl,
    writeln('---------------------------------------'),
    nl,
    writeln('Informe a matricula do Estudante: '),
    read(Matricula),
    incluir_estudante(Matricula).
    

incluir_estudante(Matricula):-
    estudante(Matricula,_,_,_),
    nl,
    write('---------------------------------------'),
    nl,
    write('Matricula Ja esta em uso'),
    nl,
    writeln('---------------------------------------'),
    nl,
    writeln('Digite algo para voltar:'),
    read(_).

incluir_estudante(Matricula):-
    writeln('Informe o Nome do Estudante: '),
    read(Nome),
    writeln('Informe a data de nacimento do Estudante: '),
    write('dia'),
    read(Dia),
    write('Mes'),
    read(Mes),
    write('Ano'),
    read(Ano),
    writeln('Informe o Endereco do Estudante: '),
    read(Endereco),
    X = data(Dia,Mes,Ano),
    assert(estudante(Matricula,Nome,X,Endereco)),
    nl,
    write('---------------------------------------'),
    nl,
    write('Estudante Incluir Com Sucesso'),
    nl,
    writeln('---------------------------------------'),
    nl,
    writeln('Digite algo para voltar:'),
    read(_).

excluir_estudante_e_suas_notas:-
    write('---------------------------------------'),
    nl,
    write('Excluir Estudante e suas Notas'),
    nl,
    writeln('---------------------------------------'),
    nl,
    writeln('Informe a matricula do Estudante: '),
    read(X),
    nl,
    estudante(X,_,_,_),
    retractall(estudante(X,_,_,_)),
    retractall(nota(X,_,_,_)),
    writeln('excluido com sucesso'),
    nl,
    writeln('Digite algo para voltar:'),
    read(_).

excluir_estudante_e_suas_notas:-
    write('---------------------------------------'),
    nl,
    write('Matricula nao registra/nao existe'),
    nl,
    writeln('---------------------------------------'),
    nl,
    writeln('Digite algo para voltar:'),
    read(_).


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

calculate_notas(_).