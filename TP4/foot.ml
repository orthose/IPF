let () = Random.self_init () (*Init Random*)

(*----------------------------------------------------------------------------*)

type team = {nom : string; point : int}
type game = (team * team) list
type res  = {equipe : team * team; resultat : int * int}
type champ = res list

    (* team -> string *)
let team_to_string t = failwith "A completer"

    (* (team * team) -> res : prend deux equipes et renvoie le resultat du match en prenant en compte le point d'une equipe*)
let play t = failwith "A completer"

    (* game -> champ *)
let rec championnat t = failwith "A completer"

    (* int -> int -> int *)
    (*victoire 3 points / match nul 1 point / defaite 0 point*)
let comp a b = failwith "A completer"

    (* res -> team -> int *)
let rank_one m t = failwith "A completer"

    (* champ -> team -> int *)
let rec rank r t = failwith "A completer"

(*----------------------------------------------------------------------------*)

let () = print_string "\nPartie 1\n"

let rec product l1 l2 =
  match l1, l2 with
  | [], _ | _, [] -> []
  | h1::t1, h2::t2 ->
    if h1 != h2
    then (h1,h2)::(product [h1] t2)@(product t1 l2)
    else (product [h1] t2)@(product t1 l2)

(*Classement 04/03/2020*)
(*https://www.ligue1.fr/classement*)
let psg = {nom = "FC Paris Saint-Germain"; point = 68 }

let li =
  psg ::
  {nom = "Olympique de Marseille"; point = 55 } ::
  {nom = "Stade Rennais FC"      ; point = 47 } ::
  {nom = "LOSC Lille"            ; point = 46 } ::
  {nom = "Olympique Lyonnais"    ; point = 40 } ::
  {nom = "HSC Montpellier"       ; point = 40 } ::
  {nom = "AS Monaco"             ; point = 40 } ::
  {nom = "Stade Reims"           ; point = 38 } ::
  {nom = "OGC Nice"              ; point = 38 } ::
  {nom = "RC Strasbourg Alsace"  ; point = 38 } ::
  {nom = "FC Nantes"             ; point = 37 } ::
  {nom = "FC Girondins Bordeaux" ; point = 36 } ::
  {nom = "SCO Angers"            ; point = 36 } ::
  {nom = "Stade Brest"           ; point = 34 } ::
  {nom = "FC Metz"               ; point = 31 } ::
  {nom = "AS Saint-Etienne"      ; point = 29 } ::
  {nom = "FCO Dijon"             ; point = 27 } ::
  {nom = "Nimes Olympique"       ; point = 27 } ::
  {nom = "SC Amiens"             ; point = 22 } ::
  {nom = "FC Toulouse"           ; point = 13 } :: []


let m = product li li
let r = championnat m
let () = Printf.printf "\n%s - %d\n" psg.nom (rank r psg)
