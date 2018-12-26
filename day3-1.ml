let pair n lst =
  List.map (fun a -> (n, a)) lst;;

let coords startx starty w h =
  let x = List.init w (fun i -> i + startx + 1) and
      y = List.init h (fun i -> i + starty + 1) in
    List.flatten (List.map (fun a -> pair a y) x);;

let hsh = Hashtbl.create 10000;;

let update h p =
  match Hashtbl.mem h p with
  | false -> Hashtbl.add h p 1
  | true -> Hashtbl.replace h p ((Hashtbl.find h p) + 1);;

exception Invalid_input;;

let parse_token str =
  match String.split_on_char ' ' str with
  | id :: at :: start :: size :: rest -> (id, at, start, size)
  | _ -> raise Invalid_input;;

let parse_start str = 
  let tmp = String.split_on_char ',' str in
    let tmp2 = String.split_on_char ':' (List.nth tmp 1) in
      (int_of_string (List.nth tmp 0), int_of_string (List.nth tmp2 0));;

let parse_size str =
  let tmp = String.split_on_char 'x' str in
  (int_of_string (List.nth tmp 0), int_of_string (List.nth tmp 1));;

let process str =
  let (id, at, start, size) = parse_token str in 
    let (startx, starty) = parse_start start and
        (width, height) = parse_size size in
          coords startx starty width height

let read_file filename =
  let chan = open_in filename in
    Std.input_list chan;;

let inp = read_file "input3-1";;

let all_coords = 
  List.flatten (List.map (fun a -> process a) inp);;

List.iter (fun a -> update hsh a) all_coords;;

(* Seq.iter (print_int) (Hashtbl.to_seq_values hsh);; *)
Seq.fold_left (+) 0 (Seq.map (fun a -> 1) (Seq.filter (fun a -> a > 1) (Hashtbl.to_seq_values hsh)));;