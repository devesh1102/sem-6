#include  <stdio.h>
#include  <sys/types.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define MAX_INPUT_SIZE 1024
#define MAX_TOKEN_SIZE 64
#define MAX_NUM_TOKENS 64
#define TAM 1000 

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
    if( total_sq == index){

      return;
    }
    else {
      char *cmd = tokens[sq[index]+1];
      char *argv1[3];
      if (!(strcmp(tokens[sq[index]+2],"&&"))){//if command has one word
         char *argv1[2];
          argv1[0] = tokens[sq[index]+1];
          argv1[1] = NULL;
          //argv1[2] = NULL;
      }
      else{//if command has two word
          
          argv1[0] = tokens[0];
          argv1[1] = tokens[sq[index]+2];
          argv1[2] = NULL;
      }

  
      printf("should not be here...no fork\n" );
      int is_child = fork();
      if ( is_child == -1){
        printf("should not be here...no fork\n" );

      }
      else if (is_child > 0 ){//parent
        wait(NULL);
      }
      else{//child

        if (!(strcmp(cmd,"cd"))){//cd is present
            chdir(argv1[1]);
            
        }       //}
        else{
          int is_done = execvp(cmd , argv1);
           //printf("%s\n",tokens[sq[index]-2] );
          if(is_done == -1){
            printf("insert valid command\n" );
          }
          sequence (tokens, total_sq, index + 1, sq);

        }
        //printf("cd here\n" );
         exit(0);
      } 

  }
  return;
}

int main(int argc, char* argv[]) {
	char  line[MAX_INPUT_SIZE];
	char  **tokens;
	int i;
	    char  *gdir;
    char  *dir;
    char  *to;
    char buf[TAM];

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
//        printf("this is me  %s\n",line );

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


       //do whatever you want with the commands, here we just print them
///
	//	for(i=0;tokens[i]!=NULL;i++){
		//	printf("found token %s\n", tokens[i]);
	//	}

		// Freeing the allocated memory
    int indicator = 0;//0 if nothing is present.
                      //1 if & is present and execution in background. 
                      //2 if && is present and we have to do sequencing in forground.
                      //3 if &&& is present and we have to do parallel in foreground
    int index_bg = 0;//all are initialized to 0
    int total_sq= 0;
    int total_pll= 0; 
    int bg[64] = {0};//all are initialized to 0
    int sq[64] = {0};
    int pll[64] = {0};
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

    if(indicator == 0){//normal excecution
      char *cmd = tokens[0];
      char *argv1[2];
      printf("%d/n",strcmp(tokens[1],NULL));
      if (tokens[1] == NULL){//if command has one word
         char *argv1[1];
          argv1[0] = tokens[0];
          //argv[1] = NULL;
      }
      else{//if command has two word
          
          argv1[0] = tokens[0];
          argv1[1] = tokens[1];
         // argv1[2] = NULL;
      }
      int is_child = fork();
      if ( is_child == -1){
        printf("should not be here...no fork\n" );

      }
      else if (is_child > 0 ){//parent
        wait(NULL);
      }
      else{//child

     	  if (!(strcmp(cmd,"cd"))){//cd is present
            chdir(argv1[1]);
            continue;
        }	      //}
      	else{
        	int is_done = execvp(cmd,argv1);
          if(is_done == -1){
            printf("insert valid command\n" );
          }

        }
        //printf("cd here\n" );
         exit(0);
      }
    }
    else if (indicator == 1 ){//background

    }

    else if (indicator == 2 ){//sequence
      char *cmd = tokens[0];
      char *argv1[3];
      if (!(strcmp(tokens[1],"&&"))){//if command has one word
         char *argv1[2];
          argv1[0] = tokens[0];
          argv[1] = NULL;
      }
      else{//if command has two word
          
          argv1[0] = tokens[0];
          argv1[1] = tokens[1];
          argv1[2] = NULL;
      }

      int is_child = fork();
      if ( is_child == -1){
        printf("should not be here...no fork\n" );

      }
      else if (is_child > 0 ){//parent
        wait(NULL);
      }
      else{//child

        if (!(strcmp(cmd,"cd"))){//cd is present
            chdir( argv1[1]);
            
        }       //}
        else{
          int is_done = execvp(cmd , argv1);
           //printf("%s\n",tokens[sq[index]-2] );
          if(is_done == -1){
            printf("insert valid command\n" );
          }
          sequence (tokens, total_sq, index , sq);

        }
        //printf("cd here\n" );
         exit(0);
      } 

  }
    
    else if (indicator == 3 ){//parallel

    }

    



		for(i=0;tokens[i]!=NULL;i++){
			free(tokens[i]);
		}
		free(tokens);

	}
	return 0;
}
