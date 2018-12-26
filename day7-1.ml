open ExtLib;;

let read_file filename =
  let chan = open_in filename in
    Std.input_list chan;;

let inp = read_file "input7-sample";;

let hsh = Hashtbl.create 100;;

let update clist =
  if Hashtbl.mem hsh (List.nth clist 36) then begin
    let tmp = Hashtbl.find hsh (List.nth clist 36) in
      Hashtbl.replace hsh (List.nth clist 36) ((List.nth clist 5) :: tmp)
    end 
    else begin
      Hashtbl.add hsh (List.nth clist 36) [(List.nth clist 5)];
      if Hashtbl.mem hsh (List.nth clist 5) = false then
        Hashtbl.add hsh (List.nth clist 5) [];
    end;;

let p =
  let tmp = List.map (ExtLib.String.explode) inp in
    List.iter update tmp;;
 
let deps_seq =
    (Hashtbl.to_seq hsh);;

let get_candidates s =
  Seq.filter (fun (a,b) -> (List.length b) = 0) s;;


Seq.iter (fun (a, b) -> print_char a) (get_candidates deps_seq);;