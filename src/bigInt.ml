open Int64;;
open Random;;
open Primitives;;
(* Part 1: Warmup *)

(* Structure and Primitives Definition *)
type bigInt = int64 list

(* bigInt creation *)
let rec createBigInt: int -> bigInt = fun n -> 
    if (n < 64) 
        then [of_int(int_of_float(float_of_int 2 ** float_of_int n))] 
        else  0L :: (createBigInt (n mod 64))

(* Utility function to transform int to list of bits *)
let rec intToBool : int64 -> bool list = fun n -> 
    match n with 
    | 0L -> []
    | x -> if ((logand x 1L) = 1L) 
        then true :: (intToBool (shift_right x 1))
        else false :: (intToBool (shift_right x 1))

(* Overloading operators on int64 *)
module Int64op = struct let (+) = Int64.add let ( * ) = Int64.mul end

(*Utility function to transform list of bits to int64*)
let rec boolToInt : bool list -> int64 = fun list ->
    match list with
    | [] -> 0L
    | h :: t -> if h
        then Int64op.(1L + 2L * (boolToInt t))
        else Int64op.(0L + 2L * (boolToInt t))

(* Utility function to transform list of bits to int *)
(* Complete bool list of bits to the number of bits required*)
let completion : bool list -> int -> bool list = fun list n ->
      if n > List.length list then
        let listFalse : bool list = List.init (n - List.length list) (fun i -> false) in
        list @ listFalse
      else
        let rec reduce n l =
          if n <= 0 then []
          else match l with
            | [] -> []
            | h :: t -> h :: reduce (n-1) t
        in
        reduce n list

(* Decompose a bigInt into bool list of bits *)
let rec decomposition : bigInt -> bool list = fun nb ->
    match nb with
    | [] -> failwith "Empty List"
    | [t] -> intToBool (t)
    | h::t -> (completion (intToBool h) 64) @ decomposition (t)

(*  Generate a bigInt from a given table of truth *)
let rec composition : bool list -> bigInt = fun list ->
    if ((List.length list) > 64) 
        then  boolToInt (completion list 64) :: composition(apply_function_n_times remove_head 64 list) 
        else  [boolToInt (list)]

(* Generate a table of truth from a bigInt *)
let table : bigInt -> int -> bool list = fun bInt value ->
    completion (decomposition bInt) value 

(* Generate a random bigInt *)
let rec genAlea : int -> bigInt = fun n ->
    if (n < 64) 
        then [Random.int64 (of_int(int_of_float(float_of_int 2 ** float_of_int n)))]
        else  Random.int64 (Int64.max_int) :: (genAlea (n - 64))
