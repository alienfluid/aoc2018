open Std;;

let process str cur =
    match String.get str 0 with
    | '+' -> cur + int_of_string (String.sub str 1 ((String.length str) - 1))
    | '-' -> cur - int_of_string (String.sub str 1 ((String.length str) - 1))
    | _ -> cur
    
let rec calc strlist cur hsh =
   match strlist with
   | [] -> (false, cur)
   | h :: t -> 
      let out = process h cur in
        match Hashtbl.mem hsh out with
        | true -> (true, out)
        | false -> let _ = Hashtbl.add hsh out true in 
          calc t out hsh

let read_file filename =
  let chan = open_in filename in
  Std.input_list chan;;

exception Found_repeat;;

let p = 
  let inp = read_file "input1-1" in
    let hsh = Hashtbl.create 100000 in
      let _ = Hashtbl.add hsh 0 true in
        let cur = 0 in
          let curref = ref cur in  
            for i = 0 to 1000 do
              match calc inp !curref hsh with
              | (false, c) -> curref := c
              | (true, c) -> 
                let _ = print_endline (string_of_int c) in
                raise Found_repeat
            done;
