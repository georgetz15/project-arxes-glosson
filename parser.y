/* simplest version of calculator */
%{
#include <stdio.h>
%}
/* declare tokens */
%token DIGIT LETTER TRUE FALSE OPEN_TAG CLOSE_TAG SLASH ELEMENT
%token WHITESPACE NUM_TYPE DATETIME_TYPE BOOLEAN_TYPE STRING_TYPE
%token MINUS PLUS COLON PUNCTUATION COMMENT
%token WORKBOOK
%token WORKSHEET
%token STYLES
%token STYLE
%token ID
%token TABLE
%token NAME
%token PROTECTED
%token COLUMN
%token ROW
%token EXP_COL_CNT
%token EXP_ROW_CNT
%token STYLE_ID
%token HIDDEN
%token WIDTH
%token CELL
%token HEIGHT
%token DATA
%token MERGEACROSS
%token MERGEDOWN
%token TYPE
%token EQUAL
%token QUOTE
%%
document: table space
    | document space table space
    ;
workbook: OPEN_TAG WORKBOOK CLOSE_TAG space worksheet_elements space
        OPEN_TAG SLASH WORKBOOK CLOSE_TAG       { printf("workbook\n"); }
    | OPEN_TAG WORKBOOK CLOSE_TAG space styles space worksheet_elements space
        OPEN_TAG SLASH WORKBOOK CLOSE_TAG    { printf("workbook\n"); }
    ;
worksheet: OPEN_TAG WORKSHEET WHITESPACE NAME value_string protected_elements
        CLOSE_TAG space table_elements space OPEN_TAG SLASH WORKSHEET CLOSE_TAG
        { printf("worksheet\n"); }
    ;
table_elements:                           { printf("table_elements\n"); }
    | table_elements space table          { printf("table_elements\n"); }
    ;
table: OPEN_TAG TABLE table_attr CLOSE_TAG
        table_contents
        OPEN_TAG SLASH TABLE CLOSE_TAG          { printf("table\n"); }
    ;
table_contents: space col_elements row_elements space { printf("table_contents 4\n"); }
    ;
table_attr:                                     { printf("table_attr\n"); }
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
exp_col_cnt:                                    { printf("exp_col_cnt\n"); }
    | WHITESPACE EXP_COL_CNT value_integer      { printf("exp_col_cnt\n"); }
    ;
exp_row_cnt:                                    { printf("exp_row_cnt\n"); }
    | WHITESPACE EXP_ROW_CNT value_integer      { printf("exp_row_cnt\n"); }
    ;
style_id:                                       { printf("style_id\n"); }
    | WHITESPACE STYLE_ID value_string          { printf("style_id\n"); }
    ;
col_elements:                                   { printf("col_elements\n"); }
    | col_elements space column                 { printf("col_elements\n"); }
    ;
row_elements:                                   { printf("row_elements\n"); }
    | row_elements space row                    { printf("row_elements\n"); }
    ;
column: OPEN_TAG COLUMN col_attr SLASH CLOSE_TAG  { printf("column\n"); }
    ;
col_attr:                            { printf("col_attr\n"); }
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
hidden:         { printf("hidden\n"); }
    | WHITESPACE HIDDEN value_boolean { printf("hidden\n"); }
    ;
width:          { printf("width\n"); }
    | WHITESPACE WIDTH value_integer { printf("width\n"); }
    ;
row: OPEN_TAG ROW row_attr CLOSE_TAG
     space cell_elements space
     OPEN_TAG SLASH ROW CLOSE_TAG { printf("row\n"); }                                         { printf("row\n"); }
    ;
row_attr:                            { printf("row_attr\n"); }
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
height:     { printf("height\n"); }
    | WHITESPACE HEIGHT value_integer { printf("height\n"); }
    ;
cell_elements:  { printf("cell_elements\n"); }
    | cell_elements space cell { printf("cell_elements\n"); }
    ;
cell: CELL { printf("cell\n"); }
    ;
value_boolean: EQUAL QUOTE boolean QUOTE        { printf("value_boolean\n"); }
    ;
value_string: EQUAL QUOTE string QUOTE          { printf("value_string\n"); }
    ;
value_type: EQUAL QUOTE type QUOTE              { printf("value_type\n"); }
    ;
value_integer: EQUAL QUOTE number QUOTE         { printf("value_integer\n"); }
    ;
protected_elements:                 { printf("protected_elements\n"); }
    | WHITESPACE PROTECTED value_boolean       { printf("protected_elements\n"); }
    ;
worksheet_elements: worksheet   { printf("worksheet elements\n"); }
    | worksheet_elements space worksheet { printf("worksheet elements\n"); }
    ;
styles: OPEN_TAG STYLES CLOSE_TAG space style_elements space
        OPEN_TAG SLASH STYLES CLOSE_TAG                  { printf("styles\n"); }
    ;
style_elements:                 { printf("style_elements\n"); }
    | style_elements space style { printf("style_elements\n"); }
    ;
style: OPEN_TAG STYLE WHITESPACE ID value_string CLOSE_TAG space
        OPEN_TAG SLASH STYLE CLOSE_TAG                  { printf("style\n"); }
    ;
boolean: TRUE                   { printf("boolean\n"); }
    | FALSE                     { printf("boolean\n"); }
    ;
word: LETTER                    { printf("word\n"); }
    | word LETTER               { printf("word\n"); }
    ;
number: DIGIT                   { printf("number\n"); }
    | number DIGIT              { printf("number\n"); }
    ;
string:                         { printf("string\n"); }
    | string word               { printf("string\n"); }
    | string number             { printf("string\n"); }
    | string WHITESPACE         { printf("string\n"); }
    ;
element: OPEN_TAG ELEMENT CLOSE_TAG string OPEN_TAG SLASH ELEMENT CLOSE_TAG  { printf("element\n"); }
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
space:              { printf("space\n"); }
    | WHITESPACE    { printf("space\n"); }
    ;
comment: COMMENT { printf("comment\n"); }
    ;
%%
int main(int argc, char **argv)
{
  yyparse();
}
yyerror(char *s)
{
  fprintf(stderr, "error: %s\n", s);
}