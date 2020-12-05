#include  <stdio.h>
#include  <sys/types.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define MAX_INPUT_SIZE 1024
#define MAX_TOKEN_SIZE 64
#define MAX_NUM_TOKENS 64

/* Splits the string by space and returns the array of tokens
*
*/
char **tokenize(char *line)
{
  char **tokens = (char **)malloc(MAX_NUM_TOKENS * sizeof(char *));
  char *token = (char *)malloc(MAX_TOKEN_SIZE * sizeof(char));
  int i, tokenIndex = 0, tokenNo = 0;

  for(i =0; i < strlen(line); i++){

    char readChar = line[i];

    if (readChar == ' ' || readChar == '\n' || readChar == '\t'){
      token[tokenIndex] = '\0';
      if (tokenIndex != 0){
  tokens[tokenNo] = (char*)malloc(MAX_TOKEN_SIZE*sizeof(char));
  strcpy(tokens[tokenNo++], token);
  tokenIndex = 0; 
      }
    } else {
      token[tokenIndex++] = readChar;
    }
  }
 
  free(token);
  tokens[tokenNo] = NULL ;
  return tokens;
}


void sequence (char ** tokens, int total_sq,int index,int * sq){
  if (index == total_sq ){
    return;
  }
  char *argv1[3];
  if (tokens[sq[index] + 2] == (NULL)) {
   argv1[0] = tokens[sq[index] + 1];
    //argv1[0] = tokens[ 0];
    argv1[1] = NULL;
    argv1[2] = NULL;
  }
  else if ( (!(strcmp( tokens[sq[index] + 2],"&&")))|| (tokens[sq[index] + 2] == (NULL) )) {//||index == total_sq - 1 ){//if command has one word
    //char *argv1[2];
    printf("%s. %s  %s  \n",tokens[sq[index]],tokens[sq[index] + 1],tokens[sq[index] + 2]);
  //if (!(strcmp( tokens[1],"&&"))){
   argv1[0] = tokens[sq[index] + 1];
    //argv1[0] = tokens[ 0];
    argv1[1] = NULL;
    argv1[2] = NULL;
  //  printf("in sequence if");
  }
  else{//if command has two word
    //char *argv1[3];     
    argv1[0] = tokens[sq[index] + 1];
    argv1[1] = tokens[sq[index] + 2];
    //argv1[0] = tokens[ 0];
    //argv1[1] = tokens[1];
    argv1[2] = NULL;
   // printf("in sequence else");
  }
   int rc = fork();
  if (rc < 0) { // fork failed; exit
    printf( "fork failed\n");
    exit(0);
  } 
  else if (rc == 0) { // child (new process)
    if (!(strcmp( argv1[0],"cd"))){//cd is present
      chdir( argv1[1]);
     } 
    else{
      int finished = execvp(argv1[0], argv1);
      if (finished == -1){
        printf("incorrect command %s",argv1[0]);
        exit(0);
      }
 
      //exit(1);
    }
    //exit(1);
  }
  else { // parent goes down this path (main)
    int wc = wait(NULL);
    
    index++;
    sequence(tokens, total_sq, index , sq);
   // printf( "completed process : %s \n",argv1[0]);
    
  }
    return;


  }


