
let serial = 9221

let calc_power (x, y) =
  let rack_id = x + 10 in
    let power_1 = rack_id * y in
      let power_2 = power_1 + serial in
        let power_3 = power_2 * rack_id in
          let tmp = power_3 mod 1000 in
            let tmp2 = tmp / 100 in
              (tmp2 - 5)

let cell = Hashtbl.create 90000
let calc_cell_power =
  for x = 1 to 300 do
    for y = 1 to 300 do
      Hashtbl.add cell (x, y) (calc_power (x,y))
    done;
  done;;

let grid = Hashtbl.create 90000
let calc_grid_power =
  for x = 1 to 298 do
    for y = 1 to 298 do
      for i = 0 to 2 do
        for j = 0 to 2 do
          if Hashtbl.mem grid (x,y) then begin
            let tmp = Hashtbl.find grid (x,y) in 
              Hashtbl.replace grid (x,y) (tmp + calc_power (x + i, y + j))
          end
          else begin
              Hashtbl.add grid (x,y) (calc_power (x + i, y + j))
          end;  
        done;
      done;
    done;
  done;

Hashtbl.fold (fun k v ((x,y),t) -> if v > t then (k,v) else ((x,y), t)) grid ((0,0), -10000);;