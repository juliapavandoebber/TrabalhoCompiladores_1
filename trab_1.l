%{
#include <stdio.h>
%}

    //definicoes LEX
DIGITO          [0-9]
LETRA           [a-zA-Z]

IDENTIFICADOR   {LETRA}({LETRA}|{DIGITO}|"_")*
RESERVADA       ("while"|"for"|"if"|"else"|"do"|"int"|"void"|"float"|"double"|"long"|"than"|"bool"|"char"|"string"|"return"|"break"|"struct"|"type"|"static"|"const"|"def"|"import"|"try"|"catch"|"throw")
INTEIRO         ("+"|"-")?{DIGITO}+
FLOAT           {INTEIRO}*"."{DIGITO}+
STRING          "\""({LETRA}|{DIGITO})*"\""
CHAR            "\'"({LETRA}|{DIGITO})"\'"
OPERADORARIT    ("+"|"-"|"\\"|":"|"x"|"\."|"*"|"++"|"--")
OPERADORREL     ("=="|"!="|">"|"<"|">="|"<=")
OPERADORLOG     ("&&"|"||"|"!")
OPERADORATRIB   ("+="|"-="|"*="|"/="|"=")
ESCOPO          ("\("|"\)"|"\{"|"\}"|"\["|"\]")
SEPARADORES     (","|"."|";"|":")
COMENTARIO      ("\//"|"\/*"|"\*/")
ERRO            .

%%
    /*regras*/
{IDENTIFICADOR}    {
    printf("digito: %d\n", yytext);
}

{RESERVADA}    {
    printf("digito: %d\n", yytext);
}

{INTEIRO}    {
    printf("digito: %d\n", yytext);
}

{FLOAT}    {
    printf("digito: %d\n", yytext);
}

{STRING}    {
    printf("digito: %d\n", yytext);
}

{CHAR}    {
    printf("digito: %d\n", yytext);
}

{OPERADORARIT}    {
    printf("digito: %d\n", yytext);
}

{OPERADORREL}    {
    printf("digito: %d\n", yytext);
}

{OPERADORLOG}    {
    printf("digito: %d\n", yytext);
}


{OPERADORATRIB}    {
    printf("digito: %d\n", yytext);
}

{ESCOPO}    {
    printf("digito: %d\n", yytext);
}

{SEPARADORES}    {
    printf("digito: %d\n", yytext);
}

{COMENTARIO}    {
    printf("digito: %d\n", yytext);
}

{ERRO}    {
    printf("digito: %d\n", yytext);
}
%%

//SubRotinas

int yywrap(){
    return 1;
}

int main(){
    yylex();
    return 0;
}