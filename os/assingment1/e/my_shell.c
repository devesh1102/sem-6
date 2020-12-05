#include  <stdio.h>
#include  <sys/types.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define MAX_INPUT_SIZE 1024
#define MAX_TOKEN_SIZE 64
#define MAX_NUM_TOKENS 64
   pid_t back,fore;
int is_pressed  = 0;
  int first_back = 0;
  int first_fore = 0;
    int child = 0;
/* Splits the string by space and returns the array of tokens
*
*/
void fore_terminate(int dummy){
    is_pressed  = 1;

    //printf("this is goodddddd\n");
    killpg(fore, 9);
    return;
}
int  find_end (char ** tokens, int start){//start should point to ls
  int end = start;
for( int i = 0; i< 10 ; i++){ 
  if ( tokens[start + i] == NULL){
    return end;
  }
  if ((!(strcmp( tokens[start + i],"&&"))) || (!(strcmp( tokens[start + i],"&"))) || (!(strcmp( tokens[start + i],"&&&")))  ){
    return end;
  }
  if ((!(strcmp( tokens[start + i],"exit"))) ){
    return -2;
  }
  end = end +1;
  }
  return -1;
}
void kill_background() {
  //printf("%d\n",child);
  if (child != 0){
  killpg(back, 9);
 }
  return;
}
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

//////////////////////////sequencing/start/////////////////////////
int sequence (char ** tokens, int total_sq,int index,int * sq){
  if (index == total_sq ){
    return 0 ;
  }
        int start =sq[index] +1 ;
        int end = find_end(tokens,start);
        if (end  == -2){
          kill_background();
          return -1;
        }
          char *argv1[end - start +1];
        

        for (int i = 0; i < end - start; i++){
         argv1[i] = tokens[start +i];

        }
        argv1[end - start] =NULL;
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
      setpgid(getpid(), fore);
      int finished = execvp(argv1[0], argv1);
      if (finished == -1){
        printf("incorrect command \n");
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
    return 0 ;


  }


int sq_first(char ** tokens, int total_sq,int index,int * sq){
    if (tokens[0] != NULL){
    if (!(strcmp( tokens[0],"exit"))){
      kill_background();
      return -1;
    }
  }
  int x = 0 ;
  char *cmd = tokens[0];
        int start = 0;
        int end = find_end(tokens,start);
          char *argv1[end - start +1];

        for (int i = 0; i < end - start; i++){
         argv1[i] = tokens[start +i];

        }
        argv1[end - start] =NULL;
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
      setpgrp();
      fore = getpid();
      int finished = execvp(argv1[0], argv1);
      if (finished == -1){
        printf("incorrect command\n ");
        exit(0);
      }
    //exit(1);
     }
  }

  else { // parent goes down this path (main)
    fore =rc;
    int wc = wait(NULL);
     x = sequence(tokens, total_sq, 0 , sq);
  }
      return x ;

          
}

//////////////////////////sequencing/end/////////////////////////
//////////////////////////normal/start/////////////////////////

int normal_case(char ** tokens){

  int rc = fork();
  if (rc < 0) { // fork failed; exit
    printf( "fork failed\n");
    exit(1);
  } 
  else if (rc == 0) { // child (new process)
    setpgrp();
    fore = getpid();

   // printf("child pid%d\n",getpid());
    //printf("child pgid%d\n",getpgid(getpid()));
    //printf("fork%d\n",fore);
    if (!(strcmp( tokens[0],"cd"))){//cd is present
      chdir( tokens[1]);
     } 
    else{

      int finished = execvp(tokens[0], tokens);
      if (finished == -1){
        if((strcmp( tokens[0],"exit"))){
       printf( " incorrect command\n");}
       exit(1);
      }
      
    }
  }
  else { // parent goes down this path (main)e
    fore = rc;
      //printf( "fork failed\n")
  if (tokens[0] != NULL){
    if (!(strcmp( tokens[0],"exit"))){
      int wc = wait(NULL);
      kill_background();
      
      return -1;
    }
  }
    int wc = wait(NULL);
    //printf("parent pid%d\n",getpid());
   // printf("parent pgid%d\n",getpgid(getpid()));

  //  printf("fork%d\n",fore);

  }
  
    return 0 ;
         //argv[1] = NULL;
}
//////////////////////////normal/end/////////////////////////
//////////////////////////background/start/////////////////////////

