%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int linha = 1;
int coluna = 1;
FILE *arquivo_saida = NULL;

typedef struct TokenNode {
    char lexema[100];
    char classe[100];
    struct TokenNode *prox;
} TokenNode;

TokenNode *inicio = NULL;
TokenNode *fim = NULL;

void adicionar_token(const char* lexema, const char* classe){
    TokenNode *novo = (TokenNode*) malloc(sizeof(TokenNode));
    strcpy(novo->lexema, lexema);
    strcpy(novo->classe, classe);
    novo->prox = NULL;

    if(inicio == NULL){
        inicio = novo;
        fim = novo;
    }
    else{
        fim->prox = novo;
        fim = novo;
    }
}

void registrar_erro(const char* lexema, const char* razao) {
    char msg[100];
    sprintf(msg, "ERRO: %s (L:%d, C:%d)", razao, linha, coluna);
    adicionar_token(lexema, msg);
}

void imprimir_lista() {
    if(!arquivo_saida) return;
    
    fprintf(arquivo_saida, "%-25s | %-35s\n", "Lexema", "Token");
    fprintf(arquivo_saida, "--------------------------+------------------------------------\n");

    TokenNode *atual = inicio;
    while (atual != NULL) {
        fprintf(arquivo_saida, "%-25s | %-35s\n", atual->lexema, atual->classe);
        atual = atual->prox;
    }
}
%}

DIGITO          [0-9]
LETRA           [a-zA-Z]

IDENTIFICADOR   {LETRA}({LETRA}|{DIGITO}|"_")*
RESERVADA       ("while"|"for"|"if"|"else"|"do"|"int"|"void"|"float"|"double"|"long"|"than"|"bool"|"char"|"string"|"return"|"break"|"struct"|"type"|"static"|"const"|"def"|"import"|"try"|"catch"|"throw")
INTEIRO         ("+"|"-")?{DIGITO}+
FLOAT           {INTEIRO}*"."{DIGITO}+
STRING          \"[^\n\"]*\"
CHAR            \'({LETRA}|{DIGITO})\'
OPERADORARIT    ("+"|"-"|"\\"|":"|"x"|"."|"*"|"++"|"--")
OPERADORREL     ("=="|"!="|">"|"<"|">="|"<=")
OPERADORLOG     ("&&"|"||"|"!")
OPERADORATRIB   ("+="|"-="|"*="|"/="|"=")
SEPARADORES     (","|"."|";"|":")

%%

{RESERVADA}     { adicionar_token(yytext, "TK_RESERVADA"); coluna += yyleng; }
{IDENTIFICADOR} { adicionar_token(yytext, "TK_IDENTIFICADOR"); coluna += yyleng; }
{FLOAT}         { adicionar_token(yytext, "TK_FLOAT"); coluna += yyleng; }
{INTEIRO}       { adicionar_token(yytext, "TK_INTEIRO"); coluna += yyleng; }
{STRING}        { adicionar_token(yytext, "TK_STRING"); coluna += yyleng; }
{CHAR}          { adicionar_token(yytext, "TK_CHAR"); coluna += yyleng; }
{OPERADORARIT}  { adicionar_token(yytext, "TK_OP_ARITMETICO"); coluna += yyleng; }
{OPERADORREL}   { adicionar_token(yytext, "TK_OP_RELACIONAL"); coluna += yyleng; }
{OPERADORLOG}   { adicionar_token(yytext, "TK_OP_LOGICO"); coluna += yyleng; }
{OPERADORATRIB} { adicionar_token(yytext, "TK_OP_ATRIBUICAO"); coluna += yyleng; }
[\(\)]          { adicionar_token(yytext, "TK_PARENTESES"); coluna += yyleng; }
[\{\}]          { adicionar_token(yytext, "TK_CHAVES"); coluna += yyleng; }
[\[\]]          { adicionar_token(yytext, "TK_COLCHETES"); coluna += yyleng; }
{SEPARADORES}   { adicionar_token(yytext, "TK_PONTUACAO"); coluna += yyleng; }

"//".* { }

{DIGITO}+({LETRA}|"_")+({LETRA}|{DIGITO}|"_")* { 
    registrar_erro(yytext, "Identificador malformado");
    coluna += yyleng;
}

\"[^\"\n]*\n    { 
    yytext[yyleng-1] = '\0'; 
    registrar_erro(yytext, "String nao fechada");
    linha++; coluna = 1; 
}

{DIGITO}+"."    { 
    registrar_erro(yytext, "Float sem casas decimais");
    coluna += yyleng;
}

[ \t]+          { coluna += yyleng; }

\n              { linha++; coluna = 1; }

.               { 
    registrar_erro(yytext, "Caractere invalido");
    coluna += yyleng; 
}

%%

int yywrap(){
    return 1;
}

int main() {
    char nome_arquivo[100];
    char nome_saida[120];

    printf("-----------------------------------------\n");
    printf("Digite o nome do arquivo fonte para ler:\n> ");
    scanf("%s", nome_arquivo);

    FILE *file = fopen(nome_arquivo, "r");
    if (!file) {
        printf("ERRO: O arquivo '%s' nao foi encontrado.\n", nome_arquivo);
        return 1;
    }
    yyin = file; 

    sprintf(nome_saida, "saida_%s", nome_arquivo);
    arquivo_saida = fopen(nome_saida, "w");

    printf("\nProcessando tokens e erros...\n");
    
    yylex();
    imprimir_lista();

    fclose(file);
    if(arquivo_saida) fclose(arquivo_saida);

    printf("CONCLUIDO! Tabela gerada sem impressoes no terminal.\n");
    printf("Verifique o arquivo: %s\n", nome_saida);
    printf("-----------------------------------------\n");

    return 0;
}