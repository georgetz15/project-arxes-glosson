%{
#include "parser.tab.h"
%}

%option yylineno
%option bison-locations


%%
[0-9]                                               { /* yylval->str = strdup(yytext + 1); */ return DIGIT; }
[A-Za-z]                                            { /* yylval->str = strdup(yytext + 1); */ return LETTER; }
True                                                { /* yylval->str = strdup(yytext + 1); */ return TRUE; }
False                                               { /* yylval->str = strdup(yytext + 1); */ return FALSE; }
"Number"                                            { /* yylval->str = strdup(yytext + 1); */ return NUM_TYPE; }
"DateTime"                                          { /* yylval->str = strdup(yytext + 1); */ return DATETIME_TYPE; }
"Boolean"                                           { /* yylval->str = strdup(yytext + 1); */ return BOOLEAN_TYPE; }
"String"                                            { /* yylval->str = strdup(yytext + 1); */ return STRING_TYPE; }
"<!--"(([^-])|(-[^-]))*"-->"                        { /*do nothig*/}
"<"                                                 { /* yylval->str = strdup(yytext + 1); */ return OPEN_TAG; }
">"                                                 { /* yylval->str = strdup(yytext + 1); */ return CLOSE_TAG; }
"/"                                                 { /* yylval->str = strdup(yytext + 1); */ return SLASH; }
"-"                                                 { /* yylval->str = strdup(yytext + 1); */ return MINUS; }
"+"                                                 { /* yylval->str = strdup(yytext + 1); */ return PLUS; }
":"                                                 { /* yylval->str = strdup(yytext + 1); */ return COLON; }
"="                                                 { /* yylval->str = strdup(yytext + 1); */ return EQUAL; }
\"                                                  { /* yylval->str = strdup(yytext + 1); */ return QUOTE; }
[.,#!$%\^&\*;{}=\-_`~()\[\]\\]                      { /* yylval->str = strdup(yytext + 1); */ return PUNCTUATION; }
ss:element                                          { /* yylval->str = strdup(yytext + 1); */ return ELEMENT; }
ss:Workbook                                         { /* yylval->str = strdup(yytext + 1); */ return WORKBOOK; }
ss:Worksheet                                        { /* yylval->str = strdup(yytext + 1); */ return WORKSHEET; }
ss:Styles                                           { /* yylval->str = strdup(yytext + 1); */ return STYLES; }
ss:Style                                            { /* yylval->str = strdup(yytext + 1); */ return STYLE; }
ss:ID                                               { /* yylval->str = strdup(yytext + 1); */ return ID; }
ss:Table                                            { /* yylval->str = strdup(yytext + 1); */ return TABLE; }
ss:Name                                             { /* yylval->str = strdup(yytext + 1); */ return NAME; }
ss:Protected                                        { /* yylval->str = strdup(yytext + 1); */ return PROTECTED; }
ss:Column                                           { /* yylval->str = strdup(yytext + 1); */ return COLUMN; }
ss:Row                                              { /* yylval->str = strdup(yytext + 1); */ return ROW; }
ss:ExpandedColumnCount                              { /* yylval->str = strdup(yytext + 1); */ return EXP_COL_CNT; }
ss:ExpandedRowCount                                 { /* yylval->str = strdup(yytext + 1); */ return EXP_ROW_CNT; }
ss:StyleID                                          { /* yylval->str = strdup(yytext + 1); */ return STYLE_ID; }
ss:Hidden                                           { /* yylval->str = strdup(yytext + 1); */ return HIDDEN; }
ss:Width                                            { /* yylval->str = strdup(yytext + 1); */ return WIDTH; }
ss:Cell                                             { /* yylval->str = strdup(yytext + 1); */ return CELL; }
ss:Height                                           { /* yylval->str = strdup(yytext + 1); */ return HEIGHT; }
ss:Data                                             { /* yylval->str = strdup(yytext + 1); */ return DATA; }
ss:MergeAcross                                      { /* yylval->str = strdup(yytext + 1); */ return MERGEACROSS; }
ss:MergeDown                                        { /* yylval->str = strdup(yytext + 1); */ return MERGEDOWN; }
ss:Type                                             { /* yylval->str = strdup(yytext + 1); */ return TYPE; }
[ \n\t]+                                            { /* yylval->str = strdup(yytext + 1); */ return WHITESPACE; }
.
%%