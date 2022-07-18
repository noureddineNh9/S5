****************************** Exam 19/20 **********************************

/* Exercice 2 */
1-
Alg:
	R11 = Projection(VENTE, num_vendeur)
	R12 = Projection(VENDEUR, num_vendeur)
	R13 = DIFFERENCE(R12, R11)
	R14 = Jointure(VENDEUR,R13 / VENDEUR.num_serie = R13.num_serie )
	R15 = Projection(R14, nom, prénom)
SQL:
	select nom, prenom 
	from vendeur 
	where num_vendeur NOT IN (select num_vendeur from VENTE);
2-
Alg:
	R21 = Projection(VENDEUR / num_magazin, vendeur_1 : num_vendeur)
	R22 = Projection(VENDEUR / num_magazin, vendeur_2 : num_vendeur)
	R21 = Jointure(R21, R22 / num_magazin = num_magazin AND vendeur_1 != vendeur_2 )
SQL:
	select V1.nom as membre_1, V2.nom as membre_2 
	from VENDEUR V1, VENDEUR V2 
	where V1.num_magazin = V2.num_magazin AND V1.num_vendeur <> V2.num_vendeur;
3-
Alg:
	R31 = Projection(PIECE / piece_1 : num_piece, prix_1 : prix_unitaire )
    R32 = Projection(PIECE / piece_2 : num_piece, prix_2 : prix_unitaire )
    R33 = Projection(PIECE / piece_3 : num_piece, prix_3 : prix_unitaire )

	R34 = jointure(R31, R32 / piece_1 != piece _2)
	R35 = jointure(R34, R33 / piece_3 != piece _1 ET piece_3 != piece _2 )
	R36 = Selection(R35 / prix_1 + prix_2 + prix_3 < 60000 )
	R37 = Projection(R36 / piece_1, piece_2, piece_3 )


SQL:
	select P1.num_piece as piece_1, P2.num_piece as piece_2, P3.num_piece as piece_3
	from PIECE P1, PIECE P2, PIECE P3 
	where P1.num_piece != P2.num_piece 
	and P2.num_piece != P3.num_piece 
	and P1.num_piece != P3.num_piece 
	and (P1.prix_unitaire + P2.prix_unitaire + P3.prix_unitaire) < 60000;
4-
    R41 = Selection(PIECE / quantite < seuil)
	R42 = Jointure(R41, Magazin / num_magazin )
    R43 = Projection(R42 / num_magazin, destination, ville)

    select M.num_magazin, M.destination, M.ville
	from Magazin M, Piece P
	where M.num_magazin = P.num_magazin AND P.quantité < P.seuil;


5-
	R51 = Jointure(MAGAZIN, VENTE / num_magazin)
	R52 = Jointure(R51, PIECE / num_piece)
	R53 = ROUGROUPER_ET_CALCULER(R52, num_magazin, chiffre_affaire : somme(prix_unitaire * quantite))

	select MAGAZIN.num_magazin mag, MAGAZIN.ville ville, sum(PIECE.prix_unitaire * VENTE.quantite) as "chiffre_affaire" 
	from MAGAZIN, VENTE, PIECE
	where MAGAZIN.num_magazin = VENTE.num_magazin AND VENTE.num_piece = PIECE.num_piece
	GROUP BY mag, ville;

6-
	R61 = ROUGROUPER_ET_CALCULER(PIECE, num_magazin, nb_piece : comptage( num_piece))
    R62 = Selection( R61 / nb_piece >= 1000 )
    R63 = Jointure( R62, Magazin / num_magazin = num_magazin )

    select * from magazin 
    where num_magazin IN (
        select num_magazin from PIECE 
        group by num_magazin
        having sum(quantité) >= 1000
    );

7-
	UPDATE PIECE 
	SET prix_unitaire = prix_unitaire * 2;

8-
	DELETE from VENDEUR where num_vendeur=23

/* Exercice 3 */


3-

select V1.num_serie, V1.modele 
from VOITURE V1 JOIN VENDRE V2 ON( V1.num_serie=V2.num_serie ) 
where VENDRE.date_v > '1-SEP-2019';

4-

select VENDEUR.ID_M, count(VENDEUR.num_serie) cmp
from VENDEUR JOIN VENDRE
ON( VENDEUR.id_vendeur = VENDRE.id_vendeur) 
GROUP BY VENDEUR.ID_M
ORDER BY cmp DESC;

5.

select A.nom, A.prenom, count(*) C
from VENDEUR A, VENTE B
Where A.id_vendeur=B.id_vendeur and to_char(B.date_v, 'YYYY')=2019
GROUP BY A.nom, A.prenom
HAVING C >= all (
	select Count(*) as nb 
	from VENTE 
	where to_char(B.date_v, 'YYYY')=2019 
	group by id_vendeur
)


