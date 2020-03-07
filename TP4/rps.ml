type rps = Pierre | Papier | Ciseaux
type jeu = Gagnant of rps | Nul

let rec qui_gagne (a,b) =
  match (a,b) with
  | (Pierre,Papier) -> Gagnant(Papier)
  | (Pierre,Ciseaux) -> Gagnant(Pierre)
  | (Ciseaux,Papier) -> Gagnant(Ciseaux)
  | (x,y) -> if x=y then Nul else qui_gagne (b,a)

let affiche_jeu jeu =
  match jeu with
  | Gagnant(Pierre) -> Printf.printf "Pierre\n"
  | Gagnant(Papier) -> Printf.printf "Papier\n"
  | Gagnant(Ciseaux) -> Printf.printf "Ciseaux\n"                
  | Nul -> Printf.printf "Nul\n"

(* Tests des cas *)
let test = affiche_jeu (qui_gagne (Pierre,Pierre))
let test = affiche_jeu (qui_gagne (Papier,Papier))
let test = affiche_jeu (qui_gagne (Ciseaux,Ciseaux))
let test = affiche_jeu (qui_gagne (Pierre,Papier))
let test = affiche_jeu (qui_gagne (Papier,Pierre))
let test = affiche_jeu (qui_gagne (Pierre,Ciseaux))
let test = affiche_jeu (qui_gagne (Ciseaux,Pierre))
let test = affiche_jeu (qui_gagne (Ciseaux,Papier))
let test = affiche_jeu (qui_gagne (Papier,Ciseaux))
