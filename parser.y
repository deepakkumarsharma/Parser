%{
#include <cstdio>
#include<string.h>
#include <iostream>
FILE *output;
char buffer[100]="";
using namespace std;



// stuff from flex that bison needs to know about:

extern "C" int yylex();

extern "C" int yyparse();

extern "C" FILE *yyin;

 

void yyerror(const char *s);

%}



// Bison fundamentally works by asking flex to get the next token, which it

// returns as an object of type "yystype".  But tokens could be of any

// arbitrary data type!  So we deal with that in Bison by defining a C union

// holding each of the types of tokens that Flex could return, and have Bison

// use that union instead of "int" for the definition of "yystype":

%union {

    int ival;

    float fval;

    char *sval;
    char *brace;

}



// define the "terminal symbol" token types I'm going to use (in CAPS

// by convention), and associate each with a field of the union:

%token <ival> INT

%token <fval> FLOAT

%token <sval> STRING

%token <brace> OPEN

%token <brace> CLOSE

%token SPHERE
%token CYLINDER
%token BOX
%%

// this is the actual grammar that bison will parse, but for right now it's just

// something silly to echo to the screen what bison gets from flex.  We'll

// make a real one shortly:
bison:
    |
    SPHERE open point length close bison{fputs("ball",output);}
    | CYLINDER open point point length close bison{fputs("Cylinder sells like shells ",output);}
    | BOX open length length length point angle close bison{fputs("Box the faux",output);}
    ;
open:
    OPEN STRING {sprintf(buffer,"{ %s ",$2);fputs(buffer,output);}
    ;   
close:
    STRING CLOSE {sprintf(buffer," %s }",$1);fputs(buffer,output);}
    ;
point:  
    number number number {fputs(" Points \t",output);}
    ;
angle:
    number {fputs("",output);}
    ;   
    ;
length:
    number {fputs("",output);}
    ;
number:
    INT { sprintf(buffer,"%d ",$1);;fputs(buffer,output);bzero(buffer,100);}
    | FLOAT { sprintf(buffer,"%f ",$1);fputs(buffer,output);bzero(buffer,100);}
    ;

%%



int main(int count,char **str) {

    // open a file handle to a particular file:

    FILE *myfile = fopen(str[1], "r");

    // make sure it is valid:

    if (!myfile) {

        cout << "I can't open a.snazzle.file!" << endl;

        return -1;

    }
        output = fopen("output", "w");
    if(!output)
    cout<<"SOOOOOOOOOOOOOOOOOOOOOOOO";
    

        // make sure it is valid:

        if (!myfile) {

                cout << "I can't open a.snazzle.file!" << endl;

                return -1;

        }

    // set flex to read from it instead of defaulting to STDIN:

    yyin = myfile;

    

    // parse through the input until there is no more:

    do {

        yyparse();

    } while (!feof(yyin));
    fclose(output);
    

}



void yyerror(const char *s) {

    cout << "EEK, parse error!  Message: " << s << endl;

    // might as well halt now:

    exit(-1);

}
