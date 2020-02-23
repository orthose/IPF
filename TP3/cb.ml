(* Commande de compilation: ocamlc -o cb graphics.cma unix.cma cb.ml *)

(* Modules à importer *)
open Graphics
open Unix

(* Bornes du cadre *)
let left = 0.
let right = 300.
let down = 0.
let up = 500.

(* Ouverture fenêtre graphique *)
let () =
  Graphics.open_graph (Printf.sprintf " %dx%d" (int_of_float right) (int_of_float up));
  Graphics.set_window_title "Jeu du Casse-Brique"; Graphics.auto_synchronize false

(* Rayon de la balle *)
let ball = 5

(* Vitesse initiale de la balle *)
let vx = Random.float 1.0
let vy = Random.float 1.0

(* Calcul de la position future de la balle
en fonction de sa position courante et de
sa vitesse *)
let new_position_x x vx =
  let res = x +. vx in
  if left <= res && res <= right then res
  else x
  
let new_position_y y vy =
  let res = y +. vy in
  if res <= up then res
  else y

       
(* Dessine la balle à la position (float:x,float:y) *)
let draw_ball x y =
  Graphics.set_color (Graphics.black);
  Graphics.fill_circle (int_of_float x) (int_of_float y) ball

(* Longueur de la raquette *)
let paddle = 30
(* Epaisseur de la raquette *)
let thick = 10

(* Dessine la raquette à la position (float:x) *)
let draw_paddle x =
  Graphics.set_color (Graphics.black);
  Graphics.fill_rect (int_of_float x) (int_of_float down) paddle thick

(* Position de la raquette en fonction du curseur souris *)
let position_paddle () =
  let (x,y) = Graphics.mouse_pos () in
  if x < (int_of_float left) then (int_of_float left)
  else if x + paddle > ((int_of_float right) - 1) then ((int_of_float right) - 1) - paddle
  else x

(* Calcul de la vitesse en fonction position float:x de la balle
 et de sa vitesse float:vx sur l'axe des abscisses *)
let bounce_x x vx =
  if x -. left <= float_of_int ball || x +. float_of_int ball >= (right -. 1.) then -.vx
  else vx

(* Calcul de la vitesse en fonction de la position (float:x,float:y)
de la balle, de la vitesse float:vy et de la position int:p de la
raquette sur l'axe des ordonnées *)
let bounce_y x y vy p =
  if y +. float_of_int ball >= (up -. 1.) || (y -. float_of_int ball <= (down +. (float_of_int thick)) && float_of_int p <= x && x <= float_of_int (p + paddle))  then -.vy
  else vy

(* Vérifie si le jeu est perdu *)
let is_lost x y = y <= 0.
                
(* Boucle principale *)
let game () =
  (* (float:x,float:y) position de la balle
     (float:vx,float:vy) vitesse de la balle *)
  let rec game x y vx vy =
    Printf.printf "(x=%f;y=%f)\n" x y;
    Printf.printf "(vx=%f;vy=%f)\n" vx vy;
    (* Efface la frame précédente *)
    Graphics.clear_graph ();
    (* Affichage de la balle *)
    draw_ball x y;
    (* Affichage de la raquette *)
    draw_paddle (float_of_int(position_paddle ()));
    (* Synchronisation de l'affichage *)
    Graphics.synchronize ();
    (* Effets sur la balle *)
    if not (is_lost x y) then
      (* Calcul du rebond *)
      let vx = bounce_x x vx in
      let vy = bounce_y x y vy (position_paddle ()) in
      (* Calcul de la position de la balle *)
      let x = new_position_x x vx in
      let y = new_position_y y vy in
      (* Appel récursif *)
      Unix.sleepf 0.003; (* Vitesse des frames *)
      game x y vx vy
  in
  (* Initialisation du jeu *)
  let p = position_paddle () in
  (* La balle est initialisée sur la raquette et part vers le haut *)
  game (float_of_int (p + paddle) /. 2.) (down +. float_of_int thick +. float_of_int ball +. 1.0) vx (abs_float vy)
  
(* Lancement du jeu *)
let () = game ()
