type t = Fruit | Legume
let l = [ ("pomme", Fruit);
          ("orange", Fruit);
          ("potiron", Legume);
          ("framboise", Fruit);
          ("citron", Fruit);
          ("poire", Fruit);
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

type t1 = Fruit of string | Legume of string


  
  
let () = print_fruit l
let cut = fruit_legume l 
