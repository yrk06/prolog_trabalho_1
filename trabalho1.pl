:- dynamic estudante/4.
:- dynamic nota/4.
:- dynamic totalnotas/1.

menu:-
    write('\e[2J'),
    nl,
    write('---------------------------------------'),
    nl,
    write('*    DOMINIO INSTITUICAO DE ENSINO    *'),
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
    Entrada =\= 0,
    executa( Entrada ),
    menu.

menu:-
    nl,
    write('---------------------------------------'),
    nl,
    write('*    DOMINIO INSTITUICAO DE ENSINO    *'),
    nl,
    write('---------------------------------------'),
    nl,
    write('Saindo!'),
    nl,
    abort.

executa( 1 ):-
    incluir_estudante.

executa( 2 ):-
    incluir_notas_do_estudante.

executa( 3 ):-
    localizar_estudante_pela_matricula.

executa( 4 ):-
    excluir_estudante_e_suas_notas.

executa( 5 ):-
    retractall(totalnotas(_)),
    assert(totalnotas(0)),
    retractall(cont(_)),
    assert(cont(0)),
    relatorio_dos_estudantes.

executa( 6 ):-
    salvar_dados.

executa( 7 ):-
    load.

executa( 8 ):-
    limpar_banco_de_dados.

/* op 1 inicio */
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
/* op 1 fim */

/* op 2 inicio */
incluir_notas_do_estudante:-
    write('---------------------------------------'),
    nl,
    write('Incluir Nota do Estudante'),
    nl,
    writeln('---------------------------------------'),
    nl,
    writeln('Informe a matricula do Estudante: '),
    read(Matricula),
    estudante(Matricula,_,_,_),
    writeln('Informe o Nome do Materia: '),
    read(Materia),
    writeln('Informe o Ano do Estudante: '),
    read(Ano),
    writeln('Informe a Nota do Estudante: '),
    read(Nota),
    assert(nota(Matricula,Materia,Ano,Nota)),
    nl,
    write('---------------------------------------'),
    nl,
    write('Nota do Estudante Incluir Com Sucesso'),
    nl,
    writeln('---------------------------------------'),
    nl,
    writeln('Digite algo para voltar:'),
    read(_).

incluir_notas_do_estudante:-
    nl,
    write('---------------------------------------'),
    nl,
    write('Matricula nao existe'),
    nl,
    writeln('---------------------------------------'),
    nl,
    writeln('Digite algo para voltar:'),
    read(_).
/* op 2 fim */

/* op 3 inicio */
localizar_estudante_pela_matricula:-
    write('---------------------------------------'),
    nl,
    write('Localizar Estudante pela Matricula'),
    nl,
    writeln('---------------------------------------'),
    nl,
    writeln('Informe a matricula do Estudante: '),
    read(Matricula),
    nl,
    localizar_estudante_pela_matricula(Matricula),
    nl,
    writeln('Digite algo para voltar:'),
    read(_).

localizar_estudante_pela_matricula(Matricula):-
    estudante(Matricula,Nome,data(Dia,Mes,Ano),Endereco),!,
    writef('matriculo do estudante: %t \n',[Matricula]),
    writef('Nome do aluno: %t \n',[Nome]),
    writef('data de nascimento %t / %t / %t \n',[Dia,Mes,Ano]),
    writef('Endereco do aluno: %t \n',[Endereco]),
    nl,
    retractall(quantidade_notas(_)),
    retractall(total_notas(_)),
    assert(quantidade_notas(0)),
    assert(total_notas(0)),
    suasnotas(Matricula).


localizar_estudante_pela_matricula(_):-
    nl,
    write('---------------------------------------'),
    nl,
    write('Matricula nao existe'),
    nl,
    writeln('---------------------------------------').

suasnotas(Matricula):-
    nota(Matricula,DIS,ANO,NOTA),
    retract(quantidade_notas(NOTAS_AC)),
    retract(total_notas(NOTAS_TOTAL)),
    NEW_NOTAS_AC is NOTAS_AC + 1,
    NEW_NOTAS_TOTAL is NOTAS_TOTAL + NOTA,
    assert(quantidade_notas(NEW_NOTAS_AC)),
    assert(total_notas(NEW_NOTAS_TOTAL)),
    writef('Disciplina: %t Ano: %t Nota: %t \n',[DIS,ANO,NOTA]),
    fail.

suasnotas(_):-
    retract(quantidade_notas(A)),
    retract(total_notas(B)),
    retract(cont(X)),
    MaisX is X + A,
    assert(cont(MaisX)),
    retract(totalnotas(F)),
    New_totalnotas is B + F,
    assert(totalnotas(New_totalnotas)),
    div_zero(A,B).

div_zero(0,_):-
    nl,
    write('---------------------------------------'),
    nl,
    write('Este aluno nao possui Notas'),
    nl,
    writeln('---------------------------------------'),!.

div_zero(A,B):-
    C is B / A,
    writef('total de notas: %t \n',[A]),
    writef('Nota media: %t \n',[C]),
    writeln('---------------------------------------'),
    nl.
/* op 3 fim */

/* op 4 inicio*/
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
/* op 4 fim*/

/* op 5 inicio */
relatorio_dos_estudantes:-
    estudante(Matricula,_,_,_),
    localizar_estudante_pela_matricula(Matricula),
    fail.

relatorio_dos_estudantes:-
    totalnotas(X),
    cont(B),
    zero(B,X),
    writeln('Digite algo para voltar:'),
    read(_).

zero(0,_):-
    nl,
    write('---------------------------------------'),
    nl,
    write('Nota geral media: 0'),
    nl,
    writeln('---------------------------------------'),
    nl,!.

zero(A,B):-
    C is B / A,
    writef('Nota geral media: %w \n',[C]),
    nl.
/* op 5 fim*/

/* op 6 inicio */
salva_estudante(A):-
    retract(estudante(Matricula, Nome, data(Dia, Mes, Ano), Endereco)),
    format(A,'estudante(\'~a\',\'~a\',data(~a,~a,~a),\'~a\').\n',
    [Matricula, Nome, Dia,Mes,Ano, Endereco]),
    fail.
salva_estudante(_).

salva_nota(A):-
    retract(nota(Matricula, Disciplina, Ano, Nota)),
    format(A,'nota(\'~a\',\'~a\',\'~a\',\'~a\').\n',
    [Matricula, Disciplina, Ano, Nota]),
    fail.
salva_nota(_).

salvar_dados:-
    write('---------------------------------------'),
    nl,
    write('Salvar dados em arquivo'),
    nl,
    write('---------------------------------------'),
    open('dadostrabalho1.pl', write, A),
    salva_estudante(A),
    salva_nota(A),
    close(A),
    nl,
    write('Dados salvos com sucesso.'),
    nl,
    write('Digite algo para voltar:'),
    read(_).
/* op6 fim */

/* op 7 inicio */
load:-
    [dadostrabalho1],
    write('---------------------------------------'),
    nl,
    write('Carregado com Sucesso'),
    nl,
    writeln('---------------------------------------'),
    nl,
    writeln('Digite algo para voltar:'),
    read(_).
/* op 7 fim */

/* op 8 inicio */
limpar_banco_de_dados:-
    retractall(estudante(_,_,_,_)),
    retractall(nota(_,_,_,_)),
    write('---------------------------------------'),
    nl,
    write('Banco de Dados Limpar com Sucesso'),
    nl,
    writeln('---------------------------------------'),
    nl,
    writeln('Digite algo para voltar:'),
    read(_).
/* op 8 fim */