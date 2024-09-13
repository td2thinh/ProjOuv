open BigInt;;
open Primitives;;
(* Utility function to round a number up to the closest power of 2 *)
let ceilBase2 : int -> float = fun n ->
    ceil(Float.log2 (Float.of_int n))

(* Utility function to get first half of a list *)
let getFirstHalf : bool list -> bool list = fun list ->
    let length = List.length list in
    completion list (length / 2)

(* Utility function to get second half of a list *)
let getSecondHalf : bool list -> bool list = fun list ->
    let length = List.length list in let n = length / 2 in
    apply_function_n_times remove_head n list