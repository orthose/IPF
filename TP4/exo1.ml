type name = { nom:string ; prenom:string }
type anniv = { jour:int ; mois:int ; annee:int }
type person = { name:name ; anniv:anniv }

let print_name name =
  Printf.printf "%s %s\n" name.nom name.prenom

let print_anniv anniv =
  Printf.printf "%d/%d/%d\n" anniv.jour anniv.mois anniv.annee

let print_person person =
  let () = Printf.printf "Nom Prénom: " in
  let () = print_name person.name in
  let () = Printf.printf "Date de naissance: " in
  print_anniv person.anniv

(* Tests des fonctions *)
let baptiste = {
    name={nom="MAQUET";prenom="Baptiste"};
    anniv={jour=10;mois=6;annee=1999}
  }

let maxime = {
    name={nom="VINCENT";prenom="Maxime"};
    anniv={jour=3;mois=8;annee=2000}
  }

let () = print_person baptiste
let () = print_person maxime
