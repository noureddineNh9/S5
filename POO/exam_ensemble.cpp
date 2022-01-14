#include <iostream>

using namespace std;

/************************** Ensemble.h ******************************/

class Ensemble{
protected:
   int *T;
   int card;
public:
   Ensemble();
   Ensemble(const Ensemble&);
   ~Ensemble();
   bool estVide();
   friend std::istream& operator>>(std::istream &, Ensemble &);
   int cardinale();
   Ensemble& operator+(int);
   friend std::ostream& operator<<(std::ostream &, const Ensemble &);
   Ensemble operator+(const Ensemble &);
   Ensemble& operator=(const Ensemble &);
   bool operator>(int);
   bool operator>(const Ensemble &);
   Ensemble(int);
   void triCroissant();
   void triDecroissant();


};
/************************** Ensemble.cpp ******************************/
Ensemble::Ensemble(): card(0){
   T = NULL;
}

Ensemble::Ensemble(const Ensemble& e): card(e.card){
   T = new int[card];
   for (int i = 0; i < card; i++){
      T[i] = e.T[i];
   }   
}

Ensemble::~Ensemble(){
   if(T){
      delete[] T;
   }
}

bool Ensemble::estVide(){
   return card==0;
}

istream& operator>>(istream &is, Ensemble &e){
   for (int i = 0; i < e.card; i++)
   {
      cout << "T[" << i << "] = ";
      is >> e.T[i];
   }
   
   return is;
}

int Ensemble::cardinale(){
   return card;
}

Ensemble& Ensemble::operator+(int a){
   if(!(*this > a)){
      int i;
      Ensemble tmp(*this);
      delete[] T;
      card++; 
      T = new int[card];
      for (i = 0; i < card - 1; i++)
      {
         T[i] = tmp.T[i];
      }
      T[i] = a;

   }

   return(*this);
}


ostream& operator<<(ostream &os, const Ensemble &e){
   
   for (int i = 0; i < e.card; i++){
      os << e.T[i] << "\t";
   }
   
   return os;
}


Ensemble Ensemble::operator+(const Ensemble & e){
   Ensemble res(*this);
   for (int i = 0; i < e.card; i++){
         res + e.T[i];
   }
   return res;
}

Ensemble& Ensemble::operator=(const Ensemble &e){
   if(this != &e){
      delete[] T;
      card = e.card;
      T = new int[card];
      for (int i = 0; i < card; i++)
      {
         T[i] = e.T[i];
      }
   }
   return *this;
}


bool Ensemble::operator>(int a){
   for (int i = 0; i < card; i++)
   {
      if(T[i] == a) return true;
   }
   return false;
}

bool Ensemble::operator>(const Ensemble &e){
   if(card >= e.card){
      for (int i = 0; i < e.card; i++)
      {
         if(!(*this > e.T[i])){//si le plus grande ensemble ne contient pas l'element 
            return false;
         }
      }
      
   }
   return true;  
}

Ensemble::Ensemble(int a): card(a){
   T = new int[card];
}

void Ensemble::triCroissant(){
   int perm;
   for (int i = 0; i < card - 1; i++){
      for (int j = 0; j < card - 1; j++){
         if(T[j] > T[j+1]){
            perm = T[j];
            T[j] = T[j+1];
            T[j+1] = perm;
         }
      }
   } 
}

void Ensemble::triDecroissant(){
   int perm;
   for (int i = 0; i < card - 1; i++){
      for (int j = 0; j < card - 1; j++){
         if(T[j] < T[j+1]){
            perm = T[j];
            T[j] = T[j+1];
            T[j+1] = perm;
         }
      }
   } 
}


/************************** sousEnsemble.h ******************************/

class sousEnsemble : public Ensemble 
{
   string tri; // "croissant" ou "decroissant"
public:
   sousEnsemble(int, string);
   sousEnsemble(const sousEnsemble &);
   sousEnsemble& operator+(int);
   //sousEnsemble operator+(const sousEnsemble &);
};

/************************** sousEnsemble.cpp ******************************/


sousEnsemble::sousEnsemble(int c, string type): Ensemble(c){
   tri = type;
}

sousEnsemble::sousEnsemble(const sousEnsemble &s): Ensemble(s){
   tri = s.tri;

}

sousEnsemble& sousEnsemble::operator+(int a){
   (*this).Ensemble::operator+(a);
   if(tri == "croissante"){
      (*this).triCroissant();
   }else{
      (*this).triDecroissant();
   }

   return *this;
}
/*
sousEnsemble operator+(const sousEnsemble &s){

}
*/


/************************** main.cpp ******************************/


int main(){
   /*
   Ensemble e1(2);
   cin >> e1;
   Ensemble e2(e1);
   e1+1;
   e1+3;
   e1+2;
   e2+11;
   e2+22;
   e2+33;
   Ensemble e3;
   e3=e1+e2;
   e1+7;
   cout << (e3>e1);
   */

  sousEnsemble s1(2, "croissante");
  cin >> s1;
  s1+3;

  cout << s1;


   return 0;
}