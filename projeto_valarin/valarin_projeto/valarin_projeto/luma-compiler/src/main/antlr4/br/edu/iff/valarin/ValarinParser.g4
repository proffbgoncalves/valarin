parser grammar ValarinParser;

options { tokenVocab = ValarinLexer; }

programa
    : blocoRecursos
      declaracaoGlobal*
      declaracaoFuncao*
      blocoSetup
      blocoLoop
      EOF
    ;

blocoRecursos : HARDWARE IN LBRACE declaracaoRecurso* RBRACE ;
blocoSetup    : SETUP bloco ;
blocoLoop     : LOOP bloco ;

declaracaoRecurso
    : tipoRecurso IDENTIFIER ASSIGN construtorPino (COLON expressao)? SEMI
    ;

tipoRecurso
    : OUTPUT 
    | INPUT 
    | INPUT_PULLUP 
    | ANALOG_INPUT 
    | PWM_OUTPUT
    ;

construtorPino
    : (DIGITAL_PIN | ANALOG_PIN) LPAREN INT_LITERAL RPAREN
    ;

declaracaoGlobal
    : CONST tipo IDENTIFIER ASSIGN expressao SEMI
    | tipo IDENTIFIER (ASSIGN expressao)? SEMI
    ;

declaracaoFuncao
    : FUNCTION tipoRetorno IDENTIFIER LPAREN listaParametros? RPAREN bloco
    ;

tipoRetorno : tipo | VOID ;

listaParametros : parametro (COMMA parametro)* ;

parametro : (tipo | tipoRecurso) IDENTIFIER ;

tipo
    : tipoEscalar
    | tipoVetor
    ;

tipoEscalar
    : tipoInteiro
    | FLOAT
    | BOOL_TYPE
    | LEVEL_TYPE
    | TIME_TYPE (LT MILLIS GT)?
    | TEXT_TYPE
    | OPTIONAL_BYTE_TYPE
    ;

tipoInteiro
    : (INT_TYPE | UINT_TYPE) (LT INT_LITERAL GT)?
    ;

tipoVetor
    : LBRACK tipoEscalar SEMI INT_LITERAL RBRACK
    ;

bloco : IN LBRACE itemBloco* RBRACE ;

itemBloco
    : declaracaoLocal
    | comando
    ;

declaracaoLocal
    : CONST tipo IDENTIFIER ASSIGN expressao SEMI
    | tipo IDENTIFIER ASSIGN expressao SEMI
    ;

comando
    : atribuicao SEMI
    | SERIAL_BEGIN INT_LITERAL SEMI
    | ACTION acao SEMI
    | comandoIf
    | comandoSwitch
    | comandoWhile
    | comandoDoWhile
    | comandoFor
    | comandoRepeat
    | BREAK SEMI
    | CONTINUE SEMI
    | RETURN expressao? SEMI
    ;

atribuicao : alvo ASSIGN expressao ;

alvo : IDENTIFIER (LBRACK expressao RBRACK)? ;

acao
    : (SERIAL_PRINT | SERIAL_PRINTLN | SERIAL_WRITE) expressao
    | DELAY expressao
    | (DIGITAL_WRITE | ANALOG_WRITE) expressao TO IDENTIFIER
    | chamada
    ;

chamada : IDENTIFIER LPAREN argumentos? RPAREN ;

argumentos : expressao (COMMA expressao)* ;

comandoIf
    : IF expressao (TO IDENTIFIER)? bloco (ELSE bloco)?
    ;

comandoSwitch
    : SWITCH expressao IN LBRACE casoSwitch+ padraoSwitch? RBRACE
    ;

casoSwitch   : CASE expressao bloco ;
padraoSwitch : ELSE bloco ;

comandoWhile   : WHILE expressao bloco ;

comandoDoWhile : DO bloco WHILE expressao SEMI ;

comandoRepeat  : REPEAT expressao bloco ;

comandoFor
    : FOR LPAREN forInicio? SEMI expressao? SEMI forAtualizacao? RPAREN bloco
    ;

forInicio
    : tipo IDENTIFIER ASSIGN expressao
    | atribuicao
    | ACTION chamada
    ;

forAtualizacao
    : atribuicao
    | ACTION chamada
    ;

expressao : expressaoOu ;

expressaoOu : expressaoE (OR expressaoE)* ;

expressaoE : expressaoComparacao (AND expressaoComparacao)* ;

expressaoComparacao
    : expressaoSoma ((EQ | NEQ | LT | LE | GT | GE) expressaoSoma)?
    ;

expressaoSoma : expressaoMultiplicacao ((PLUS | MINUS) expressaoMultiplicacao)* ;

expressaoMultiplicacao
    : expressaoUnaria ((STAR | SLASH | PERCENT) expressaoUnaria)*
    ;

expressaoUnaria
    : (NOT | MINUS) expressaoUnaria
    | expressaoPrimaria
    ;

expressaoPrimaria
    : INT_LITERAL
    | FLOAT_LITERAL
    | STRING_LITERAL
    | TRUE
    | FALSE
    | HIGH
    | LOW
    | MILLIS
    | SERIAL_READ
    | (DIGITAL_READ | ANALOG_READ) IDENTIFIER
    | construtorDuracao
    | conversao
    | operacaoBits
    | chamada
    | IDENTIFIER LBRACK expressao RBRACK
    | IDENTIFIER
    | listaVetorial
    | LPAREN expressao RPAREN
    ;

construtorDuracao
    : TIME_TYPE LPAREN INT_LITERAL COMMA INT_LITERAL RPAREN
    ;

conversao
    : (tipoInteiro | FLOAT) LPAREN expressao RPAREN
    ;

operacaoBits
    : (BIT_AND | BIT_OR | BIT_XOR | SHIFT_LEFT | SHIFT_RIGHT)
          larguraBits LPAREN expressao COMMA expressao RPAREN
    | BIT_NOT larguraBits LPAREN expressao RPAREN
    ;

larguraBits : LT INT_LITERAL GT ;

listaVetorial
    : LBRACK (expressao (COMMA expressao)*)? RBRACK
    ;