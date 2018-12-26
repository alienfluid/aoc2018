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

let cmp_polymer_2 c1 c2 =
  if (c1 = c2) || (Char.uppercase_ascii c1 = Char.uppercase_ascii c2) then 0
  else if (Char.uppercase_ascii c1 < Char.uppercase_ascii c2) then -1
  else 1;;

let uniq = 
  List.map Char.uppercase_ascii (List.sort_uniq cmp_polymer_2 (ExtLib.String.explode inp));;
  
let p = (ExtLib.String.explode inp);;

let lengths = List.map 
                (fun c -> 
                  List.length (eliminate (List.filter 
                    (fun x -> if Char.uppercase_ascii x = c then false else true) p) 
                [])) uniq;;

let get_min = function
  [] -> invalid_arg "empty list"
  | x::xs -> List.fold_left min x xs;;

get_min lengths;;