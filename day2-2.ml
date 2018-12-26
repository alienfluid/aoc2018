let getdiff str1 str2 =
  let exstr1 = ExtString.String.explode str1 and
      exstr2 = ExtString.String.explode str2 in
    let pairs = List.combine exstr1 exstr2 in
      let filtered = List.filter (fun (a,b) -> a <> b) pairs and
        common = List.filter (fun (a,b) -> a = b) pairs in
          (List.length filtered, ExtString.String.implode (List.map (fun (a,b) -> a) common));;

let read_file filename =
  let chan = open_in filename in
  Std.input_list chan;;

let inp = read_file "input2-1";;

let compare str strlist =
  let m = List.map (fun a -> getdiff str a) strlist in
    let filt = List.filter (fun (a,b) -> a = 1) m in
      if List.length filt > 0 then List.nth filt 0 else (-1, "")

let process strlist =
  let m = List.map (fun a -> compare a inp) strlist in
    let filt = List.filter (fun (a,b) -> a = 1) m in
      let (c, rem) = List.nth filt 0 in
        rem;;

let x = process inp;