int background (char ** tokens){
        int status;
        int start = 0;
        int end = find_end(tokens,start);
        if (end == -2){//exit detected
           kill_background() ;
          return -1;
        }
        char *argv1[end - start +1];

        for (int i = 0; i < end - start; i++){
         argv1[i] = tokens[start +i];

        }
        argv1[end - start] =NULL;

       // printf( "fork failed\n");
      int rc = fork();
      if (rc < 0) { // fork failed; exit
          printf( "fork failed\n");
          exit(0);
        } 
        else if (rc == 0) { // child (new process)
          if (first_back == 0){
            setpgrp();
            back = getpid();
            first_back = 1;
         //   printf("%d first \n",back);
          //  printf("%d first \n",getpid());
          }
          else {
            setpgid(getpid(), back);
         //   printf("%d second \n",back);
         //   printf("%d second \n",getpid());
          }
          if (!(strcmp( argv1[0],"cd"))){//cd is present
            chdir( argv1[1]);
            } 
          else{
            int finished = execvp(argv1[0], argv1);
              if (finished == -1){
                printf("incorrect command \n");
                exit(0);
              }
          }
        }
  else { // parent goes down this path (main)
    if (first_back == 0){
      back = rc;
      first_back = 1;
    }
    
    
  }
  return 0 ;
}
//////////////////////////background/end/////////////////////////
//////////////////////////parallel/start/////////////////////////
void parallel (char ** tokens, int total_sq,int index,int * sq){
  if (index == total_sq ){
    return;
  }
        int start =sq[index] +1 ;
        int end = find_end(tokens,start);
          char *argv1[end - start +1];

        for (int i = 0; i < end - start; i++){
         argv1[i] = tokens[start +i];

        }
        argv1[end - start] =NULL;
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
      setpgid(getpid(), fore);
      int finished = execvp(argv1[0], argv1);
      if (finished == -1){
        printf("incorrect command\n");
        exit(0);
      }
 
      //exit(1);
    }
    //exit(1);
  }
  else { // parent goes down this path (main)
    index++;
    parallel(tokens, total_sq, index , sq);
    int wc = wait(NULL);
  }
    return;


  }


void parallel_first (char ** tokens, int total_sq,int index,int * sq){
 char *cmd = tokens[0];
        int start = 0;
        int end = find_end(tokens,start);
          char *argv1[end - start +1];

        for (int i = 0; i < end - start; i++){
         argv1[i] = tokens[start +i];

        }
        argv1[end - start] =NULL;
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
      fore = getpid();
      int finished = execvp(argv1[0], argv1);
      if (finished == -1){
        printf("incorrect command\n ");
        exit(0);
      }
    //exit(1);
     }
  }

  else { // parent goes down this path (main)
    fore = rc;
    parallel(tokens, total_sq, 0 , sq);
    int wc = wait(NULL);
  }
      return;
}

//////////////////////////parallel/end/////////////////////////

int main(int argc, char* argv[]) {
  char  line[MAX_INPUT_SIZE];            
  char  **tokens;              
  int i;

  FILE* fp;
  if(argc == 2) {
    fp = fopen(argv[1],"r");
    if(fp < 0) {
      printf("File doesn't exists.\n");
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
    signal(SIGINT, fore_terminate);
    //deciding what has came
    for(int i = 0 ; tokens[i]!= NULL; i++){
        if(!(strcmp(tokens[i],"&"))){
           bg[index_bg] = i;
           index_bg = index_bg+1;
           indicator = 1;
           //free(tokens[i]);
           //tokens[i] = NULL;

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
    //    printf("%s\n",tokens[i] );
    }
    int index = 0;
    int x = 2;


    if(indicator == 0){
      x = normal_case(tokens);
    }

     else if (indicator == 2 ){
      //sequenc(e
      //start_end(tokens, total_sq, index , sq);
      x = sq_first(tokens, total_sq, index , sq);

    
     }

      else if (indicator == 1 ){// for background
              //  printf("idsjqidnw\n");
       // back = getpid();
        child++;
        x = background(tokens);
        //continue;


    
     }
     else if (indicator == 3 ){// for background
              //  printf("idsjqidnw\n");

         parallel_first(tokens, total_pll, index , pll);


    
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
    if (x == -1){
      return 0;
    
    }
    if (child > 0 ) {
     
      int status;
      //printf("child found\n");
      int endID = waitpid(back, &status, WNOHANG);
        if (endID != 0){
           child--;
           printf("background process completed\n");
         }

    
    }
}
  return 0;
}