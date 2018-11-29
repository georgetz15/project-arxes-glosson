%{
#include "parser.tab.h"
%}

%option yylineno
%option bison-locations

%%
[0-9]                                               { return DIGIT; }
[A-Za-z]                                            { return LETTER; }
True                                                { return TRUE; }
False                                               { return FALSE; }
"Number"                                            { return NUM_TYPE; }
"DateTime"                                          { return DATETIME_TYPE; }
"Boolean"                                           { return BOOLEAN_TYPE; }
"String"                                            { return STRING_TYPE; }
"<!--"(([^-])|(-[^-]))*"-->"                        { return COMMENT; }
"<"                                                 { return OPEN_TAG; }
">"                                                 { return CLOSE_TAG; }
"/"                                                 { return SLASH; }
"-"                                                 { return MINUS; }
"+"                                                 { return PLUS; }
":"                                                 { return COLON; }
"="                                                 { return EQUAL; }
\"                                                  { return QUOTE; }
[.,#!$%\^&\*;{}=\-_`~()\[\]\\]                      { return PUNCTUATION; }
ss:element                                          { return ELEMENT; }
ss:Workbook                                         { return WORKBOOK; }
ss:Worksheet                                        { return WORKSHEET; }
ss:Styles                                           { return STYLES; }
ss:Style                                            { return STYLE; }
ss:ID                                               { return ID; }
ss:Table                                            { return TABLE; }
ss:Name                                             { return NAME; }
ss:Protected                                        { return PROTECTED; }
ss:Column                                           { return COLUMN; }
ss:Row                                              { return ROW; }
ss:ExpandedColumnCount                              { return EXP_COL_CNT; }
ss:ExpandedRowCount                                 { return EXP_ROW_CNT; }
ss:StyleID                                          { return STYLE_ID; }
ss:Hidden                                           { return HIDDEN; }
ss:Width                                            { return WIDTH; }
ss:Cell                                             { return CELL; }
ss:Height                                           { return HEIGHT; }
ss:Data                                             { return DATA; }
ss:MergeAcross                                      { return MERGEACROSS; }
ss:MergeDown                                        { return MERGEDOWN; }
ss:Type                                             { return TYPE; }
[ \n\t]+                                            { return WHITESPACE; }
.
%%