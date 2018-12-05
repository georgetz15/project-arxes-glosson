%{
#include "parser.tab.h"
%}

%option yylineno
%option bison-locations


%%
[0-9]                                               { yylval->str = strdup(yytext); return DIGIT; }
[A-Za-z]                                            { yylval->str = strdup(yytext); return LETTER; }
True                                                { yylval->str = strdup(yytext); return TRUE; }
False                                               { yylval->str = strdup(yytext); return FALSE; }
"Number"                                            { yylval->str = strdup(yytext); return NUM_TYPE; }
"DateTime"                                          { yylval->str = strdup(yytext); return DATETIME_TYPE; }
"Boolean"                                           { yylval->str = strdup(yytext); return BOOLEAN_TYPE; }
"String"                                            { yylval->str = strdup(yytext); return STRING_TYPE; }
"<!--"(([^-])|(-[^-]))*"-->"                        { /*do nothig*/}
"<"                                                 { yylval->str = strdup(yytext); return OPEN_TAG; }
">"                                                 { yylval->str = strdup(yytext); return CLOSE_TAG; }
"/"                                                 { yylval->str = strdup(yytext); return SLASH; }
"-"                                                 { yylval->str = strdup(yytext); return MINUS; }
"+"                                                 { yylval->str = strdup(yytext); return PLUS; }
":"                                                 { yylval->str = strdup(yytext); return COLON; }
"="                                                 { yylval->str = strdup(yytext); return EQUAL; }
\"                                                  { yylval->str = strdup(yytext); return QUOTE; }
[.,#!$%\^&\*;{}=\-_`~()\[\]\\]                      { yylval->str = strdup(yytext); return PUNCTUATION; }
ss:element                                          { yylval->str = strdup(yytext); return ELEMENT; }
ss:Workbook                                         { yylval->str = strdup(yytext); return WORKBOOK; }
ss:Worksheet                                        { yylval->str = strdup(yytext); return WORKSHEET; }
ss:Styles                                           { yylval->str = strdup(yytext); return STYLES; }
ss:Style                                            { yylval->str = strdup(yytext); return STYLE; }
ss:ID                                               { yylval->str = strdup(yytext); return ID; }
ss:Table                                            { yylval->str = strdup(yytext); return TABLE; }
ss:Name                                             { yylval->str = strdup(yytext); return NAME; }
ss:Protected                                        { yylval->str = strdup(yytext); return PROTECTED; }
ss:Column                                           { yylval->str = strdup(yytext); return COLUMN; }
ss:Row                                              { yylval->str = strdup(yytext); return ROW; }
ss:ExpandedColumnCount                              { yylval->str = strdup(yytext); return EXP_COL_CNT; }
ss:ExpandedRowCount                                 { yylval->str = strdup(yytext); return EXP_ROW_CNT; }
ss:StyleID                                          { yylval->str = strdup(yytext); return STYLE_ID; }
ss:Hidden                                           { yylval->str = strdup(yytext); return HIDDEN; }
ss:Width                                            { yylval->str = strdup(yytext); return WIDTH; }
ss:Cell                                             { yylval->str = strdup(yytext); return CELL; }
ss:Height                                           { yylval->str = strdup(yytext); return HEIGHT; }
ss:Data                                             { yylval->str = strdup(yytext); return DATA; }
ss:MergeAcross                                      { yylval->str = strdup(yytext); return MERGEACROSS; }
ss:MergeDown                                        { yylval->str = strdup(yytext); return MERGEDOWN; }
ss:Type                                             { yylval->str = strdup(yytext); return TYPE; }
[ \n\t]+                                            { yylval->str = strdup(yytext); return WHITESPACE; }
.
%%