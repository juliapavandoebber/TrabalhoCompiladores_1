%{
#include <stdio.h>
%}

    //definicoes LEX
NUMERO          [0-9]+
PALAVRA         [a-zA-Z]+

IDENTIFICADOR   {PALAVRA}({PALAVRA}|{NUMERO}|"_")*
RESERVADA       ("")
OPERADORARIT    ("+"|"-"|"\\"|":"|"x"|"\."|"*")
OPERADORLOG     ("&&"|"||"|"!")
OPERADORREL     ("=="|"!="|">"|"<"|">="|"<=")

%%
    /*regras*/


%%

//SubRotinas

int yywrap(){
    return 1;
}

int main(){
    yylex();
    return 0;
}