# README
In this assignment, I Implemented a simple program analyzer and interpreter for the straight-line programming language. The detailed language specification can be found in _as1.sml_. This assignment is served to familiarize myself with ML programming, including introduction to environments, data structures, recursion techniques and a functional style of programming without assignment statements.
The code of assignment 1 is  in _as1.sml_ and code of extra credit is in _extra.sml_.
## Assignment 1.1
I implemented two auxiliary functions `maxargsE` and `maxargsEL` to make code structure cleaner. The entrance of the code is `maxargs`. 
### Function specification
#### maxargs
There are 3 scenarios for each statement: `SEQ`,  `ASSIGN` and `PRINT`. For `SEQ`, we can simply call `maxargs` recursively on its two sub-statement. For `ASSIGN` statement, we can call the auxiliary function `maxargsE` on its expression part. For `PRINT` statement, we can call `maxargsEL` function on the expression list and return length of list or the result of `maxargsEL`, whichever is larger .

#### maxargsE
Similarly,  there are 4 scenarios, but 2 of them can be merged together. For `ESEQ` expression, we call `maxargs` on sub-statement and `maxargsE` on sub-expression respectively.  For `BINOP`,  `maxargsE` is called on its two sub-expression. For `VAR` and `CONST` these two scenarios, we can simply return 0.

### maxargsEL
Last but not least, `maxargsEL` is used to analyze expression list. For a empty list, we can just return 0. Otherwise, we can call `maxargsE` on the head and call `maxargsEL` on its remaining part and return the larger one.
### Test
I use the test cases in _test1a.sml_ to test my programs. I calculated the result of these test cases manually and compared it with the result calculated by the program. The output  of my progarmm is as follows:
```
- use "test1a.sml";
[opening test1a.sml]
val prog = ASSIGN ("a1",CONST 500) : stm
val it = 0 : int
val prog = SEQ (ASSIGN ("a2",CONST #),PRINT [VAR #]) : stm
val it = 1 : int
val prog = SEQ (SEQ (ASSIGN #,ASSIGN #),PRINT [ESEQ #,BINOP #,BINOP #]) : stm
val it = 3 : int
val prog = SEQ (ASSIGN ("a",BINOP #),SEQ (ASSIGN #,PRINT #)) : stm
val it = 3 : int
val prog = SEQ (ASSIGN ("a",BINOP #),SEQ (ASSIGN #,PRINT #)) : stm
val it = 6 : int
val prog = SEQ (ASSIGN ("a",BINOP #),SEQ (ASSIGN #,PRINT #)) : stm
val it = 5 : int
```


## Assignment 1.2
`update` and `lookup` are used for maintaining the table. `interStm`, `interExp` and `interExpL` are 3 auxiliary functions to interpret the programs. The entrance of the code is `interp`.
### Function Specification
#### update
insert the new (id ` value) pair in the head position.

#### lookup
I defined an exception called `KeyNotExist`, which will be raised when id cannot be found in the table. If id is in the table, search all the way from the beginning of the list and return first appearance of value.

#### interp
This function calls `interStm` as side effect , initializes table as nil and return unit ().

#### interStm
For `SEQ` statement, call `interStm` recursively on its two sub-statements. For `ASSIGN` statement, first interpret the expression and get a new (id ` value) pair. Then use `update` function to insert the new pair. For `PRINT` statement, call `interExpL` function.

#### interExp
For `VAR` expression, I use `lookup` to search table and return the corresponding value and the original table. For `CONST`, we can simply return const value and the original table. For `BINOP`, we first interpret two sub expressions and then use the result of previous interpretation to calculate the value of current expression by using a case statement. 

#### interExpL
For an empty list,  we can just return the original table. For lists with only one element, we can call `interExp` on the expression, print out the value of that expression. Here I also print out the newline character for simplicity because we know it is the end of a expression list. For lists with multiple elements,  we interpret the head expression, print out the value, followed by a space. Then we can continue interpreting the remaining part.
### Test
I use the test cases in _test1a.sml_ to test my programs. I calculated the result of these test cases manually and compared it with the result calculated by the program. The output  of my progarmm is as follows:
```
[opening test1b.sml]
val prog = ASSIGN ("a1",CONST 500) : stm
val it = () : unit
val prog = SEQ (ASSIGN ("a2",CONST #),PRINT [VAR #]) : stm
6
val it = () : unit
val prog = SEQ (SEQ (ASSIGN #,ASSIGN #),PRINT [ESEQ #,BINOP #,BINOP #]) : stm
500
400
500 250000 1
250
val it = () : unit
val prog = SEQ (ASSIGN ("a",BINOP #),SEQ (ASSIGN #,PRINT #)) : stm
6 2 6000
val it = () : unit
val prog = SEQ (ASSIGN ("a",BINOP #),SEQ (ASSIGN #,PRINT #)) : stm
8 8 8 8 8 8
7
80 80 80 80 80 8
val it = () : unit
val prog = SEQ (ASSIGN ("a",BINOP #),SEQ (ASSIGN #,PRINT #)) : stm
8 7
9990
val it = () : unit
val prog = SEQ (ASSIGN ("a",BINOP #),SEQ (ASSIGN #,PRINT #)) : stm
8 7
80
val it = () : unit
```

## Extra Credit
### a: member function
The idea is the same as `insert` function. Starting from the root node, compare _key_ with _key of current node_. If _key_ equals to _key of current node_, we can return true. If _key_ is smaller than _key of current node_, we recursively search the left sub tree. If larger, we search the right sub tree.

### b: extend to support mapping of keys to bindings
Below is the definition of a generic tree.
```
datatype 'a tree = LEAF | TREEMAP of 'a tree * key * 'a tree * 'a
```
The basic idea of  `insert` and `lookup` function is the same as previous one. I define a **KeyNotExist** exception for `lookup` function, which will be raise when a certain cannot be found in the tree.

### c: demonstrate these trees are not balanced
* t s p i p f b s t
```
          t
         /
        s
       /
      p 
     /
    i
   /
  f
 /
b
```
From the representation of this tree above, we can see that this tree somehow resembles a linked list. It is actually the worst case we can meet. In such case, the time complexity of insertion can go up to **O(N)**
* a b c d e f g h i
The result of insertion:
```
a
 \
   b
     \
       c
         \
          d
            \
	            e
                \
		  			f
		    		  \
                     g
			 			 \
			   			   h
			     			\
			       			  i
```
The situation is almost the same as the previous one. The tree is like a single linked list, which achieves the worst case time complexity **O(N)**.

### d: find an algorithm that rebalances on insertion rather than lookup.
The algorithm I find is called **Red-black BST**.
* Search: To determine whether a key is in a 2-3 tree, we compare it against the keys at the root: If it is equal to any of them, we have a search hit; otherwise, we follow the link from the root to the subtree corresponding to the interval of key values that could contain the search key, and then recursively search in that subtree. We can see the structure of the tree is not modified in this searching process.
* Insert: To insert a new node in a 2-node, we can just simply  replace the node with a 3-node containing its key and the new key to be inserted. The overall structure is not changed. To insert node in a 3-node, in someway like a B+ Tree in database, we need to split nodes if there is no room for extra keys. The split process can be cascading. After the structure is stabilized,  the tree will be balanced again.