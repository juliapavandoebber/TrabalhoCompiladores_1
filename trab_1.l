%{
#include <stdio.h>
%}

    //definicoes LEX
DIGITO          [0-9]
NATURAIS        [0-9]+
INTEIROS        ("+"|"-"){NATURAIS}
REAIS           [0-9]*\.[0-9]+
LETRA           [a-zA-Z]
IDENTIFICADOR   {LETRA}({LETRA}|{DIGITO}|"_")*
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