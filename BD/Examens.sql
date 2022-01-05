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
	where num_vendeur NOT IN (select NVL(num_vendeur, 0) from VENTE);
2-
Alg:
	// R21 = Produit(VENDEUR, VENDEUR / num_magazin = num_magazin AND num_vendeur != num_vendeur )

SQL:
	select V1.nom as membre_1, V2.nom as membre_2 from VENDEUR V1, VENDEUR V2 where V1.num_magazin = V2.num_magazin;
3-
	// R21 = Produit(PIECE, PIECE / num_piece = num_piece AND num_piece != num_piece )
	// R21 = Produit(R21, PIECE / num_piece = num_piece AND num_piece != num_piece )

	select P1.num_piece as piece_1, P2.num_piece as piece_2, P3.num_piece as piece_3, sum(P1.prix_unitaire + P2.prix_unitaire + P3.prix_unitaire) as prix
	from PIECE P1, PIECE P2, PIECE P3 
	where P1.num_piece != P2.num_piece 
	and P2.num_piece != P3.num_piece 
	and P1.num_piece != P3.num_piece 
	and prix < 60000;
4-

	
	select MAGAZIN.num_magazin mag
	from MAGAZIN, PIECE
	where MAGAZIN.num_magazin = PIECE.num_magazin AND 
	GROUP BY mag
	HAVING sum(PIECE.seuil_stock) > sum(PIECE.quantité_stockée);




5-
	R51 = Jointure(MAGAZIN, VENTE / num_magazin)
	R52 = Jointure(R51, PIECE / num_piece)
	R53 = ROUGROUPER_ET_CALCULER(R52, num_magazin, chiffre_affaire : somme(prix_unitaire * quantite))

	select MAGAZIN.num_magazin mag, MAGAZIN.ville ville, sum(PIECE.prix_unitaire * VENTE.quantite) as "chiffre_affaire" 
	from MAGAZIN, VENTE, PIECE
	where MAGAZIN.num_magazin = VENTE.num_magazin AND VENTE.num_piece = PIECE.num_piece
	GROUP BY mag, ville;

6-
	UPDATE PIECE 
	SET prix_unitaire = prix_unitaire * 2;

8-
	DELETE from VENDEUR where num_vendeur=23

/* Exercice 3 */

select v.num_serie, v.modele from VOITURE JOIN VENDRE ON( VOITURE.num_serie=VENDRE.num_serie ) where VENDRE.date_v > To_DATE('1-SEP-2019', 'DD-MON-YY');

select ID_M, count(ID_M) AS "nombre total" from EXPOSER GROUP BY ID_M;

5.

select A.nom, A.prenom, count(*) Cn
from VENDEUR A, VENTE B
Where A.id_vendeur=B.id_vendeur and to_char(B.date_v, 'YYYY')=2019
GROUP BY A.nom, A.prenom
HAVING C = (select Max(Count(*)) from VENTE where to_char(B.date_v, 'YYYY')=2019 group by id_vendeur)


select A.nom, A.prenom, count(*) C
from VENDEUR A, VENTE B
Where A.id_vendeur=B.id_vendeur and to_char(B.date_v, 'YYYY')=2019
GROUP BY A.nom, A.prenom
HAVING C = (
	select Max(nb) from (
		select Count(*) as nb from VENTE where to_char(B.date_v, 'YYYY')=2019 group by id_vendeur
	)
)

select * from(
   	select a.nom, a.prenom from 
	VENDEUR a JOIN 
		(select id_vendeur, count(date_v) num 
		 from VENDRE where to_char(date_v, 'YYYY')=2019 
		 group by id_vendeur) b
	ON(A.id_vendeur=B.id_vendeur)
	order by num
)
where rownum=1;

6.

// la liste de tout les marques vendu


select Modele.marque, count(*) C 
from MODELE, VOITURE, VENDRE 
where VOITURE.num_serie = VENDRE.num_serie AND VOITURE.ID_Modele = MODELE.ID_Modele 
AND to_char(VENDRE.date_v, 'YYYY')=2019 
group by Modele.marque
HAVING C = (
	select min(nb) from (
		select Modele.marque, count(*) nb 
		from MODELE, VOITURE, VENDRE 
		where VOITURE.num_serie = VENDRE.num_serie AND VOITURE.ID_Modele = MODELE.ID_Modele 
		AND to_char(VENDRE.date_v, 'YYYY')=2019 
		group by Modele.marque	
	)
)


select Modele.marque, count(*) nb 
		 from MODELE, VOITURE, VENDRE 
		 where VOITURE.num_serie = VENDRE.num_serie AND VOITURE.ID_Modele = MODELE.ID_Modele 
		 AND to_char(VENDRE.date_v, 'YYYY')=2019 
		 group by Modele.marque



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
	from Photographe Ph JOIN PriseDeVue Pr 
	ON (PhnumPhotog=Prproprietaire) 
	where Pr.dateVue > '30-04-2004' AND Ph.prenom='Frederic' AND Ph.nom='Cresseux';
3.
	R31 = Jointure(Photographe, PriseDeVue / numPhotog=proprietaire)
	R32 = Jointure(R31, Modele / numModele)
	R33 = Selection(R32 / prenom='Laetitia' AND nom='Casta')
	R24 = Projection(R23 / numPhotog, nom)

	select Ph.numPhotog, Ph.nom
	from Photographe Ph JOIN PriseDeVue Pr ON (Ph.PhnumPhotog=Pr.Prproprietaire) 
	JOIN Module M ON (Pr.numMod=M.numMod) 
	where Ph.prenom ='Laetitia' AND Ph.nom='Casta';
4.
	R41 = Projection( Photographe / numPhotog)
	R42 = Projection( Commande / numPhotog)
	R43 = Intersection(R41, R42)
	R44 = Jointure(Photographe, R43 / numPhotog)
	R45 = Selection(R44 / nom, prenom)

	select nom, prenom 
	from Photographe 
	where numPhotog NOT IN (select numPhotog from Commande);

5.
	il calcule le nombre des prise de vue qu'est fait par le Photographe du numero 11.