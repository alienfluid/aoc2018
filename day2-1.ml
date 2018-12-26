let detect str =
  let clist = ExtString.String.explode str in
    let rec innerdetect orig cl twos threes =
      match cl with 
      | [] -> (twos, threes)
      | h :: t -> let tmp = ExtString.String.explode str in
        let num = List.length (List.filter (fun c -> c = h) tmp) in
          if num = 2 then innerdetect orig t 1 threes
          else if num = 3 then innerdetect orig t twos 1
          else innerdetect orig t twos threes in
      innerdetect str clist 0 0;;

let read_file filename =
  let chan = open_in filename in
  Std.input_list chan;;

let inp = read_file "input2-1"

let rec calc_checksum lst twos threes =
  match lst with 
  | [] -> twos * threes
  | h :: t -> let (tw, th) = detect h in
    calc_checksum t (twos + tw) (threes + th);;

calc_checksum inp 0 0;;