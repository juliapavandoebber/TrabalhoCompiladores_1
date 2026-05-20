%{
#include <stdio.h>
%}

    //definicoes LEX


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