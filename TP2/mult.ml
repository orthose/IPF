let rec mult a b = if a = 1 then b else b + mult (a-1) b
let () = Printf.printf "%d\n" (mult 5 3)

let mult a b =
  let rec mult res i =
    if i = b then res
    else mult (res+a) (i+1)
  in
  mult 0 0 
let () = Printf.printf "%d\n" (mult 5 3)
       
let mult a b =
  let rec mult a acc =
    match a with
    | 0 -> acc
    | _ -> mult (a-1) (b+acc)
  in
  mult a 0 
let () = Printf.printf "%d\n" (mult 5 3)
