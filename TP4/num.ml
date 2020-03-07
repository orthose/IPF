type num =
  | Succ of num
  | Zero

      
(* Ecrire une fonction de type num -> int *)
let rec num_to_int n = failwith "A completer"

(* Ecrire une fonction de type num -> num -> num qui fait la somme de deux num *)  
let rec add a b = failwith "A completer"

(* Ecrire une fonction de type num -> num -> num qui fait le produit de deux num *)
let rec mult a b = failwith "A completer"

  
(* Ecrire une fonction de type num -> num -> num qui calcule a puissance b *)  
let rec pow a b = failwith "A completer"

(* Ecrire une fonction qui calcule le factorielle *)
let rec fac a = failwith "A completer"

let ten = Succ(Succ(Succ(Succ(Succ(Succ(Succ(Succ(Succ(Succ Zero)))))))))
let five = Succ(Succ(Succ(Succ(Succ Zero))))
let one = Succ Zero

let () = print_string "\nPartie 2\n"
let () = Printf.printf "%d + %d = %d\n" (num_to_int five) (num_to_int ten) (num_to_int (add five ten))
let () = Printf.printf "%d * %d = %d\n" (num_to_int five) (num_to_int ten) (num_to_int (mult five ten))
let () = Printf.printf "%d ^ %d = %d\n" (num_to_int five) (num_to_int five) (num_to_int (pow five five))
let () = Printf.printf "%d! = %d\n" (num_to_int five) (num_to_int (fac five))
