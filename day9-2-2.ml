#require "extlib";;

let add_mod cur total v =
    let nx = cur + v in
        if nx >= total then (total - nx)
        else nx;;

let subtract_mod cur total v =
    let nx = cur - v in
        if nx < 0 then (total - abs nx)
        else nx;;

let next_player cur total =
    let nx = cur + 1 in
        if nx > total then 1 
        else nx;;

let next_index cur clen =
    let nx_index = cur + 2 in
        if nx_index >= clen then (nx_index - clen)
        else nx_index;;

let nplayers = 465;;
let lmarble = 71940 * 100;;

let scores = Hashtbl.create nplayers;;

let update_score p s =
    (*print_endline (Printf.sprintf "player: %d, adding score: %d" p s);*)
    if Hashtbl.mem scores p then
        let cs = Hashtbl.find scores p in
            Hashtbl.replace scores p (cs + s)
    else
        Hashtbl.add scores p s;;

let print_space x =
    print_int x; print_string " ";;

let get_prev_7 node =
  Dllist.prev (Dllist.prev (Dllist.prev (Dllist.prev (Dllist.prev (Dllist.prev (Dllist.prev node))))));;

let turn =
    let rec innerturn nm cp curr =
        (*Base.Array.iter config (print_space);
        print_newline ();*)
        match nm > lmarble with
        | true -> ()
        | false -> let np = next_player cp nplayers in
                    if (nm mod 23 = 0) then 
                      begin
                          update_score np nm;
                          let rnode = get_prev_7 curr; in
                            let nmarble = Dllist.next rnode in
                                update_score np (Dllist.get rnode);
                                let _ = Dllist.remove rnode in
                                  innerturn (nm + 1) np nmarble
                      end
                    else
                      begin
                        let nnode = Dllist.append (Dllist.next curr) nm in
                            innerturn (nm + 1) np nnode
                      end in
        innerturn 1 0 (Dllist.create 0);;

Hashtbl.fold (fun k v m -> if v > m then v else m) scores 0;;