void first(char ** tokens, int total_sq,int index,int * sq){
  char *cmd = tokens[0];
  char *argv1[3];
  if (!(strcmp( tokens[1],"&&"))){//if command has one word
    //char *argv1[2];
    argv1[0] = tokens[0];
    argv1[1] = NULL;
    argv1[2] = NULL;

  }
  else{//if command has two word
    //char *argv1[3];     
    argv1[0] = tokens[0];
    argv1[1] = tokens[1];
    argv1[2] = NULL;
  }
  int rc = fork();
  if (rc < 0) { // fork failed; exit
    printf( "fork failed\n");
    exit(0);
  } 
  else if (rc == 0) { // child (new process)
    if (!(strcmp( argv1[0],"cd"))){//cd is present
      chdir( argv1[1]);
     } 
    else{
      int finished = execvp(argv1[0], argv1);
      if (finished == -1){
        printf("incorrect command %s",argv1[0]);
        exit(0);
      }
    //exit(1);
     }
  }
  else { // parent goes down this path (main)
    int wc = wait(NULL);
    sequence(tokens, total_sq, 0 , sq);
  }
      return;

          
}
void normal_case(char ** tokens){
  //printf( "fork failed\n");
  char *cmd = tokens[0];
  char *argv1[3];
  if (tokens[1] == NULL){//if command has one word
    //char *argv1[2];
    argv1[0] = tokens[0];
    argv1[1] = NULL;
    argv1[2] = NULL;

  }
  else{//if command has two word
    //char *argv1[3];     
    argv1[0] = tokens[0];
    argv1[1] = tokens[1];
    argv1[2] = NULL;
  }
  int rc = fork();
  if (rc < 0) { // fork failed; exit
    printf( "fork failed\n");
    exit(1);
  } 
  else if (rc == 0) { // child (new process)
    if (!(strcmp( argv1[0],"cd"))){//cd is present
      chdir( argv1[1]);
     } 
    else{
      int finished = execvp(argv1[0], argv1);
      if (finished == -1){
       printf( " incorrect command");
       exit(1);
      }
      
    }
  }
  else { // parent goes down this path (main)
    int wc = wait(NULL);
    printf( "completed process : %s \n",argv1[0]);
  }
  
    return;
         //argv[1] = NULL;
}

int main(int argc, char* argv[]) {
  char  line[MAX_INPUT_SIZE];            
  char  **tokens;              
  int i;

  FILE* fp;
  if(argc == 2) {
    fp = fopen(argv[1],"r");
    if(fp < 0) {
      printf("File doesn't exists.");
      return -1;
    }
  }

  while(1) {      
    /* BEGIN: TAKING INPUT */
    bzero(line, sizeof(line));
    if(argc == 2) { // batch mode
      if(fgets(line, sizeof(line), fp) == NULL) { // file reading finished
        break;  
      }
      line[strlen(line) - 1] = '\0';
    } else { // interactive mode
      printf("$ ");
      scanf("%[^\n]", line);
      getchar();
    }
    //printf("Command entered: %s\n", line);
    /* END: TAKING INPUT */

    line[strlen(line)] = '\n'; //terminate with new line
    tokens = tokenize(line);
     //////////devesh_start////////////////////////// 
    int indicator = 0;//0 if nothing is present.//1 if & is present and execution in background. //2 if && is present and we have to do sequencing in forground.//3 if &&& is present and we have to do parallel in foreground
    int index_bg = 0;//all are initialized to 0
    int total_sq= 0;
    int total_pll= 0; 
    int bg[64] = {0};//all are initialized to 0
    int sq[64] = {0};
    int pll[64] = {0};
    //deciding what has came
    for(int i = 0 ; tokens[i]!= NULL; i++){
        if(!(strcmp(tokens[i],"&"))){
           bg[index_bg] = i;
           index_bg = index_bg+1;
           indicator = 1;

        }
        if(!(strcmp(tokens[i],"&&"))){
           sq[total_sq] = i;
           total_sq = total_sq+1;
           indicator = 2;
          
        }        

        if(!(strcmp(tokens[i],"&&&"))){
           pll[total_pll] = i;
           total_pll = total_pll+1;
           indicator = 3;
          
        }
    }
    int index = 0;
    if(indicator == 0){
      normal_case(tokens);
    }

     else if (indicator == 2 ){
      //sequence
      first(tokens, total_sq, index , sq);
    
     }


     //////////devesh_end////////////////////////// 

    for(i=0;tokens[i]!=NULL;i++){
      //printf("found token %s\n", tokens[i]);
    }
       
    // Freeing the allocated memory 
    for(i=0;tokens[i]!=NULL;i++){
      free(tokens[i]);
    }
    free(tokens);

  }
  return 0;
}