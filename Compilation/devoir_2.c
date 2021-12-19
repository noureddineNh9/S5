#include <stdio.h>
#include <stdlib.h>

char VOCABULAIRE[13] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', 'x', '\0'};
int ETATS_INITIAL = 0;
int ETATS_FINALS = 8;

int AppartientAuVocabulaire(char);
int* Mot(int *);
int** Matrice();
int Trace(int** , int* , int );
int Reconnaicence(int );

//***************** Main ***********************


int main(){
   int **M, *mot, tailleDeMot, etat, result;

   M = Matrice();
   mot = Mot(&tailleDeMot);

   etat = Trace(M, mot, tailleDeMot);
   result = Reconnaicence(etat);
   if(result){
      printf("\nle mot est reconnu par le langague.");
   }else{
      printf("\nle mot n'est pas reconnu par le langague.");
   }
 
   return 0;
}

//***********************************************


int AppartientAuVocabulaire( char n){
    int i = 0;
    while(VOCABULAIRE[i] != '\0'){
       if(VOCABULAIRE[i] == n) return 1;
       i++;
    }
    return 0;
}

int Trace(int** M, int* mot, int tailleMot) {
    int i,j, trace = ETATS_INITIAL;

    for(i = 0; i<tailleMot; i++){
        trace = M[trace][mot[i]];
        if(trace == -1) return -1;
    }
	 return trace;

}

int Reconnaicence(int etat) {
    if(etat == ETATS_FINALS) return 1;
    else return 0;
}

int *Mot(int *taille){//passage par adresse
   int i, *mot, isValid;
   char m[128];

   do{
      printf("\nsaisir le mot :: ");
      scanf("%s", m);
      isValid = 1;
      i = 0;
      (*taille) = 0;
      
      // verifier que chaque caractere de la chaine est appaertient au vocabulaire.
      do{
         (*taille)++;
         if(!AppartientAuVocabulaire(m[i])){
            printf("\nil y a un caractere n'appartient pas au langagues."); // ressaisir le mot.
            isValid = 0;
            break;
         }
         i++;
      }while(m[i] != '\0');

   }while(!isValid);

   mot = malloc((*taille) * sizeof(int));

   // convertir le mot a des entiers
   for (int i = 0; i < (*taille); i++){     
      if(m[i] == '0') mot[i] = 0;
      else if(m[i] == '1') mot[i] = 1;
      else if(m[i] == '2') mot[i] = 2;
      else if(m[i] == '3') mot[i] = 3;
      else if(m[i] == '4') mot[i] = 4;
      else if(m[i] == '5') mot[i] = 5;
      else if(m[i] == '6') mot[i] = 6;
      else if(m[i] == '7') mot[i] = 7;
      else if(m[i] == '8') mot[i] = 8;
      else if(m[i] == '9') mot[i] = 9;
      else if(m[i] == '+') mot[i] = 10;
      else if(m[i] == 'x') mot[i] = 11;
   }

   return mot;
}

int** Matrice(){
    int **M,i,j, l, c;
    FILE *file;

    file = fopen("./data.txt", "r");

    fscanf(file, "%d %d \n", &l, &c);
    M = malloc(l * sizeof(int*));
    for(i=0; i<l; i++){
        M[i] = malloc(c * sizeof(int));
    }

    // lire la matrice à partir du fichier.
    for(i=0; i<l; i++){
        for(j=0; j<c; j++){
            fscanf(file, "%d", &M[i][j]);
        }
    }

    return M;
}



