let read_file filename =
  let chan = open_in filename in
    let il = input_line chan in
    let _ = close_in chan in
      il;;

let inp = read_file "input5-1";;

let cmp_polymer c1 c2 =
  (c1 <> c2) && 
  (Char.uppercase_ascii c1) = (Char.uppercase_ascii c2)

let rec eliminate str left =
  (*print_string (ExtLib.String.implode str);
  print_string "; ";
  print_string (ExtLib.String.implode left);
  print_newline ();*)
  match str with
  | [] -> left
  | h1 :: [] -> (left@[h1])
  | h1 :: h2 :: t -> 
    if (cmp_polymer h1 h2) 
      then 
        match left with 
        | [] -> eliminate t left
        | _ ->
        let lelem = List.hd (List.rev left) in
          let ltail = List.rev (List.tl (List.rev left)) in
           eliminate (lelem :: t) ltail
      else eliminate (h2 :: t) (left@[h1]);;

let p =
  eliminate (ExtLib.String.explode inp) [];;

print_int (List.length p);;