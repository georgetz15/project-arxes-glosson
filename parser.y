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
document: workbook  
    ;
workbook: OPEN_TAG WORKBOOK CLOSE_TAG space worksheet_elements
        OPEN_TAG SLASH WORKBOOK CLOSE_TAG       
    | OPEN_TAG WORKBOOK CLOSE_TAG space styles space worksheet_elements
        OPEN_TAG SLASH WORKBOOK CLOSE_TAG    
    ;
styles: OPEN_TAG STYLES CLOSE_TAG
        space
        OPEN_TAG SLASH STYLES CLOSE_TAG                  
    | OPEN_TAG STYLES CLOSE_TAG
        space style_elements
        OPEN_TAG SLASH STYLES CLOSE_TAG                  
    ;
style_elements: style space                
    | style_elements style space           
    ;
style: OPEN_TAG STYLE whitespace-attr ID value_string CLOSE_TAG space
        OPEN_TAG SLASH STYLE CLOSE_TAG                  
    ;
worksheet: OPEN_TAG WORKSHEET worksheet_attr
        CLOSE_TAG space OPEN_TAG SLASH WORKSHEET CLOSE_TAG 
    | OPEN_TAG WORKSHEET worksheet_attr
        CLOSE_TAG space table_elements OPEN_TAG SLASH WORKSHEET CLOSE_TAG 
    ;
worksheet_attr: whitespace-attr NAME value_string space    
    | whitespace-attr NAME value_string protected_elements space 
    | protected_elements whitespace-attr NAME value_string space 
    ;
table_elements: table space                           
    | table_elements table space                      
    ;
table: OPEN_TAG TABLE table_attr CLOSE_TAG
        space
        OPEN_TAG SLASH TABLE CLOSE_TAG          
    | OPEN_TAG TABLE table_attr CLOSE_TAG
     space col_elements                
     OPEN_TAG SLASH TABLE CLOSE_TAG          
    | OPEN_TAG TABLE table_attr CLOSE_TAG
     space row_elements                
     OPEN_TAG SLASH TABLE CLOSE_TAG          
    | OPEN_TAG TABLE table_attr CLOSE_TAG
     space col_elements row_elements   
     OPEN_TAG SLASH TABLE CLOSE_TAG          
    ;
col_elements: column space                            
    | col_elements column space              
    ;
row_elements: row space                             
    | row_elements row space                    
    ;
column: OPEN_TAG COLUMN col_attr SLASH CLOSE_TAG  
    ;
row: OPEN_TAG ROW row_attr CLOSE_TAG
     cell_elements
     OPEN_TAG SLASH ROW CLOSE_TAG 
    ;
cell_elements: space            
    | cell_elements cell space  
    ;
cell: OPEN_TAG CELL cell_attr CLOSE_TAG
     data_elements
     OPEN_TAG SLASH CELL CLOSE_TAG              
    ;
data_elements: space                            
    |   data_elements data space                
    ;
data: OPEN_TAG DATA data_attr CLOSE_TAG
     string
<<<<<<< HEAD
     OPEN_TAG SLASH DATA CLOSE_TAG              
    ;
data_attr: whitespace-attr TYPE value_type           
    ;
cell_attr: space                                
    | merge_across                              
    | style_id                                  
    | merge_down                                
    | merge_across style_id                     
    | merge_across merge_down                   
    | style_id merge_across                     
    | style_id merge_down                       
    | merge_down merge_across                   
    | merge_down style_id                       
    | merge_down style_id merge_across          
    | merge_down merge_across style_id          
    | style_id merge_down merge_across          
    | style_id merge_across merge_down          
    | merge_across style_id merge_down          
    | merge_across merge_down style_id          
    ;
merge_across: whitespace-attr MERGEACROSS value_integer              
    ;
merge_down: whitespace-attr MERGEDOWN value_integer                  
    ;
table_attr: space                               
    | exp_col_cnt                               
    | style_id                                  
    | exp_row_cnt                               
    | exp_col_cnt style_id                      
    | exp_col_cnt exp_row_cnt                   
    | style_id exp_col_cnt                      
    | style_id exp_row_cnt                      
    | exp_row_cnt exp_col_cnt                   
    | exp_row_cnt style_id                      
    | exp_row_cnt style_id exp_col_cnt          
    | exp_row_cnt exp_col_cnt style_id          
    | style_id exp_row_cnt exp_col_cnt          
    | style_id exp_col_cnt exp_row_cnt          
    | exp_col_cnt style_id exp_row_cnt          
    | exp_col_cnt exp_row_cnt style_id          
    ;
exp_col_cnt: whitespace-attr EXP_COL_CNT value_integer      
    ;
exp_row_cnt: whitespace-attr EXP_ROW_CNT value_integer      
    ;
col_attr: space                      
    | hidden                         
    | style_id                       
    | width                          
    | hidden style_id                
    | hidden width                   
    | style_id hidden                
    | style_id width                 
    | width hidden                   
    | width style_id                 
    | width style_id hidden          
    | width hidden style_id          
    | style_id width hidden          
    | style_id hidden width          
    | hidden style_id width          
    | hidden width style_id          
    ;
hidden: whitespace-attr HIDDEN value_boolean 
    ;
width: whitespace-attr WIDTH value_integer 
    ;
row_attr: space                       
    | hidden                          
    | style_id                        
    | height                          
    | hidden style_id                 
    | hidden height                   
    | style_id hidden                 
    | style_id height                 
    | height hidden                   
    | height style_id                 
    | height style_id hidden          
    | height hidden style_id          
    | style_id height hidden          
    | style_id hidden height          
    | hidden style_id height          
    | hidden height style_id          
    ;
height: whitespace-attr HEIGHT value_integer 
    ;
style_id: whitespace-attr STYLE_ID value_string          
    ;
value_boolean: EQUAL QUOTE boolean QUOTE        
    ;
value_string: EQUAL QUOTE string QUOTE          
    ;
value_type: EQUAL QUOTE type QUOTE              
    ;
value_integer: EQUAL QUOTE number QUOTE         
    ;
protected_elements: whitespace-attr PROTECTED value_boolean       
    ;
worksheet_elements: worksheet space  
    | worksheet_elements worksheet space 
    ;
boolean: TRUE                   
    | FALSE                     
    ;
word: LETTER                    
    | word LETTER               
    ;
number: DIGIT                   
    | number DIGIT              
    ;
string:                         
    | string word               
    | string number             
    | string WHITESPACE         
    | string punctuation        
=======
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
>>>>>>> ba136a33cc81c36e94fc2e616ebef5d0a6c4c83a
    ;
datetime: DIGIT DIGIT SLASH DIGIT DIGIT SLASH DIGIT DIGIT MINUS DIGIT DIGIT COLON DIGIT DIGIT COLON DIGIT DIGIT  { printf("datetime\n"); }
    ;
type: NUM_TYPE          
    | DATETIME_TYPE     
    | BOOLEAN_TYPE      
    | STRING_TYPE       
    ;
punctuation: PUNCTUATION    
    | MINUS 
    | PLUS 
    | COLON 
    | SLASH 
    ;
space:                  
    | WHITESPACE        
    | space WHITESPACE  
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
