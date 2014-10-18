1. flex parser.l 
2. bison -d parser.y 
3. g++ parser.tab.c lex.yy.c -lfl -o task 
4. ./task myfile
