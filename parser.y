%{
#include <stdio.h>
    extern int yylineno;
    extern FILE* yyin;
%}
%define parse.error verbose
%locations

%union {
    char * str;
    int num;
}

/* declared token <str>s */
%token <str> DIGIT LETTER TRUE FALSE OPEN_TAG CLOSE_TAG SLASH ELEMENT
%token <str> WHITESPACE NUM_TYPE DATETIME_TYPE BOOLEAN_TYPE STRING_TYPE
%token <str> MINUS PLUS COLON PUNCTUATION COMMENT
%token <str> WORKBOOK
%token <str> WORKSHEET
%token <str> STYLES
%token <str> STYLE
%token <str> ID
%token <str> TABLE
%token <str> NAME
%token <str> PROTECTED
%token <str> COLUMN
%token <str> ROW
%token <str> EXP_COL_CNT
%token <str> EXP_ROW_CNT
%token <str> STYLE_ID
%token <str> HIDDEN
%token <str> WIDTH
%token <str> CELL
%token <str> HEIGHT
%token <str> DATA
%token <str> MERGEACROSS
%token <str> MERGEDOWN
%token <str> TYPE
%token <str> EQUAL
%token <str> QUOTE

%type <num> number
%type <str> word
%%
document: workbook  { printf("Document is fine!\n"); }
    ;
workbook: OPEN_TAG WORKBOOK CLOSE_TAG space worksheet_elements
        OPEN_TAG SLASH WORKBOOK CLOSE_TAG       { printf("workbook 1\n"); }
    | OPEN_TAG WORKBOOK CLOSE_TAG space styles space worksheet_elements
        OPEN_TAG SLASH WORKBOOK CLOSE_TAG    { printf("workbook 2\n"); }
    ;
styles: OPEN_TAG STYLES CLOSE_TAG
        space
        OPEN_TAG SLASH STYLES CLOSE_TAG                  { printf("styles 1\n"); }
    | OPEN_TAG STYLES CLOSE_TAG
        space style_elements
        OPEN_TAG SLASH STYLES CLOSE_TAG                  { printf("styles 2\n"); }
    ;
style_elements: style space                { printf("style_elements 1\n"); }
    | style_elements style space           { printf("style_elements 2\n"); }
    ;
style: OPEN_TAG STYLE whitespace-attr ID value_string CLOSE_TAG space
        OPEN_TAG SLASH STYLE CLOSE_TAG                  { printf("style\n"); }
    ;
worksheet: OPEN_TAG WORKSHEET worksheet_attr
        CLOSE_TAG space OPEN_TAG SLASH WORKSHEET CLOSE_TAG { printf("worksheet 1\n"); }
    | OPEN_TAG WORKSHEET worksheet_attr
        CLOSE_TAG space table_elements OPEN_TAG SLASH WORKSHEET CLOSE_TAG { printf("worksheet 2\n"); }
    ;
worksheet_attr: whitespace-attr NAME value_string space    { printf("worksheet_attr 1\n"); }
    | whitespace-attr NAME value_string protected_elements space { printf("worksheet_attr 2\n"); }
    | protected_elements whitespace-attr NAME value_string space { printf("worksheet_attr 2\n"); }
    ;
table_elements: table space                           { printf("table_elements 1\n"); }
    | table_elements table space                      { printf("table_elements 2\n"); }
    ;
table: OPEN_TAG TABLE table_attr CLOSE_TAG
        space
        OPEN_TAG SLASH TABLE CLOSE_TAG          { printf("table 1\n"); }
    | OPEN_TAG TABLE table_attr CLOSE_TAG
     space col_elements                
     OPEN_TAG SLASH TABLE CLOSE_TAG          { printf("table 2\n"); }
    | OPEN_TAG TABLE table_attr CLOSE_TAG
     space row_elements                
     OPEN_TAG SLASH TABLE CLOSE_TAG          { printf("table 3\n"); }
    | OPEN_TAG TABLE table_attr CLOSE_TAG
     space col_elements row_elements   
     OPEN_TAG SLASH TABLE CLOSE_TAG          { printf("table 4\n"); }
    ;
col_elements: column space                           { printf("col_elements1\n"); }
    | col_elements column space              { printf("col_elements2\n"); }
    ;
row_elements: row space                             { printf("row_elements 1\n"); }
    | row_elements row space                    { printf("row_elements 2\n"); }
    ;
