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

(* Initialisation du Random en fonction du temps *)
let () = Random.init (int_of_float (Unix.time ()))

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
let paddle = 35
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

(* Calcul de la vitesse sur l'axe des abscisses en fonction 
position (float:x,float:y) de la balle, sa vitesse float:vx
et position int:p de la raquette *)
let bounce_x x y vx p =
  let middle_paddle = float_of_int p +. (float_of_int paddle /. 2.) in
  if x -. left <= float_of_int ball || x +. float_of_int ball >= (right -. 1.) then -.vx
  (* Gestion de la trajectoire à la raquette *)
  else if y -. float_of_int ball <= down +. float_of_int thick then
  (
    if float_of_int p <= x && x <= middle_paddle then -.(abs_float vx)
    else if middle_paddle <= x && x <= float_of_int (p + paddle) then (abs_float vx)
    else vx
  )
  else vx

(* Calcul de la vitesse sur l'axe des ordonnées en fonction 
position (float:x,float:y) de la balle, sa vitesse float:vy
et position int:p de la raquette *)
let bounce_y x y vy p =
  if y +. float_of_int ball >= (up -. 1.) || (y -. float_of_int ball <= down +. float_of_int thick && float_of_int p <= x && x <= float_of_int (p + paddle))  then -.vy
  else vy

