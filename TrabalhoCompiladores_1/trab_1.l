%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef struct TokenNode {
    char classe[50];
    char lexema[100];
    struct TokenNode *prox;
} TokenNode;

TokenNode *inicio = NULL;
TokenNode *fim = NULL;

void adicionar_token(const char* classe, const char* lexema){
    TokenNode *novo = (TokenNode*) malloc(sizeof(TokenNode));
    strcpy(novo->classe, classe);
    strcpy(novo->lexema, lexema);

    if(inicio == NULL){
        inicio = novo;
        fim = novo;
    }
    else{
        fim->prox = novo;
        fim = novo;
    }
}

void imprimir_lista() {
    printf("\n--- TABELA DE TOKENS ---\n");
    TokenNode *atual = inicio;
    while (atual != NULL) {
        printf("[ %-15s ] -> Valor: %s\n", atual->classe, atual->lexema);
        atual = atual->prox;
    }
    printf("------------------------\n");
}

%}

    //definicoes LEX
DIGITO          [0-9]
LETRA           [a-zA-Z]

IDENTIFICADOR   {LETRA}({LETRA}|{DIGITO}|"_")*
RESERVADA       ("while"|"for"|"if"|"else"|"do"|"int"|"void"|"float"|"double"|"long"|"than"|"bool"|"char"|"string"|"return"|"break"|"struct"|"type"|"static"|"const"|"def"|"import"|"try"|"catch"|"throw")
INTEIRO         ("+"|"-")?{DIGITO}+
FLOAT           {INTEIRO}*"."{DIGITO}+
STRING          "\""([^\"\n])*\""
CHAR            "\'"({LETRA}|{DIGITO})"\'"
OPERADORARIT    ("+"|"-"|"\\"|":"|"x"|"\."|"*"|"++"|"--")
OPERADORREL     ("=="|"!="|">"|"<"|">="|"<=")
OPERADORLOG     ("&&"|"||"|"!")
OPERADORATRIB   ("+="|"-="|"*="|"/="|"=")
SEPARADORES     (","|"."|";"|":")

%%

{RESERVADA}     { adicionar_token("TK_RESERVADA", yytext); coluna += yyleng; }
{IDENTIFICADOR} { adicionar_token("TK_IDENTIFICADOR", yytext); coluna += yyleng; }
{FLOAT}         { adicionar_token("TK_FLOAT", yytext); coluna += yyleng; }
{INTEIRO}       { adicionar_token("TK_INTEIRO", yytext); coluna += yyleng; }
{STRING}        { adicionar_token("TK_STRING", yytext); coluna += yyleng; }
{CHAR}          { adicionar_token("TK_CHAR", yytext); coluna += yyleng; }
{OPERADORARIT}  { adicionar_token("TK_OP_ARITMETICO", yytext); coluna += yyleng; }
{OPERADORREL}   { adicionar_token("TK_OP_RELACIONAL", yytext); coluna += yyleng; }
{OPERADORLOG}   { adicionar_token("TK_OP_LOGICO", yytext); coluna += yyleng; }
{OPERADORATRIB} { adicionar_token("TK_OP_ATRIBUICAO", yytext); coluna += yyleng; }
[\(\)]          { adicionar_token("TK_PARENTESES", yytext); coluna += yyleng; }
[\{\}]          { adicionar_token("TK_CHAVES", yytext); coluna += yyleng; }
[\[\]]          { adicionar_token("TK_COLCHETES", yytext); coluna += yyleng; }
{SEPARADORES}   { adicionar_token("TK_PONTUACAO", yytext); coluna += yyleng; }
"//".* { }
[ \t]+          { coluna += yyleng; }
\n              { linha++; coluna = 1; }
.               { printf(">> ERRO LEXICO: Caractere invalido '%s' encontrado na linha %d, coluna %d\n", yytext, linha, coluna); coluna += yyleng; }

%%

//SubRotinas

int yywrap(){
    return 1;
}

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            printf("Erro ao abrir o arquivo %s\n", argv[1]);
            return 1;
        }
        yyin = file;
    } else {
        printf("Por favor, informe o arquivo de entrada.\nExemplo: ./analisador fonte1.txt\n");
        return 1;
    }

    printf("Iniciando analise lexica...\n\n");
    yylex();
    imprimir_lista();

    return 0;
}