open DecisionTree;;
let rec generateGraphvizString : decisionBST -> string = fun tree ->
    let ennuaireNode  = 
    let rec collect tree id  =
    match tree with
    | Empty -> []
    | Leaf l -> [(tree, id)]
    | Node (left, _, right) -> [(left, (id*2))] @ [(right, (id*2+1))] @  collect left (id*2)  @ collect right (id*2+1) 

    in collect tree 1 in

    let rec recherche_collect node listData =
        match listData with
        | [] -> (-1)
        | ((n,i)::l) -> if n == node 
            then (i) 
            else recherche_collect node l 
        in
    (* let ennuaireClosed: decisionBST list ref = ref [] in *)
    let listClosed: decisionBST list ref = ref [] in
    let rec aux tree id =

        match tree with
        |   Empty -> "" 
        |   Leaf (x) -> let nId = recherche_collect  tree ennuaireNode in
            Printf.sprintf "node%d [label=\"%b\"];\n" nId x
        | Node (left, value, right) -> 
            let dejaDot = 
                let rec find stapeNode =
                match stapeNode with
                | [] -> false
                | h::l -> if h == tree then true else find l 
                in
                find !listClosed
            in  
            if (dejaDot) then
                ""
                else begin
                listClosed := tree :: !listClosed;
                let left_id = recherche_collect left ennuaireNode in
                let right_id = recherche_collect right ennuaireNode in
                let left_str = aux left (left_id) in
                let right_str = aux right (right_id) in
            
        
                let node_str = Printf.sprintf "node%d [label=\"%d\"];\n" id value in
                let left_link = Printf.sprintf "node%d -> node%d [style=\"dotted\"];\n" id left_id in
                let right_link = Printf.sprintf "node%d -> node%d;\n" id right_id in
                node_str ^ left_str ^ right_str ^ left_link ^ right_link
                end
    in
    aux tree 1

(* Store the generated file into dot file *)
let generateDotFile : decisionBST -> string -> unit = fun tree filename ->
    let oc = open_out filename in
    Printf.fprintf oc "digraph G {\n%s}" (generateGraphvizString tree);
    close_out oc