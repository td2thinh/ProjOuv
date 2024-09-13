(* Insert at head *)
let insert_head (x: int64) (list: int64 list) = list @ [x]

(* Front of list *)
let front list = match list with
    |[] -> failwith "Empty List"
    |h::_ -> h

(* Remove head of list *)
let remove_head list = match list with
    |[] -> failwith "Empty List"
    |_::t -> t

(* Apply function n times to a list *)
let rec apply_function_n_times func n list =
    if n <= 0 then
      list
    else
      let result = func list in
      apply_function_n_times func (n - 1) result
