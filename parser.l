%{
#include <cstdio>
#include<iostream>
using namespace std;
#define YY_DECL extern "C" int yylex()

#include "parser.tab.h"
%}
%%
"Sphere"        {return SPHERE;}
"Cylinder"      {return CYLINDER;}   
"Box"           {return BOX;}
[ \t\n]         ;
[0-9]+		{yylval.ival = atof(yytext); return INT;}
[0-9]+\.[0-9]+  {yylval.fval = atoi(yytext); return FLOAT;}
[a-zA-Z0-9]+    { yylval.sval = strdup(yytext); return STRING; }
[(]		{ yylval.brace = strdup(yytext); return OPEN;}
[)]		{ yylval.brace = strdup(yytext); return CLOSE;}
[,]		;
%%
