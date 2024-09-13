open Utility;;
open BigInt;;
open Primitives;;
open DecisionTree;;

type visitedNodeList =
    | Empty2
    | Liste of  (bigInt * decisionBST) list ref

type visitedNodesTree =
    | Empty3
    | Node3 of (visitedNodesTree * decisionBST ref * visitedNodesTree) ref


(* Search for a node that has been visited *)
let rec searchVisitedNodesList : bigInt -> visitedNodeList -> (bool*decisionBST) = fun n list ->
    match list with
            | Empty2 -> (false, Empty)
            | Liste l ->
                let rec search_inner l =
                    match l with
                    | [] -> (false, Empty)
                    | (v, decision)::rest ->
                        if v = n then
                            (true, decision)
                        else
                            search_inner rest
                in
                search_inner !l 


(* Add a node to list of nodes *)
let addList : (bigInt * decisionBST) -> visitedNodeList -> visitedNodeList = fun addnode list ->
        match list with
        | Empty2 -> let newRefList = ref [] in
                    newRefList := [addnode];
                    Liste newRefList
        | Liste l -> l := addnode :: !l; list


(* Compress with a liste *)
let rec compressionList : decisionBST -> visitedNodeList -> decisionBST = fun tree list ->
   let rec compression tree list =
            match tree with
            | Empty -> (Empty,  [])
            | Leaf (b) ->  
                let n = composition [b] in 
                let (found, decision) = searchVisitedNodesList n list in
                if found 
                    then (decision, [b])
                else
                    let _ = addList (n, tree) list in
                    (tree, [b]) 
            | Node (left, value, right) ->
                let (new_left, leftLeafs) = compression left list in
                let (new_right, rightLeafs) = compression right list in
                (* Si la deuxième moitié de la liste ne contient que des valeurs false
                alors remplacer le pointeur vers N (depuis son parent) vers un pointeur 
                vers l'enfant gauche de N *)
                if (List.for_all (fun x -> x = false) rightLeafs) then
                    (new_left, leftLeafs @ rightLeafs)
                else
                    let listLeafs = leftLeafs @ rightLeafs in
                    let n = composition listLeafs in
                    let (found, decision) = searchVisitedNodesList n list in
                    if found then
                        (decision, listLeafs)
                    else
                        let newNode = Node (new_left, value, new_right) in 
                        let _ = addList (n, newNode) list in
                        (* On renvoie le nœud et la liste de ses feuilles *)
                        (newNode, listLeafs)
    in
    let (compresed,leafs) = compression tree list in
    compresed  


(* Search for a node in a tree *)
let rec searchVisitedNodesTree : bool list -> visitedNodesTree -> (bool * decisionBST ref) = fun truthTable treeDataRef ->
    match (truthTable, treeDataRef) with
    | ([],  Empty3) -> (false, ref Empty)
    | ([],  (Node3 l)) ->  let (left, tree,  right) = !l in
        if (!tree) <> Empty then  (true,  tree) else  (false, ref Empty)
    | (_,  Empty3) -> (false,  ref Empty)
    | (h::t, (Node3 l)) -> let (left, tree, right) = !l in    
        if h == true then
            searchVisitedNodesTree t right
        else
            searchVisitedNodesTree t left

(* Add a node to a tree *)
let rec addTree : bool list -> decisionBST ref -> visitedNodesTree -> visitedNodesTree = fun truthTable treeAdd treeData ->
    match (truthTable, treeData) with
    | ([],Empty3) -> Node3 (ref (Empty3,treeAdd,Empty3))
    | ([],noeud) -> noeud                                                   (* le noeud existe deaja *)
    | (h::t, Empty3) ->  if h==true 
        then  Node3  (ref (Empty3,ref Empty, (addTree t treeAdd Empty3)) )
        else  Node3 (ref ((addTree t treeAdd Empty3), ref Empty, Empty3)) 
    | (h::t, Node3 l) -> let (left, tree, right) = !l in
        if h = true 
        then 
            let  newNode = (left, tree, (addTree t treeAdd right)) in 
            let _ = l := newNode in
            Node3 l
        else 
            let  newNode = ((addTree t treeAdd left), tree, right) in
            let _ = l := newNode in 
            Node3 l


(* Compress with a tree *)
let rec compressionTree : decisionBST -> visitedNodesTree -> decisionBST = fun tree arbreData ->
    let rec compression tree arbreData =
    match !tree with
    | Empty -> (tree, []);
    | Leaf (b) -> let leafs = [b] in  let (found, decision) = searchVisitedNodesTree leafs arbreData  in
        if found 
            then 
                (decision, leafs)
            else
                let _= addTree [b] tree arbreData in
                (tree, leafs)
    | Node (left, value, right) ->
        let (new_left, leafLeft) = compression (ref left) arbreData in
        let (new_right, leafRight) = compression (ref right) arbreData in
        if (List.for_all (fun x -> x = false) leafRight) then
            (new_left, leafLeft @ leafRight)
        else
            let leafsList = leafLeft @ leafRight in
            let (found, decision) = searchVisitedNodesTree leafsList arbreData in
            if found then
                (decision, leafsList)
            else
                let newNode = Node (!new_left, value, !new_right) in
                let newRefNode = ref newNode in
                let _ = addTree leafsList newRefNode arbreData in
                (newRefNode, leafsList)
    in
    let (compresed,feuilles) = compression (ref tree) arbreData in
    !compresed 