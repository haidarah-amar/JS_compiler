lexer grammar JavaScriptLexer;
BREAK      : 'break';
CASE       : 'case';
CATCH      : 'catch';
CLASS      : 'class';
CONST      : 'const';
CONTINUE   : 'continue';
DEBUGGER   : 'debugger';
DEFAULT    : 'default';
DELETE     : 'delete';
DO         : 'do';
ELSE       : 'else';
EXPORT     : 'export';
EXTENDS    : 'extends';
FINALLY    : 'finally';
FOR        : 'for';
FUNCTION   : 'function';
IF         : 'if';
IMPORT     : 'import';
IN         : 'in';
INSTANCEOF : 'instanceof';
NEW        : 'new';
RETURN     : 'return';
SUPER      : 'super';
SWITCH     : 'switch';
THIS       : 'this';
THROW      : 'throw';
TRY        : 'try';
TYPEOF     : 'typeof';
VAR        : 'var';
VOID       : 'void';
WHILE      : 'while';
WITH       : 'with';
YIELD      : 'yield';
LET        : 'let';

TRUE  : 'true';
FALSE : 'false';
NULL  : 'null';

HEX_NUMBERS:'0' [xX] HexNumbers BigInt?;
OCT_NUMBERS:'0' [oO] OctNumber BigInt?;
BINAR_NUMBERS:'0' [bB] BinarNumber BigInt?;
FLOAT_NIMBERS : DecimalInteger '.' DecDigits? Exponent?|
               '.' DecDigits Exponent? |
               DecimalInteger Exponent;
DEC_NUMBERS:DecimalInteger BigInt?;


STRING_LITERAL
    : '"' (LINE_CONTINUATION | ESCAPE_SEQUENCE | ~["\\\r\n\u2028\u2029])* '"'
    | '\'' (LINE_CONTINUATION | ESCAPE_SEQUENCE | ~['\\\r\n\u2028\u2029])* '\''
    ;
UNTERMINATED_STRING
    : '"' (LINE_CONTINUATION | ESCAPE_SEQUENCE | ~["\\\r\n\u2028\u2029])*
    | '\'' (LINE_CONTINUATION | ESCAPE_SEQUENCE | ~['\\\r\n\u2028\u2029])*
    ;

IDENTIFIER
    : [a-zA-Z_$] [a-zA-Z0-9_$]*
    ;

SINGLE_LINE_COMMENT
    : '//' ~[\r\n]*
    ;

MULTI_LINE_COMMENT
    : '/*' .*? '*/'
    ;

STRICT_EQ : '===';
STRICT_NEQ: '!==';
EQUAL     : '==';
NOT_EQ    : '!=';
LTE       : '<=';
GTE       : '>=';
AND       : '&&';
OR        : '||';
INCREMENT : '++';
DECREMENT : '--';
COLON : ':';
QUESTION : '?';
ASSIGN : '=' -> pushMode(REGEX_ALLOWED_MODE);
PLUS_ASSIGN     : '+=';
MINUS_ASSIGN    : '-=';
MULT_ASSIGN     : '*=';
DIV_ASSIGN      : '/=';
MOD_ASSIGN      : '%=';
ARROW           : '=>';
PLUS        : '+';
MINUS       : '-';
MULTIPLY    : '*';
DIVIDE      : '/';
MODULUS     : '%';
LESS_THAN   : '<';
GREATER_THAN: '>';
NOT         : '!';

LPAREN    : '(';
RPAREN    : ')';
LBRACE    : '{';
RBRACE    : '}';
LBRACKET  : '[';
RBRACKET  : ']';
SEMI      : ';';
COMMA     : ',';
DOT       : '.';

WS
    : [ \t\r\n]+ -> skip
    ;


ERRCHAR
    : .;


REGEX_LITERAL
    : '/' RegexFirstChar RegexChar* '/' RegexFlags
    ;

fragment RegexFirstChar
    : ~[/\\\r\n\u2028\u2029]
    | '\\' ~[\r\n\u2028\u2029]
    ;

fragment RegexChar
    : ~[/\\\r\n\u2028\u2029]
    | '\\' ~[\r\n\u2028\u2029]
    | '[' RegexClassChar* ']'
    ;

fragment RegexClassChar
    : ~[\]\\\r\n\u2028\u2029]
    | '\\' ~[\r\n\u2028\u2029]
    ;

fragment RegexFlags
    : [dgimsuvy]*
    ;

fragment HEX_DIGIT
    : [0-9a-fA-F]
    ;

fragment LINE_CONTINUATION
    : '\\' ('\r\n' | [\r\n\u2028\u2029])
    ;

fragment ESCAPE_SEQUENCE
    : '\\' ~[\r\n\u2028\u2029]
    ;



    fragment HexNumbers:[0-9a-fA-F]+ ('_' [0-9a-fA-F]+)*;
    fragment OctNumber:[0-7]+ ('_' [0-7]+)*;
    fragment BinarNumber:[01]+ ('_' [01]+)*;
    fragment DecDigits : [0-9]+ ('_' [0-9]+)* ;
    fragment Exponent : [eE] [+-]? DecDigits;
    fragment BigInt:'n';
    fragment DecimalInteger
        : '0'
        | [1-9] [0-9]* ('_' [0-9]+)*
        ;
        mode REGEX_ALLOWED_MODE;

        REGEX_MODE_WS
            : [ \t\r\n]+ -> skip
            ;


        REGEX_MODE_LITERAL
            : '/' RegexFirstChar RegexChar* '/' RegexFlags
              -> type(REGEX_LITERAL), popMode
            ;


        REGEX_MODE_HEX
            : '0' [xX] HexNumbers BigInt?
              -> type(HEX_NUMBERS), popMode
            ;

        REGEX_MODE_OCT
            : '0' [oO] OctNumber BigInt?
              -> type(OCT_NUMBERS), popMode
            ;

        REGEX_MODE_BIN
            : '0' [bB] BinarNumber BigInt?
              -> type(BINAR_NUMBERS), popMode
            ;

        REGEX_MODE_FLOAT
            : (DecimalInteger '.' DecDigits? Exponent?
            | '.' DecDigits Exponent?
            | DecimalInteger Exponent)
              -> type(FLOAT_NIMBERS), popMode
            ;

        REGEX_MODE_DEC
            : DecimalInteger BigInt?
              -> type(DEC_NUMBERS), popMode
            ;


        REGEX_MODE_IDENTIFIER
            : [a-zA-Z_$] [a-zA-Z0-9_$]*
              -> type(IDENTIFIER), popMode
            ;


        REGEX_MODE_STRING
            : ('"' (LINE_CONTINUATION | ESCAPE_SEQUENCE | ~["\\\r\n\u2028\u2029])* '"'
            | '\'' (LINE_CONTINUATION | ESCAPE_SEQUENCE | ~['\\\r\n\u2028\u2029])* '\'')
              -> type(STRING_LITERAL), popMode
            ;
