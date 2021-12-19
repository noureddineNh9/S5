#ifndef VECTEUR_H
#define VECTEUR_H
#include <iostream>

using namespace std;

class Vecteur
{
    int t ;
    double *v ;
public:
    Vecteur() ;
	Vecteur(int) ;
	Vecteur(int, int *tab);
	Vecteur(const Vecteur &) ;
	~Vecteur() ;
	void Afficher() ;
	void Saisir() ;
	bool MemeTaille(const Vecteur &) ;
	Vecteur operator+(const Vecteur &) ;
	double operator[](int) ;
	double operator*(const Vecteur &) ;
	Vecteur operator*(const double &) ;
    friend Vecteur operator*(double, Vecteur);
	Vecteur &operator=(const Vecteur &) ;
	bool operator==(const Vecteur &) ;
	bool operator!=(const Vecteur &) ;
    friend ostream &operator<<(ostream &, const Vecteur &);
};



#endif // VECTEUR_H
