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

BIGINT
    : ('0' [xX] HEX_DIGIT+
      | '0' [oO] [0-7]+
      | [0-9]+) 'n'
    ;

HEX_NUMBER
    : '0' [xX] HEX_DIGIT+
    ;

OCTAL_NUMBER
    : '0' [oO] [0-7]+
    ;

FLOAT
    : ([0-9]+ '.' [0-9]* | '.' [0-9]+)
      ([eE] [+-]? [0-9]+)?
    | [0-9]+ [eE] [+-]? [0-9]+
    ;

INTEGER
    : [0-9]+
    ;


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

ASSIGN      : '=';
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


fragment HEX_DIGIT
    : [0-9a-fA-F]
    ;

fragment LINE_CONTINUATION
    : '\\' ('\r\n' | [\r\n\u2028\u2029])
    ;

fragment ESCAPE_SEQUENCE
    : '\\' ~[\r\n\u2028\u2029]
    ;