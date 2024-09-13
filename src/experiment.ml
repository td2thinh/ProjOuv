open Primitives;;
open BigInt;;
open Utility;;
open DecisionTree;;
open Compression;;
open DotFileGen;;
open Unix;;

(* #load "primitives.cmo";;
#load "bigInt.cmo";;
#load "utility.cmo";;
#load "decisionTree.cmo";;
#load "compression.cmo";;
#load "dotFileGen.cmo";; *)


let generate_random_compressed_tree = fun n ->
  let randomBigInt = genAlea n in
  let table = decomposition randomBigInt in 
  let randomTree = createDecisionBST table in
  let nNodes = countNodes randomTree in
  let timeStart = Unix.gettimeofday() in
  let memoryStart = (Gc.stat()).minor_words in
  let compressedTree = compressionList randomTree (Liste (ref [])) in
  let memoryEnd = (Gc.stat()).minor_words in
  let timeEnd = Unix.gettimeofday() in
  let time = (timeEnd -. timeStart ) in
  let memory =  (memoryEnd -. memoryStart) *. 8. in
  let memory = Float.to_int memory in
  let nNodesCompressed = countNodes compressedTree in
  let compressionRate = (float_of_int nNodesCompressed) /. (float_of_int nNodes) *. 100. in
  let timeStart = Unix.gettimeofday() in
  let memoryStart = (Gc.stat()).minor_words in
  let _ =  compressionTree randomTree Empty3 in 
  let memoryEnd = (Gc.stat()).minor_words in
  let timeEnd = Unix.gettimeofday() in
  let time2 = (timeEnd -. timeStart ) in
  let memory2 =  (memoryEnd -. memoryStart) *. 8. in  
  let memory2 = Float.to_int memory2 in
  n, time, memory, compressionRate, nNodes, nNodesCompressed, time2, memory2

let generate_random_rows_csv : int -> int -> string = fun start finish ->
  let rec aux = fun n ->
    if (n + 500) > finish then ""
    else
           let  n, time, memory, compressionRate, nNodes, nNodesCompressed, time2, memory2 = generate_random_compressed_tree n in
      let row = string_of_int n ^ "," ^ string_of_float time ^ "," ^ string_of_int memory ^ "," ^ string_of_float compressionRate ^ "," ^ string_of_int nNodes ^ "," ^ string_of_int nNodesCompressed ^ "," ^ string_of_float time2 ^ "," ^ string_of_int memory2 ^ "\n" 
    in row ^ aux (n + 500)
  in
  let header = "nbits,time1,memory1,compressionRate,nNodes,nNodesCompressed,time2,memory2\n" in
  header ^ aux start

let generate_csv = fun filename ->
  let file = open_out filename in
  Printf.fprintf file "%s" (generate_random_rows_csv 1024 (131072 / 4));
  close_out file


let generate_random_compressed_tree2 = fun n->
  let randomBigInt = genAlea n in
  let table = decomposition randomBigInt in 
  let randomTree = createDecisionBST table in
  let compressedTree = compressionTree randomTree Empty3 in 
  let nNodesCompressed = countNodes compressedTree in
  nNodesCompressed

let generate_random_rows_csv2 : int -> int -> string = fun start finish ->
  let rec aux = fun n ->
    if (n + 1) > finish then ""
    else
      let nNodes = generate_random_compressed_tree2 1000 in
      let row = string_of_int nNodes ^ "\n" in
      row ^ aux (n + 1)
  in
  let header = "nodes\n" in
  header ^ aux start

let generate_csv2 = fun filename ->
  let file = open_out filename in
  Printf.fprintf file "%s" (generate_random_rows_csv2 0 10000);
  close_out file


let _ = generate_csv "random.csv"
let _ = generate_csv2 "random2.csv"