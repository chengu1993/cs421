type key = string

datatype tree = LEAF | TREE of tree * key * tree

val empty = LEAF

fun insert(key, LEAF) = TREE(LEAF, key, LEAF)
  | insert(key, TREE(l, k, r)) = 
		if key < k
			then TREE(insert(key, l), k, r)
		else if key > k
			then TREE(l, k, insert(key, r))
		else TREE(l, key, r)

fun member(key, LEAF) = false
  | member(key, TREE(l, k, r)) = 
		if key = k 
			then true
		else if key < k 
			then member(key, l)
		else member(key, r)



val root1 = insert("t", 
				insert("s", 
					insert("b", 
						insert("f", 
							insert("p", 
								insert("i", 
									insert("p", 
										insert("s", 
											insert("t", LEAF)))))))))

val root2 = insert("i", 
				insert("h", 
					insert("g", 
						insert("f", 
							insert("e", 
								insert("d", 
									insert("c", 
										insert("b", 
											insert("a", LEAF)))))))))

val exist1 = member("t", root1)

val exist2 = member("a", root1)


(*Extend Version*)

datatype 'a tree = LEAF | TREEMAP of 'a tree * key * 'a tree * 'a

fun insert(key, LEAF, value) = TREEMAP(LEAF, key, LEAF, value)
  | insert(key, TREEMAP(l, k, r, v), value) = 
		if key < k
			then TREEMAP(insert(key, l, value), k, r, v)
		else if key > k
			then TREEMAP(l, k, insert(key, r, value), v)
		else TREEMAP(l, key, r, value)

exception KeyNotExist
fun lookup(key, LEAF) = raise KeyNotExist
  | lookup(key, TREEMAP(l, k, r, v)) = 
		if key = k
			then v
		else if key < k 
			then lookup(key, l)
		else lookup(key, r)

val root3 = insert("a", insert("b", LEAF, 2), 3)
val value1 = lookup("a", root3)
val value2 = lookup("b", root3)
(*val value3 = lookup("c", root3)*)