(* Longueur d'une brique *)
let brick_right = floor (right /. 10.)

(* Epaisseur d'une brique *)
let brick_up = floor (up /. 30.)

(* Nombre de colones de briques *)
let brick_column = int_of_float (right /. brick_right)

(* Nombre de lignes de briques *)
let brick_lines = 15

(* Coordonnée x de la première brique *)
let first_brick_x = 0.

(* Coordonnée y de la première brique *)
let first_brick_y = floor (up /. 3.)
                  
(* Résistance d'une brique *)
let brick_resistance = 3

(* Structure représentant une brique simple *)
type brick = {brick_x:float ; brick_y:float ; brick_resistance:int}
             
(* Initialise la liste de briques *)
let init_bricks () =
  let rec init_bricks i j liste =
    if i < brick_lines then (
      if j < brick_column then (
        (* Calcul des coordonnées de la brique *)
        let brick = { brick_x = first_brick_x +. float_of_int j *. brick_right ;
                      brick_y = first_brick_y +. float_of_int i *. brick_up ;
                      brick_resistance = brick_resistance } in
        init_bricks i (j+1) liste@[brick]
      )
      else init_bricks (i+1) 0 liste
    )
    else liste
  in
  init_bricks 0 0 []

(* Dessine toutes les briques selon la liste *)
let rec draw_bricks bricks =
  (* Affichage d'une brique simple à la position (x,y) *)
  let draw_area_brick x y =
    Graphics.fill_rect x y (int_of_float brick_right) (int_of_float brick_up);
  in
  (* Trace la bordure du rectangle *)
  let draw_border_brick x y =
    (* Epaisseur de la bordure *)
    Graphics.set_line_width 1;
    (* Point bas gauche *)
    Graphics.moveto x y;
    Graphics.lineto (x + (int_of_float brick_right)) y;
    Graphics.moveto x y;
    Graphics.lineto x (y + (int_of_float brick_up));
    (* Point haut droite *)
    Graphics.moveto (x + (int_of_float brick_right)) (y + (int_of_float brick_up));
    Graphics.lineto (x + (int_of_float brick_right)) y;
    Graphics.moveto (x + (int_of_float brick_right)) (y + (int_of_float brick_up)) ;
    Graphics.lineto x (y + (int_of_float brick_up))
  in
  (* Parcours de toutes les briques et affichage *)
  let a::b = bricks in
  let { brick_x = x ; brick_y = y ; brick_resistance = r } = a in
  (* Couleur calculée à partir résitance brique *)
  let color = if r = 0 then Graphics.rgb 255 255 255
              else Graphics.rgb (255 - int_of_float ((float_of_int brick_resistance -. float_of_int r) *. (255. /. float_of_int brick_resistance))) 10 10 in
  Graphics.set_color color;
  (* Affichage de la brique courante *)
  draw_area_brick (int_of_float x) (int_of_float y);
  (* Bordure noire ou blanche en fonction résistance *)
  if r > 0 then Graphics.set_color (Graphics.rgb 0 0 0)
  else (Graphics.set_color (Graphics.rgb 255 255 255));
  draw_border_brick (int_of_float x) (int_of_float y);
  if b != [] then draw_bricks b

(* Intervalle distance de la balle avec brique *)
let distance_min = 0.0
let distance_max = 0.5

(* Côté de l'impact de la balle avec la brique *)
type side = Vertical | Horizontal | NoneSide
                 
(* Renvoie le side de l'impact et la valeur NoneSide si la balle (float:x,float:y) ne touche pas
la brique spécifiée au format {brick_x:float;brick_y:float;brick_resistance:int} *)
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

  (* Côté horizontal haut et bas *)
  if brick.brick_resistance > 0 &&
     ((brick.brick_x <= ball_x_inf && ball_x_inf <= brick.brick_x +. brick_right) ||
      (brick.brick_x <= ball_x_sup && ball_x_sup <= brick.brick_x +. brick_right)) &&
     ((distance_min <= brick.brick_y -. ball_y_sup && brick.brick_y -. ball_y_sup <= distance_max) ||
      (distance_min <= ball_y_inf -. (brick.brick_y +. brick_up) && ball_y_inf -. (brick.brick_y +. brick_up) <= distance_max))
     then Horizontal
         
   (* Côté vertical gauche et droite *) 
   else if brick.brick_resistance > 0 &&
      ((brick.brick_y <= ball_y_inf && ball_y_inf <= brick.brick_y +. brick_up) ||
       (brick.brick_y <= ball_y_sup && ball_y_sup <= brick.brick_y +. brick_up)) &&
      ((distance_min <= brick.brick_x -. ball_x_sup && brick.brick_x -. ball_x_sup <= distance_max) ||
       (distance_min <= ball_x_inf -. (brick.brick_x +. brick_right) && ball_x_inf -. (brick.brick_x +. brick_right) <= distance_max))
      then Vertical

  (* Aucune face touchée *)
  else NoneSide

(* Mets à jour la liste de briques selon la position courante
(float:x,float:y) de la balle et la liste actuelle.
Renvoie (bricks, side). Une seule brique au maximum peut être
touchée par la balle. *)
let update_bricks x y bricks =
  (* Parcours de toutes les briques *)
  let rec update_bricks bricks new_bricks =
    match bricks with
    | [] -> (new_bricks, NoneSide)
    | a::b ->
       (* Calcul d'un éventuel impact *)
       let impact = reaches_brick x y a in
       (* Recherche d'une autre brique touchée *)
       if impact = NoneSide then update_bricks b (new_bricks@[a])
       (* On s'arrête car une brique a été touchée *)
       else (new_bricks@{a with brick_resistance = a.brick_resistance - 1}::b, impact)
  in
  update_bricks bricks []

(* Calcul de la vitesse sur l'axe des abscisses pour
un rebond éventuel sur une brique donnée par le side. *)
let bounce_brick_x vx side =
  match side with
  | Vertical -> -.vx
  | Horizontal -> -.vx
  | NoneSide -> vx
  
(* Calcul de la vitesse sur l'axe des ordonnées pour
un rebond éventuel sur une brique donné par le side. *)
let bounce_brick_y vy side =
  match side with
  | Vertical -> vy
  | Horizontal -> -.vy
  | NoneSide -> vy
  
(* Vérifie si le jeu est perdu *)
let is_lost x y = y <= 0.

(* Affiche le score *)
let draw_score score =
  (* Conversion du score *)
  let score = "SCORE = " ^ string_of_int score in
  (* Affichage en noir bien visible *)
  Graphics.set_color (Graphics.rgb 0 0 0);
  Graphics.set_text_size 20; (* Dommage pas implémentée *)
  let (_, y) = text_size score in
  (* Point gauche haut de la fenêtre *)
  Graphics.moveto 0 (int_of_float up - y);
  Graphics.draw_string score
                
(* Boucle principale *)
let game () =
  (* (float:x,float:y) position de la balle
     (float:vx,float:vy) vitesse de la balle
     [{brick};...]:bricks liste de briques
     (int:score) à incrémenter pour chaque impact *)
  let rec game x y vx vy bricks score =
    Printf.printf "(x=%f;y=%f)\n" x y;
    Printf.printf "(vx=%f;vy=%f)\n" vx vy;
    Printf.printf "(score=%d)\n" score;
    
    (* Efface la frame précédente *)
    Graphics.clear_graph ();

    (* Attention l'ordre des affichages est important *)
    
    (* Affichage de la raquette *)
    draw_paddle (float_of_int(position_paddle ()));
    (* Affichage de la liste de briques *)
    draw_bricks bricks;
    (* Affichage de la balle *)
    draw_ball x y;
    (* Affichage du score *)
    draw_score score;
    (* Synchronisation de l'affichage *)
    Graphics.synchronize ();
    
    (* Effets sur la balle tant que le jeu n'est pas perdu *)
    if not (is_lost x y) then
      let p = position_paddle () in
      (* Calcul du rebond raquette et bordures *)
      let vx = bounce_x x y vx p in
      let vy = bounce_y x y vy p in
      (* Mise à jour de la liste de briques *)
      let (bricks, side) = update_bricks x y bricks in
      (* Incrémentation du score *)
      let score = if side != NoneSide then score + 1 else score in
      (* Calcul du rebond sur brique qui est prioritaire sur le rebond précédent *)
      let vx = bounce_brick_x vx side in
      let vy = bounce_brick_y vy side in
      (* Calcul de la position de la balle *)
      let x = new_position_x x vx in
      let y = new_position_y y vy in
      
      (* Vitesse des frames *)
      Unix.sleepf 0.0005;
      (* Appel récursif *)
      game x y vx vy bricks score
  in
  (* Initialisation du jeu *)
  let p = position_paddle () in
  (* La balle est initialisée sur la raquette et part vers le haut *)
  game (float_of_int (p + paddle) /. 2.) (down +. float_of_int thick +. float_of_int ball +. 1.0) vx (abs_float vy) (init_bricks ()) 0
  
(* Lancement du jeu *)
let () = game ()
