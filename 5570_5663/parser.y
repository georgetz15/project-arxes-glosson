%{
#include <stdio.h>
    extern int yylineno;
    extern FILE* yyin;
%}
%define parse.error verbose
%locations
/* declared tokens */
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