column: OPEN_TAG COLUMN col_attr SLASH CLOSE_TAG  { printf("column\n"); }
    ;
row: OPEN_TAG ROW row_attr CLOSE_TAG
     cell_elements
     OPEN_TAG SLASH ROW CLOSE_TAG { printf("row\n"); }
    ;
cell_elements: space            { printf("cell_elements 1\n"); }
    | cell_elements cell space  { printf("cell_elements 2\n"); }
    ;
cell: OPEN_TAG CELL cell_attr CLOSE_TAG
     data_elements
     OPEN_TAG SLASH CELL CLOSE_TAG              { printf("cell\n"); }
    ;
data_elements: space                            { printf("data_elements 1\n");}
    |   data_elements data space                { printf("data_elements 2\n");}
    ;
data: OPEN_TAG DATA data_attr CLOSE_TAG
     string
     OPEN_TAG SLASH DATA CLOSE_TAG              { printf("data\n"); }
    ;
data_attr: whitespace-attr TYPE value_type           { printf("data_attr\n");}
    ;
cell_attr: space                                { printf("cell_attr\n");}
    | merge_across                              { printf("cell_attr\n"); }
    | style_id                                  { printf("cell_attr\n"); }
    | merge_down                                { printf("cell_attr\n"); }
    | merge_across style_id                     { printf("cell_attr\n"); }
    | merge_across merge_down                   { printf("cell_attr\n"); }
    | style_id merge_across                     { printf("cell_attr\n"); }
    | style_id merge_down                       { printf("cell_attr\n"); }
    | merge_down merge_across                   { printf("cell_attr\n"); }
    | merge_down style_id                       { printf("cell_attr\n"); }
    | merge_down style_id merge_across          { printf("cell_attr\n"); }
    | merge_down merge_across style_id          { printf("cell_attr\n"); }
    | style_id merge_down merge_across          { printf("cell_attr\n"); }
    | style_id merge_across merge_down          { printf("cell_attr\n"); }
    | merge_across style_id merge_down          { printf("cell_attr\n"); }
    | merge_across merge_down style_id          { printf("cell_attr\n"); }
    ;
merge_across: whitespace-attr MERGEACROSS value_integer              { printf("merge_across\n");}
    ;
merge_down: whitespace-attr MERGEDOWN value_integer                  { printf("merge_down\n");}
    ;
table_attr: space                               { printf("table_attr\n"); }
    | exp_col_cnt                               { printf("table_attr\n"); }
    | style_id                                  { printf("table_attr\n"); }
    | exp_row_cnt                               { printf("table_attr\n"); }
    | exp_col_cnt style_id                      { printf("table_attr\n"); }
    | exp_col_cnt exp_row_cnt                   { printf("table_attr\n"); }
    | style_id exp_col_cnt                      { printf("table_attr\n"); }
    | style_id exp_row_cnt                      { printf("table_attr\n"); }
    | exp_row_cnt exp_col_cnt                   { printf("table_attr\n"); }
    | exp_row_cnt style_id                      { printf("table_attr\n"); }
    | exp_row_cnt style_id exp_col_cnt          { printf("table_attr\n"); }
    | exp_row_cnt exp_col_cnt style_id          { printf("table_attr\n"); }
    | style_id exp_row_cnt exp_col_cnt          { printf("table_attr\n"); }
    | style_id exp_col_cnt exp_row_cnt          { printf("table_attr\n"); }
    | exp_col_cnt style_id exp_row_cnt          { printf("table_attr\n"); }
    | exp_col_cnt exp_row_cnt style_id          { printf("table_attr\n"); }
    ;
exp_col_cnt: whitespace-attr EXP_COL_CNT value_integer      { printf("exp_col_cnt\n"); }
    ;
exp_row_cnt: whitespace-attr EXP_ROW_CNT value_integer      { printf("exp_row_cnt\n"); }
    ;
