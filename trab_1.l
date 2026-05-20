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
    printf("identificador: %d\n", yytext);
}

{RESERVADA}    {
    printf("palavra reservada: %d\n", yytext);
}

{INTEIRO}    {
    printf("inteiro: %d\n", yytext);
}

{FLOAT}    {
    printf("float: %d\n", yytext);
}

{STRING}    {
    printf("string: %d\n", yytext);
}

{CHAR}    {
    printf("char: %d\n", yytext);
}

{OPERADORARIT}    {
    printf("operador aritmetico: %d\n", yytext);
}

{OPERADORREL}    {
    printf("operador relacional: %d\n", yytext);
}

{OPERADORLOG}    {
    printf("operador logico: %d\n", yytext);
}

{OPERADORATRIB}    {
    printf("operador atribuicao: %d\n", yytext);
}

{ESCOPO}    {
    printf("escopo: %d\n", yytext);
}

{SEPARADORES}    {
    printf("separadores: %d\n", yytext);
}

{COMENTARIO}    {
    printf("comentario: %d\n", yytext);
}

{ERRO}    {
    printf("erroneous: %d\n", yytext);
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