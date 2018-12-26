let serial = 9221

let calc_power (x, y) =
  if x = 0 || y = 0
  then
    0
  else 
    let tmp = (((x + 10) * y) + serial) * (x + 10)  in
      let tmp2 = (tmp mod 1000) / 100 in
        (tmp2 - 5);;

let cell = Hashtbl.create 90000
let calc_cell_power =
  for x = 1 to 300 do
    for y = 1 to 300 do
      Hashtbl.add cell (x, y) (calc_power (x,y))
    done;
  done;;

let get_power x y =
  Hashtbl.find cell (x,y)

let get_edge_power x y sz =
  let rec inner sz2 acc2 =
    match sz2 with 
    | 0 -> acc2 - get_power (x + sz - 1) (y + sz - 1)
    | n -> inner (sz2 - 1) (acc2 + (get_power (x + sz - 1) (y + sz2 - 1) ) + (get_power (x + sz2 - 1) (y + sz - 1))) in
  inner sz 0;;

let grid = Hashtbl.create 900000

let rec calc_grid_power x y sz =
  match sz with
  | 1 -> get_power x y
  | n -> if Hashtbl.mem grid ((x, y), sz) then 
            Hashtbl.find grid ((x, y), sz) 
         else
            calc_grid_power x y (sz-1) + get_edge_power x y sz;;   

let process =
  for sz = 1 to 300 do
    if sz mod 10 = 0 then        
      print_endline (Printf.sprintf "sz=%d" sz);
    for x = 1 to (300 - sz + 1) do
      for y = 1 to (300 - sz + 1) do
        Hashtbl.add grid ((x,y), sz) (calc_grid_power x y sz)        
      done;
    done;
  done;

Hashtbl.fold (fun k v (((x,y),s),t) -> if v > t then (k,v) else (((x,y),s), t)) grid (((0,0), 0), -10000)