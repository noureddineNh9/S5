#include "Vecteur.h"
#include <iostream>

using namespace std;



Vecteur::Vecteur():t(0){
    v = new double[t];
}



Vecteur::Vecteur(int t):t(t){
	v = new double[t] ;
}

///////////////////////////////////////
Vecteur::Vecteur(int t, int *tab):t(t){
	v = new double[t] ;
	for(int i = 0; i<t; i++){
        v[i] = tab[i];
	}
}


Vecteur::Vecteur(const Vecteur &Vec):t(Vec.t){
	v = new double[t] ;
	for(int i=0;i<t;i++) v[i] = Vec.v[i] ;
}


Vecteur::~Vecteur(){
	delete[] v ;
}


bool Vecteur::MemeTaille(const Vecteur &Vec){
	return t == Vec.t ;
}


Vecteur Vecteur::operator+(const Vecteur &Vec){
	if(MemeTaille(Vec)){
        Vecteur res(t);
        for(int i=0;i<t;i++){
            res.v[i] = v[i] + Vec.v[i];
        }
        return res;
	}
	else cout << "erreur !" ;
}

double Vecteur::operator[](int indice){
	if(indice>=0 && indice<t) return v[indice] ;
	else
        return NULL;
}

Vecteur Vecteur::operator*(const double &s){
    Vecteur res(t);
    for(int i=0; i<t; i++){
        res.v[i] = v[i] * s;
    }
    return res;
}


Vecteur operator*(double s, Vecteur vec){
    return vec * s;
}

Vecteur &Vecteur::operator=(const Vecteur &vec){
        delete[] v;
        t = vec.t;
        v = new double[t];
        for(int i=0;i<t;i++){
            v[i] = vec.v[i];
        }
        return *this;
}

bool Vecteur::operator==(const Vecteur &vec){
    if(MemeTaille(vec)){
        for(int i=0;i<t;i++){
            if(v[i] != vec.v[i]) return false;
        }
        return true;
	}
	return false;
}

bool Vecteur::operator!=(const Vecteur &vec){
    return !((*this)==vec);
}

ostream &operator<<(ostream &os, const Vecteur &vec){
    for(int i=0; i<vec.t; i++){
        cout << vec.v[i] << "\t";
    }
    cout << endl;
    return os;
}

/*
istream &operator>>(istream &is, const Vecteur &vec){
    for(int i=0; i<vec.t; i++){
        cout << vec.v[i] << "\t";
    }
    cout << endl;
    return os;
}
*/
