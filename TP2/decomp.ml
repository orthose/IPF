let decomp n =
  let rec decomp bin n =
    if n = 0 then bin
    else if n mod 2 = 0 then decomp ("0"^bin) (n/2)
    else decomp ("1"^bin) (n/2)
  in
  if n <= 0 then "0"
  else decomp "" n

let () =
  Printf.printf "%s\n" (decomp 0);
  Printf.printf "%s\n" (decomp 1);
  Printf.printf "%s\n" (decomp 2);
  Printf.printf "%s\n" (decomp 3);
  Printf.printf "%s\n" (decomp 4);
  Printf.printf "%s\n" (decomp 5);
  Printf.printf "%s\n" (decomp 6);
  Printf.printf "%s\n" (decomp 7);
  Printf.printf "%s\n" (decomp 8);
  Printf.printf "%s\n" (decomp 9);
  Printf.printf "%s\n" (decomp 10);
  Printf.printf "%s\n\n" (decomp 23)

let exp a b =
  let rec exp pow2 b res =
    if b = 0 then res
    else if b mod 2 = 0 then exp (pow2*pow2) (b/2) res
    else exp (pow2*pow2) (b/2) (res*pow2)
  in
  if b <= 0 then 1
  else exp a b 1

let () =
  Printf.printf "0^0=%d\n" (exp 0 0);
  Printf.printf "0^1=%d\n" (exp 0 1);
  Printf.printf "5^0=%d\n" (exp 5 0);
  Printf.printf "5^1=%d\n" (exp 5 1);
  Printf.printf "5^2=%d\n" (exp 5 2);
  Printf.printf "5^3=%d\n" (exp 5 3);
  Printf.printf "5^4=%d\n" (exp 5 4);
  Printf.printf "5^5=%d\n" (exp 5 5);
  Printf.printf "5^6=%d\n" (exp 5 6);
  Printf.printf "2^1=%d\n" (exp 2 1);
  Printf.printf "2^3=%d\n" (exp 2 3);
  Printf.printf "2^4=%d\n" (exp 2 4)
