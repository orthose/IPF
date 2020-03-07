type t = Fruit | Legume
let l = [ ("pomme", Fruit);
          ("navet", Legume);
          ("orange", Fruit);
          ("potiron", Legume);
          ("framboise", Fruit);
          ("citron", Fruit);
          ("pamplemousse", Fruit);
          ("pomme de terre", Legume);
          ("tomate", Legume);
          ("courgette", Legume) ]

let rec print_fruit l =
  match l with
  | [] -> ()
  | (a,Fruit)::b -> let () = Printf.printf "%s\n" a in print_fruit b
  | _::b -> print_fruit b

let fruit_legume l =
  let rec fruit_legume cut l =
    match l with
    | [] -> cut
    | (a,Fruit)::b -> fruit_legume (a::fst cut,snd cut) b
    | (a,Legume)::b -> fruit_legume (fst cut,a::snd cut) b
  in
  fruit_legume ([],[]) l

type t1 = F of string | L of string

let to_t1 (str,t) =
  match t with 
  | Fruit -> F(str)
  | Legume -> L(str)
  
let convert_list l =
  let rec convert_list converted l =
    match l with
    | [] -> converted
    | a::b -> convert_list ((to_t1 a)::converted) b
  in
  convert_list [] l
  
let rec exists l =
  match l with
  | [] -> false
  | F(_)::b | L(_)::b -> true
  
let count l =
  let rec count c l =
    match l with
    | [] -> c
    | F(_)::b -> count (fst c + 1, snd c) b
    | L(_)::b -> count (fst c, snd c + 1) b
  in
  count (0,0) l
  
let () = print_fruit l

let cut = fruit_legume l

let print_cut (l1,l2) =
  let rec print_list l =
    match l with
    | [] -> ()
    | a::b -> if b = [] then Printf.printf "%s" a
              else let () = Printf.printf "%s;" a in print_list b
  in
  let () = Printf.printf "([" in
  let () = print_list l1 in
  let () = Printf.printf "];\n[" in
  let () = print_list l2 in
  Printf.printf "])\n"
  
let () = print_cut cut

let rec print_converted l =
  match l with
  | [] -> () 
  | F(s)::b | L(s)::b -> let () = Printf.printf "%s\n" s in print_converted b
  
let converted = convert_list l
  
let () = print_converted converted

let () = Printf.printf "%B\n" (exists [])
let () = Printf.printf "%B\n" (exists [L("carotte")])

let () = let (nf,nl) = count converted in Printf.printf "(%d,%d)\n" nf nl 


  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

