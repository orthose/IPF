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

(* Longueur d'une brique *)
let brick_right = int_of_float (right /. 10.)

(* Epaisseur d'une brique *)
let brick_up = int_of_float (up /. 50.)

(* Nombre de colones de briques *)
let brick_column = int_of_float (right /. float_of_int brick_right)

(* Nombre de lignes de briques *)
let brick_lines = 5

(* Coordonnée x de la première brique *)
let first_brick_x = 0.

(* Coordonnée y de la première brique *)
let first_brick_y = up /. 3.
                  
(* Résistance d'une brique *)
let brick_resistance = 3

(* Structure représentant une brique simple *)
type brick = {brick_x:float ; brick_y:float ; brick_resistance:int}
             
(* Initialise la liste de briques *)
let init_brick () =
  let rec init_brick i j liste =
    if i < brick_lines then (
      if j < brick_column then (
        (* Calcul des coordonnées de la brique *)
        let brick = { brick_x = first_brick_x +. float_of_int j *. brick_right ;
                      brick_y = first_brick_y +. float_of_int i *. brick_up ;
                      brick_resistance = 2 } in
        init_brick i (j+1) liste::brick
      )
      else init_brick (i+1) 0
    )
    else liste
  in
  init_brick 0 0 []

(* Dessine toutes les briques selon la liste *)
let rec draw_bricks bricks =
  (* Affichage d'une brique simple à la position (x,y) *)
  let draw_brick x y =
    Graphics.fill_rect x y brick_right brick_up
  in
  (* Parcours de toutes les briques et affichage *)
  let a::b = bricks in
  let { brick_x = x ; brick_y = y brick_resistance = r } = a in
  (* Couleur calculée à partir résitance brique *)
  let color = Graphics.rgb (float_of_int r *. (255. /. float_of_int r)) 0 0 in
  Graphics.set_color color;
  (* Affichage de la brique courante *)
  draw_brick x y;
  if b != [] then draw_bricks b

(* Intervalle distance de la balle avec brique *)
let distance_min = 0.0
let distance_max = 0.5

(* Côté de l'impact de la balle avec la brique *)
type side = Vertical | Horizontal | NoneSide
                 
(* Renvoie (impact:bool,côté:side) avec impact true si la balle (float:x,float:y)
touche la brique spécifiée au format {brick_x:float;brick_y:float;brick_resistance:int}
et horizontal true si l'impact a lieu sur la partie horizontale de la brique *)
let reaches_brick x y brick =
  (* Borne inférieure abscisse balle *)
  let ball_x_inf = x -. float_of_int ball in
  (* Borne supérieure abscisse balle *)
  let ball_x_sup = x +. float_of_int ball in
  (* Borne inférieure ordonnée balle *)
  let ball_y_inf = y -. float_of_int ball in
  (*Borne supérieure ordonnée balle *)
  let ball_y_sup = y +. float_of_int ball in
  
  (* Tests des 4 aretes de la brique si brique pas cassée *)
  if brick.brick_resistance > 0 &&
     ((brick.brick_x <= ball_x_inf && ball_x_inf <= brick.brick_x +. brick_right) ||
      (brick.brick_x <= ball_x_sup && ball_x_sup <= brick.brick_x +. brick_right)) &&
     ((distance_min <= brick.brick_y -. ball_y_sup && brick.brick_y -. ball_y_sup <= distance_max) ||
      (distance_min <= ball_y_inf -. brick.brick_y +. brick_up && ball_y_inf -. brick.brick_y +. brick_up <= distance_max))
     then (true, Horizontal)

   else if brick.brick_resistance > 0 &&
      ((brick.brick_y <= ball_y_inf && ball_y_inf <= brick.brick_y +. brick_up) ||
       (brick.brick_y <= ball_y_sup && ball_y_sup <= brick.brick_y +. brick_up)) &&
      ((distance_min <= brick.brick_x -. ball_x_sup && brick.brick_x -. ball_x_sup <= distance_max) ||
       (distance_min <= ball_x_inf -. brick.brick_x +. brick_right && ball_x_inf -. brick.brick_x +. brick_right <= distance_max))
     then (true, Vertical)
  else (false, NoneSide)

(* Mets à jour la matrice de briques selon la position courante
(float:x,float:y) de la balle et la liste actuelle
Renvoie (bricks, impact) *)
let update_bricks x y bricks =
  (* Parcours de toutes les briques *)
  let rec update_bricks bricks =
    ...
  in
  update_bricks bricks

(* Calcul de la vitesse sur l'axe des abscisses pour
un rebond éventuel sur une brique donnée par impact. *)
let bounce_brick_x vx impact =
  let (collision, side) = impact in
  if collision then
    match side with
    | Vertical -> -.vx
    | Horizontal -> -.vx
    | NoneSide -> vx
  else vx
  
(* Calcul de la vitesse sur l'axe des ordonnées pour
un rebond éventuel sur une brique donné par impact. *)
let bounce_brick_y vy impact =
  let (collision, side) = impact in
  if collision then
    match side with
    | Vertical -> vy
    | Horizontal -> -.vy
    | NoneSide -> vy
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
