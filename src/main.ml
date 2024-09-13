open Primitives;;
open BigInt;;
open Utility;;
open DecisionTree;;
open Compression;;
open DotFileGen;;

(* Load all these modules in the top level only *)
(* #load "primitives.cmo";;
#load "bigInt.cmo";;
#load "utility.cmo";;
#load "decisionTree.cmo";;
#load "compression.cmo";;
#load "dotFileGen.cmo";; *)

let tab = table [25899L] 16;;
let cs = createDecisionBST tab;;
let resCompressionList = compressionList cs (Liste (ref []));;
let resCompressionTree = compressionTree cs (Node3 (ref (Empty3,ref Empty,Empty3)));;

let generateDot1 = generateDotFile resCompressionList "resCompressionListe.dot" ;; 
let generateDot2 = generateDotFile resCompressionTree "resCompressionArbre.dot" ;; 
let _ = generateDotFile cs "resAvantCompression.dot" ;;
(* #use "ouverture.ml";; *)
