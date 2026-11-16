lexer grammar ValarinLexer;

@lexer::header {
import java.text.Normalizer;
}

HARDWARE : 'makhallam';
SETUP : 'athara';
LOOP : 'nashkad';
CONST : 'athara_ne';
FUNCTION : 'ayanuz';
RETURN : 'ayanuz_ne';
IF : 'makhan_ra';
ELSE : 'makhan_ra_nu';
SWITCH : 'makhan_sha_ka';
CASE : 'makhan_sha_za';
WHILE : 'nashkad_ra';
DO : 'nashkad_ta';
FOR : 'nashkad_mi_ri';
REPEAT : 'nashkad_ka';
BREAK : 'nashkad_ne';
CONTINUE : 'nashkad_ri';
INT_TYPE : 'ayan_ka';
UINT_TYPE : 'ayan_ka_nu';
FLOAT : 'ullu';
IN : 'delguma';
BOOL_TYPE : 'makhan_ka';
LEVEL_TYPE : 'ithir_ka';
TIME_TYPE : 'athara_ka';
TEXT_TYPE : 'akashan_ka';
OPTIONAL_BYTE_TYPE : 'akashan_ka_sha';
VOID : 'ayanuz_nu';
TRUE : 'makhan_za';
FALSE : 'makhan_nu';
HIGH : 'ithir_za';
LOW : 'ithir_nu';
AND : 'makhan_ya';
OR : 'makhan_sha';
NOT : 'nu';
ACTION : 'ayanuz_ta';
TO : 'makhallam_ri';
DIGITAL_WRITE : 'ithir_ta';
ANALOG_WRITE : 'ullu_ta';
DELAY : 'athara_nu';
DIGITAL_READ : 'ithir_ra';
ANALOG_READ : 'ullu_ra';
SERIAL_PRINT : 'akashan';
SERIAL_PRINTLN : 'akashan_ne';
SERIAL_BEGIN : 'akashan_mi';
SERIAL_READ : 'akashan_ra';
SERIAL_WRITE : 'akashan_ta';
MILLIS : 'athara_ra';
DIGITAL_PIN : 'makhallam_ka';
ANALOG_PIN : 'makhallam_ka_ullu';
INPUT : 'makhallam_ra';
INPUT_PULLUP: 'makhallam_ra_za';
OUTPUT : 'makhallam_ta';
ANALOG_INPUT : 'makhallam_ullu_ra';
PWM_OUTPUT : 'makhallam_ullu_ta';
BIT_AND : 'ayan_ya';
BIT_OR : 'ayan_sha';
BIT_XOR : 'ayan_sha_nu';
BIT_NOT : 'ayan_nu';
SHIFT_LEFT : 'ayan_kha';
SHIFT_RIGHT : 'ayan_tha';

EQ : '==';
NEQ : '!=';
LE : '<=';
GE : '>=';
ASSIGN : '=';
LT : '<';
GT : '>';
PLUS : '+';
MINUS : '-';
STAR : '*';
SLASH : '/';
PERCENT : '%';
COLON : ':';
SEMI : ';';
COMMA : ',';
LPAREN : '(';
RPAREN : ')';
LBRACE : '{';
RBRACE : '}';
LBRACK : '[';
RBRACK : ']';

FLOAT_LITERAL
    : DEC '.' DIGIT+ EXPOENTE?
    | DEC EXPOENTE
    ;
INT_LITERAL
    : DEC
    | '0b' [01]+
    | '0x' HEX+
    ;
STRING_LITERAL
    : '"' ( ~["\\\r\n\u0000] | '\\' [nrt"\\] )* '"'
    ;

IDENTIFIER
    : [\p{L}_] [\p{L}\p{M}\p{Nd}_]*
      { setText(Normalizer.normalize(getText(), Normalizer.Form.NFC)); }
    ;

LINE_COMMENT : '//' ~[\r\n]* -> skip ;
BLOCK_COMMENT : '/*' .*? '*/' -> skip ;
WS : [ \t\r\n]+ -> skip ;

INVALID_NUMBER
    : '0' [xb] CANDIDATO_CHAR*
    | DIGIT [0-9.]* ( [eE] [+\-] )? CANDIDATO_CHAR*
    ;
INVALID_STRING
    : '"' ( '\\' ~[\r\n] | ~["\\\r\n] )* ( '"' | '\\' )?
    ;
UNTERMINATED_COMMENT
    : '/*' ( ~'*' | '*'+ ~[*/] )* '*'*
    ;
INVALID_CHAR : . ;

fragment DIGIT : [0-9] ;
fragment DEC : '0' | [1-9] DIGIT* ;
fragment HEX : [0-9a-fA-F] ;
fragment EXPOENTE : [eE] [+\-]? DIGIT+ ;
fragment CANDIDATO_CHAR : [\p{L}\p{M}\p{Nd}_.] ;
