(* Valeur de exp(0) *)
let e = 2.718281828

(* Fonction exponentielle par définition *)
let rec exp n =
  if n = 0 then 1.
  else e *. exp (n-1)

(* Tests de l'exponentielle *)
let () =
  Printf.printf "%f\n" (exp 0);
  Printf.printf "%f\n" (exp 1);
  Printf.printf "%f\n" (exp 2);
  Printf.printf "%f\n" (exp 3);
  Printf.printf "%f\n" (exp 4);
  Printf.printf "%f\n" (exp 5)

(* Fonction exponentielle récursive terminale *)
let exp n =
  let rec exp n res =
    match n with
    | 0 -> res
    | _ -> exp (n-1) (e*.res)
  in
  exp n 1.

(* Tests de l'exponentielle *)
let () =
  Printf.printf "%f\n" (exp 0);
  Printf.printf "%f\n" (exp 1);
  Printf.printf "%f\n" (exp 2);
  Printf.printf "%f\n" (exp 3);
  Printf.printf "%f\n" (exp 4);
  Printf.printf "%f\n" (exp 5)

(* Fonction inutile *)
let f a n =
  let rec f i res =
    if i = 0 then res
    else if i mod 2 = 0 then f (i-1) (res+1)
    else f (i-1) (res-1)
  in
  let s = f n 0 in
  if a > s then Printf.printf "%d > %d\n" a s
  else Printf.printf "%d <= %d\n" a s

let () = f 0 11; f 0 12

(* Recherche d'un diviseur *)
let div_between a b n =
  let rec div_between c =
    if c = a then n mod a = 0
    else if n mod c = 0 then true
    else div_between (c-1)
  in
  div_between b

(* Vérification nombre premier *)
let is_prime n =
  if n < 2 then false
  else if n = 2 then true
  else not (div_between 2 (n-1) n)

(* Tests des nombre premiers *)
let () =
  Printf.printf "2 %B\n" (is_prime 2);
  Printf.printf "3 %B\n" (is_prime 3);
  Printf.printf "4 %B\n" (is_prime 4);
  Printf.printf "5 %B\n" (is_prime 5);
  Printf.printf "6 %B\n" (is_prime 6);
  Printf.printf "7 %B\n" (is_prime 7)

(* Ne pas rechercher plus loin que a *)
let no_div_from a n =
  a * a >= n

(* Vérification nombre premier *)
let is_prime n =
  let rec search_max max =
    if no_div_from max n then max
    else search_max (max+1)
  in
  if n < 2 then false
  else if n = 2 then true
  else not (div_between 2 (search_max 0) n)

(* Tests des nombre premiers *)
let () =
  Printf.printf "2 %B\n" (is_prime 2);
  Printf.printf "3 %B\n" (is_prime 3);
  Printf.printf "4 %B\n" (is_prime 4);
  Printf.printf "5 %B\n" (is_prime 5);
  Printf.printf "6 %B\n" (is_prime 6);
  Printf.printf "7 %B\n" (is_prime 7)

(* Décomposition binaire *)
let print_decomp n =
  let rec decomp n bin =
    match n with
    | 1 -> (string_of_int(n mod 2)^bin)
    | _ -> decomp (n/2) (string_of_int(n mod 2)^bin)
  in
  if n = 0 then "0"
  decomp n ""
  
(* Tests de la décomposition binaire *)
let () =
  Printf.printf "%s\n" (print_decomp 0);
  Printf.printf "%s\n" (print_decomp 1);
  Printf.printf "%s\n" (print_decomp 2);
  Printf.printf "%s\n" (print_decomp 3);
  Printf.printf "%s\n" (print_decomp 4);
  Printf.printf "%s\n" (print_decomp 5);
  Printf.printf "%s\n" (print_decomp 23)
