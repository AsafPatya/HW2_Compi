%{
#include "parser.tab.hpp"
#include "output.hpp"
%}

%option yylineno
%option noyywrap
digit   		                              ([0-9])
letter  		                              ([a-zA-Z])
no_new_line                                   [\x00-\x09\x0b-\x0c\x0e-\x7f]
whitespace                                    ([\t\n\r ])
comment                                       (\/\/{no_new_line}*)

%%

void                                          return VOID;
int                                           return INT;
byte                                          return BYTE;
b                                             return B;
bool                                          return BOOL;
auto                                          return AUTO;
and                                           return AND;
or                                            return OR;
not                                           return NOT;
true                                          return TRUE;
false                                         return FALSE;
return                                        return RETURN;
if                                            return IF;
else                                          return ELSE;
while                                         return WHILE;
break                                         return BREAK;
continue                                      return CONTINUE;
;                                             return SC;
,                                             return COMMA;
(\()                                          return LPAREN;
(\))                                          return RPAREN;
(\{)                                          return LBRACE;
(\})                                          return RBRACE;
=                                             return ASSIGN;
!=|==                                         return EQUALITY;
([<>]=?)                                      return RELATIONAL;
(\+|\-)                                       return ADDITIVE;
(\*|\/)                                       return MULTIPLICATIVE;
{letter}({letter}|{digit})*                   return ID;
[1-9]{digit}*|0                               return NUM;
\"([^\n\r\"\\]|\\[rnt"\\])+\"                 return STRING;
{whitespace}|{comment}                        ;
.                                             {output::errorLex(yylineno); exit(0);};
%%
