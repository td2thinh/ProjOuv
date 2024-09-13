(* Decision Binary Search Tree type definition *)
open Utility;;
open BigInt;;
open Primitives;;

type decisionBST = 
    | Empty
    | Leaf of bool
    | Node of decisionBST * int * decisionBST

(* Create a decision tree from a list of bool *)
let rec createDecisionBST : bool list -> decisionBST = fun list ->
    let height = ceilBase2 (List.length list) in
    let list = completion list (int_of_float(2. ** height)) in 
    let rec aux list a = 
    match (list,a) with
    | (h::t, x) when x = (int_of_float height) + 1 -> Leaf (h)
    | (list, x) -> Node (aux (getFirstHalf list) (x + 1) , x, aux (getSecondHalf list) (x + 1))
    in aux list 1

(* Get list of leafs of a node *)
let rec listLeaf : decisionBST -> bool list = fun tree ->
    match tree with
    | Empty -> failwith "Empty Tree"
    | Leaf (x) -> [x]
    | Node (left, _, right) -> listLeaf left @ listLeaf right

(* Return number of nodes in a tree *)
let rec countNodes : decisionBST -> int = fun tree ->
    match tree with
    | Empty -> 0
    | Leaf (_) -> 1
    | Node (left, _, right) -> 1 + countNodes left + countNodes right

(* Return number of leafs in a tree *)