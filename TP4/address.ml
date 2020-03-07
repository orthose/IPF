type voie = Rue | Ave | Chemin | Blvrd
type mois = Janvier | Fevrier | Mars | Avril | Mai | Juin | Juillet | Aout | Septembre | Octobre | Novembre | Decembre
 

type address = { numero : int;
		 voie : voie;
		 nom : string }

type anniv = { jour : int;
	       mois : mois;
	       annee : int }
		   
type person = { name : string * string;
		anniv : anniv;
		address : address }

let people =
  [
   {name = ("John", "Smith"); anniv = {jour = 4; mois = Mars; annee = 1905};
    address = {numero = 2; voie = Rue; nom = "J"}};
   {name = ("Jane", "Smith"); anniv = {jour = 5; mois = Avril; annee = 1908};
    address = {numero = 2; voie = Rue; nom = "J"}};
   {name = ("JJ", "Smith"); anniv = {jour = 19; mois = Decembre; annee = 1930};
    address = {numero = 2; voie = Rue; nom = "J"}};
   {name = ("Adam", "Doe"); anniv = {jour = 20; mois = Janvier; annee = 2000};
    address = {numero = 19; voie = Blvrd; nom = "Alpha"}};
   {name = ("Paul", "Wilson"); anniv = {jour = 18; mois = Fevrier; annee = 1977};
    address = {numero = 7; voie = Chemin; nom = "Gamma"}};
   {name = ("Sam", "Jones"); anniv = {jour = 30; mois = Octobre; annee = 1986};
    address = {numero = 1; voie = Rue; nom = "J"}};
   {name = ("Mary", "Williams"); anniv = {jour = 24; mois = Decembre; annee = 1918};
    address = {numero = 8; voie = Ave; nom = "Delta"}};
   {name = ("Sarah", "Davis"); anniv = {jour = 10; mois = Mai; annee = 1985};
    address = {numero = 6; voie = Rue; nom = "J"}};
   {name = ("John", "Smith"); anniv = {jour = 4; mois = Mars; annee = 1905};
    address = {numero = 2; voie = Rue; nom = "Epsilon"}};
   {name = ("James", "Smith"); anniv = {jour = 11; mois = Juin; annee = 1925};
    address = {numero = 3; voie = Rue; nom = "Epsilon"}};
   {name = ("Charles", "Johnson"); anniv = {jour = 18; mois = Juin; annee = 1968};
    address = {numero = 2; voie = Ave; nom = "Theta"}};
   {name = ("Chantal", "Miller"); anniv = {jour = 29; mois = Juillet; annee = 1990};
    address = {numero = 9; voie = Blvrd; nom = "Theta"}};
   {name = ("Alice", "Davis"); anniv = {jour = 24; mois = Juillet; annee = 2000};
    address = {numero = 19; voie = Rue; nom = "Alpha"}};
   {name = ("Alice", "Wilson"); anniv = {jour = 8; mois = Juin; annee = 1997};
    address = {numero = 7; voie = Rue; nom = "Gamma"}};
   {name = ("Bob", "Jones"); anniv = {jour = 31; mois = Octobre; annee = 1986};
    address = {numero = 1; voie = Rue; nom = "Halloween"}};
   {name = ("Jack", "Miller"); anniv = {jour = 14; mois = Aout; annee = 1958};
    address = {numero = 9; voie = Chemin; nom = "Delta"}};
   {name = ("Diane", "Davis"); anniv = {jour = 13; mois = Aout; annee = 1975};
    address = {numero = 2; voie = Chemin; nom = "Gamma"}};
   {name = ("Diane", "Miller"); anniv = {jour = 6; mois = Juillet; annee = 1985};
    address = {numero = 18; voie = Chemin; nom = "Alpha"}};
  ]


(*Ecrire une fonction create_person de type string * string -> int * mois * int -> address -> person *)
let create_person n = failwith "a completer"

(*Ecrire une fonction compare_address de type address -> address -> bool qui compare deux adresses et renvoie true si elles sont les mêmes et false sinon.*)
let compare_address a1 a2 = failwith "a completer"

(*Ecrire une fonction list_month de type person list -> mois -> person list qui renvoie la liste des personnes nées un mois donné*)
(*Ex. list_month Janvier people renvoie une liste de tous les gens nes en Janvier.*)
let list_month pl m = failwith "a completer"


(*Ecrire une fonction find_family de type person -> person list qui renvoie la liste des gens ayant le meme nom ou habitant a la meme adresse *)
let find_family p = failwith "a completer"
