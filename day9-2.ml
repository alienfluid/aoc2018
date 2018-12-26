#require "core";;

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

let remove_at a i len =
    let tmp = Base.Array.create lmarble 0 in
        let _ = Base.Array.blit a 0 tmp 0 i in
           let _ = Base.Array.blit a (i + 1) tmp i (len - i - 1) in
                tmp;;

let insert_at a i x len =
    let tmp = Base.Array.create lmarble 0 in
       let _ = Base.Array.blit a 0 tmp 0 i in
           let _ = Base.Array.blit a i tmp (i+1) (len - i) in
               let _ = Base.Array.set tmp i x in
                   tmp;;

let print_space x =
    print_int x; print_string " ";;

let turn =
    let rec innerturn nm cp ci config len =
        (*Base.Array.iter config (print_space);
        print_newline ();*)
        match nm > lmarble with
        | true -> ()
        | false -> let np = next_player cp nplayers in
                    if (nm mod 10000 = 0) then print_endline (Printf.sprintf "current marble: %d" nm);
                    if (nm mod 23 = 0) then 
                      begin
                          update_score np nm;
                          let ri = subtract_mod ci len 7 in
                            let nmarble = Base.Array.get config (add_mod ri len 1) in
                                update_score np (Base.Array.get config ri);
                                let nconfig = remove_at config ri len in
                                    let (nindex, _) = Base.Array.findi_exn nconfig (fun _ a -> a = nmarble) in
                                        (*print_int nm; print_string " "; print_int nindex; print_string " "; print_int (Base.Array.length nconfig); print_string " "; print_int len; print_newline ();*)
                                        innerturn (nm + 1) np nindex nconfig (len-1)
                      end
                    else
                      begin
                        let ni = next_index ci len in
                           (*print_int nm; print_string " "; print_int ni; print_string " "; print_int len; print_newline ();*)
                           let nconfig = insert_at config ni nm len in
                               innerturn (nm + 1) np ni nconfig (len+1) 
                      end in
        innerturn 1 0 0 (Base.Array.create lmarble 0) 1;;

Hashtbl.fold (fun k v m -> if v > m then v else m) scores 0;;