col_attr: space                      { printf("col_attr\n"); }
    | hidden                         { printf("col_attr\n"); }
    | style_id                       { printf("col_attr\n"); }
    | width                          { printf("col_attr\n"); }
    | hidden style_id                { printf("col_attr\n"); }
    | hidden width                   { printf("col_attr\n"); }
    | style_id hidden                { printf("col_attr\n"); }
    | style_id width                 { printf("col_attr\n"); }
    | width hidden                   { printf("col_attr\n"); }
    | width style_id                 { printf("col_attr\n"); }
    | width style_id hidden          { printf("col_attr\n"); }
    | width hidden style_id          { printf("col_attr\n"); }
    | style_id width hidden          { printf("col_attr\n"); }
    | style_id hidden width          { printf("col_attr\n"); }
    | hidden style_id width          { printf("col_attr\n"); }
    | hidden width style_id          { printf("col_attr\n"); }
    ;
hidden: whitespace-attr HIDDEN value_boolean { printf("hidden\n"); }
    ;
width: whitespace-attr WIDTH value_integer { printf("width\n"); }
    ;
row_attr: space                       { printf("row_attr\n"); }
    | hidden                          { printf("row_attr\n"); }
    | style_id                        { printf("row_attr\n"); }
    | height                          { printf("row_attr\n"); }
    | hidden style_id                 { printf("row_attr\n"); }
    | hidden height                   { printf("row_attr\n"); }
    | style_id hidden                 { printf("row_attr\n"); }
    | style_id height                 { printf("row_attr\n"); }
    | height hidden                   { printf("row_attr\n"); }
    | height style_id                 { printf("row_attr\n"); }
    | height style_id hidden          { printf("row_attr\n"); }
    | height hidden style_id          { printf("row_attr\n"); }
    | style_id height hidden          { printf("row_attr\n"); }
    | style_id hidden height          { printf("row_attr\n"); }
    | hidden style_id height          { printf("row_attr\n"); }
    | hidden height style_id          { printf("row_attr\n"); }
    ;
height: whitespace-attr HEIGHT value_integer { printf("height\n"); }
    ;
style_id: whitespace-attr STYLE_ID value_string          { printf("style_id\n"); }
    ;
value_boolean: EQUAL QUOTE boolean QUOTE        { printf("value_boolean\n"); }
    ;
value_string: EQUAL QUOTE string QUOTE          { printf("value_string\n"); }
    ;
value_type: EQUAL QUOTE type QUOTE              { printf("value_type\n"); }
    ;
value_integer: EQUAL QUOTE number QUOTE         { printf("value_integer\n"); }
    ;
protected_elements: whitespace-attr PROTECTED value_boolean       { printf("protected_elements\n"); }
    ;
worksheet_elements: worksheet space  { printf("worksheet elements\n"); }
    | worksheet_elements worksheet space { printf("worksheet elements\n"); }
    ;
boolean: TRUE                   { printf("boolean\n"); }
    | FALSE                     { printf("boolean\n"); }
    ;
word: LETTER                    { printf("word %s\n", $1); free($1); }
    | word LETTER               { printf("word %s\n", $2); free($2); }
    ;
number: DIGIT                   { printf("number\n"); }
    | number DIGIT              { printf("number\n"); }
    ;
string:                         { printf("string\n"); }
    | string word               { printf("string\n"); }
    | string number             { printf("string\n"); }
    | string WHITESPACE         { printf("string\n"); }
    | string punctuation        { printf("string\n"); }
    ;
datetime: DIGIT DIGIT SLASH DIGIT DIGIT SLASH DIGIT DIGIT MINUS DIGIT DIGIT COLON DIGIT DIGIT COLON DIGIT DIGIT  { printf("datetime\n"); }
    ;
type: NUM_TYPE          { printf("type\n"); }
    | DATETIME_TYPE     { printf("type\n"); }
    | BOOLEAN_TYPE      { printf("type\n"); }
    | STRING_TYPE       { printf("type\n"); }
    ;
punctuation: PUNCTUATION    { printf("punctuation\n"); }
    | MINUS { printf("punctuation\n"); }
    | PLUS { printf("punctuation\n"); }
    | COLON { printf("punctuation\n"); }
    | SLASH { printf("punctuation\n"); }
    ;
space:                  { printf("space1\n"); }
    | WHITESPACE        { printf("space2\n"); }
    | space WHITESPACE  { printf("space2\n"); }
    ;
whitespace-attr: WHITESPACE 
    | whitespace-attr WHITESPACE
    ;
%%
int main(int argc, char **argv)
{
    yyin = fopen(argv[1], "r");
    yyparse();
}
int yyerror(char *s)
{
    fprintf(stderr, "Error: %s\n", s);
    fprintf(stderr, "Error in line: %d\n", yylineno);
}
