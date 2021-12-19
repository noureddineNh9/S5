#include <iostream>
#include "Vecteur.h"


using namespace std;

int main()
{
    int tab[5] = {1, 3, 4, 5, 6};

    Vecteur v1(5,tab), v2, v3(8);
    v2 = 3 * v1;
    cout << (v2!=(v1*2));


    //cout << v1[17];

    return 0;
}
