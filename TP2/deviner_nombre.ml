(* Initialisation du générateur de nombre *)
let () = Random.self_init ()
(* Génération du nombre aléatoire *)
let nb = Random.int (int_of_string (Sys.argv.(1)))
(* Fonction principale *)
let devine () =
  let rec devine nb_try =
    (* Entrée utilisateur *)
    let enter = read_int () in
    if enter = nb then
      Printf.printf "Vous avez réussi en %d tentative(s)" nb_try
    else if enter > nb then
      (Printf.printf "Raté trop grand...";
      (* Appel récursif *)
      devine (nb_try+1))
    else
      (Printf.printf "Raté trop petit...";
      (* Appel récursif *)
      devine (nb_try+1))
  in
  devine 1

let () = devine ()