6.

// la liste de tout les marques vendu


select M.marque, count(*) C 
from MODELE M, VOITURE V1, VENDRE V2
where V1.num_serie = V2.num_serie AND M.ID_M = V1.ID_M AND to_char(B.date_v, 'YYYY')=2019 
GROUP BY M.marque
HAVING C <= all (
	select count(*)
	from MODELE M, VOITURE V1, VENDRE V2
	where V1.num_serie = V2.num_serie AND M.ID_M = V1.ID_M AND to_char(B.date_v, 'YYYY')=2019 
	GROUP BY M.marque
);

7-

select M.marque, sum(V2.prix_vente - V1.prix_rev) C 
from MODELE M, VOITURE V1, VENDRE V2
where V1.num_serie = V2.num_serie AND M.ID_M = V1.ID_M AND to_char(B.date_v, 'YYYY')=2019 
GROUP BY M.marque
HAVING C >= all (
	select sum(V2.prix_vente - V1.prix_rev)
	from MODELE M, VOITURE V1, VENDRE V2
	where V1.num_serie = V2.num_serie AND M.ID_M = V1.ID_M AND to_char(B.date_v, 'YYYY')=2019 
	GROUP BY M.marque
);






****************************** Exam 18/19 **********************************

/* EX 2 */
1.
	R11 = Projection(Photographe)

	select * from Photographe;
2.
	R21 = Selection(PriseDeVue / dateVue > '30-04-2004' )
	R22 = Selection(Photographe / prenom=Frederic AND nom=Cresseux)
	R23 = Jointure(R21, R22 / numPhotog=proprietaire)
	R24 = Projection(R23 / nom, prenom, dateVue)

	select Ph.nom, Ph.prenom, Pr.dateVue 
	from Photographe Ph, PriseDeVue Pr 
	where PhnumPhotog=Prproprietaire 
	AND Pr.dateVue > '30-04-2004' AND Ph.prenom='Frederic' AND Ph.nom='Cresseux';
3.
	R31 = Jointure(Photographe, PriseDeVue / numPhotog=proprietaire)
	R32 = Selection(Modele / prenom ='Laetitia' ET nom='Casta')
	R33 = Jointure(R31, R32 / numModele)
	R34 = Projection(R34 / numPhotog, nom)

	select DISTINCT Ph.numPhotog, Ph.nom
	from Photographe Ph, PriseDeVue, Module 
	where Ph.PhnumPhotog=Pr.Prproprietaire and Pr.numMod=M.numMod
	and M.prenom ='Laetitia' AND M.nom='Casta';
4.
	R41 = Projection( Photographe / numPhotog)
	R42 = Projection( Commande / numPhotog)
	R43 = DIFFERENCE(R41, R42)
	R44 = Jointure(Photographe, R43 / numPhotog)
	R45 = Selection(R44 / nom, prenom)

	select nom, prenom 
	from Photographe 
	where numPhotog NOT IN (select numPhotog from Commande);

5.
	il calcule le nombre des prise de vue qu est fait par le Photographe du numero 11.


****************************** Exam 15/16 ratt **********************************

/* exercice 2 */

1-

R11 = Selection(Emprunt / Livre="Recueil Examens BD")
R12 = Projection(R11 / Personne)

2-

R21 = Projection(Emprunt / Personne)
R22 = Projection(Retard / Personne)
R23 = DIFFERENCE(R21, R22)

3-

R31 = 


****************************** Exam 15/16 normale **********************************

/* exercice 2 */

1-

R11 = Selection(Emprunt / Livre="Recueil Examens BD")
R12 = Projection(R11 / Personne)

select Personne from Emprunt 
where Livre='Recueil Examens BD';

2-

R21 = Projection(Emprunt / Personne)
R22 = Projection(Retard / Personne)
R23 = DIFFERENCE(R21, R22)

select Personne from Emprunt
where Personne NOT IN (
	select Personne from Retard
)

3-

R31 = Projection(Emprunt / livre)
R32 = ROUGROUPER_ET_CALCULER(R31 / cmp : comptage(livre) )
R33 = ROUGROUPER_ET_CALCULER(Emprunt / Personne, count(livre))
// ! ERROR !



select  Personne, count(distinct livre) C
from Emprunt
GROUP BY Personne 
having C = (
	select count(distinct livre) from Emprunt 
)


4-
Alg:

// ! ERROR ! 


select livre ,count(distinct personne) p
from Emprunt
GROUP by livre
having P=(
select count(distinct personne )from Emprunt)

5-


select  Personne, count(distinct livre) nbTotal
from Emprunt A JOIN ( 
	select Personne, count(distinct livre) as "nbRetard"
	from Retard
	GROUP BY Personne  
) B
ON A.nbTotal=B.nbRetard;
GROUP BY Personne 
