open Std;;

let process str cur =
    match String.get str 0 with
    | '+' -> cur + int_of_string (String.sub str 1 ((String.length str) - 1))
    | '-' -> cur - int_of_string (String.sub str 1 ((String.length str) - 1))
    | _ -> cur
    
let rec calc strlist cur =
   match strlist with
   | [] -> cur
   | h :: t -> calc t (process h cur) 

let read_file filename =
  let chan = open_in filename in
  Std.input_list chan;;

print_endline (string_of_int (calc (read_file "input1-1") 0));;
