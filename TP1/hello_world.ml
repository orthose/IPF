print_string "hello world\n"
let age = 20
let name = "Maxime"
let boolean = true
let () = Printf.printf "J'ai %d ans et je m'appelle %s\n" age name
let () = Printf.printf "Ce que je dis est %B\n" boolean
let affiche_string string = Printf.printf "%s" string
let affiche_int int = Printf.printf "%d" int
let affiche_float float = Printf.printf "%f" float
let () = affiche_string "Ceci est un string\n"
let () = affiche_int 5; affiche_string "\n"
let () = affiche_float 102.5; affiche_string "\n"
let distance a b c d = sqrt ( (a -. c) *. (a -. c) +. (b -. d) *. (b -. d) )
let () = affiche_float (distance 5. 3. 7. 9.); affiche_string "\n"
