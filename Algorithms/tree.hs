
data Tree a = Empty | Node (Tree a) a (Tree a)

isEmpty :: (Ord a) => Tree a -> Bool
isEmpty Empty = True
isEmpty  _    = False

contains :: Tree a -> a -> Bool
contains Empty _ = False
contains (Node t1 v t2) x 
  | x == v = True
  | x  < v = contains t1 x 
  | x  > v = contains t2 x

insert :: Tree a -> a -> Tree a
insert Empty x = Node Empty x Empty
insert (Node t1 v t2) x 
	| v == x = Node t1 v t2
	| v  < x = Node t1 v (insert t2 x)
	| v  > x = Node (insert t1 x) v t2

--delete

--find


delete :: Tree a -> a -> Tree a
delete Empty _ = Empty
delete (Node t1 v t2) x  
	| x == v = deleteRoot (Node t1 v t2)
	| x  < v = Node (delete t2 x) v t2
	| x  > v = Node t1 v (delete t2 x)

deleteRoot :: Tree a -> Tree a 
deleteRoot (Node Empty v t2) = t2
deleteRoot (Node t1 v Empty) = t1
deleteRoot (Node t1 v t2) = (Node t1 v2 t2) --(delete t2 v2))
	where 
		v2 = leftistElement t2

-- Return leftist element of tree (is used on subtree)
leftistElement :: (Ord a) => Tree a -> a
leftistElement (Node Empty v _) = v
leftistElement (Node t1 _ _) = leftistElement t1

-- Create tree from list of elemtents
createTree :: [a] -> Tree a
createTree [] = Empty
createTree (h:t) = createTree2 (Node Empty h Empty) t
	where
		createTree2 tr [] = tr
		createTree2 tr (h:t) = createTree2 (insert tr h) t

-- Create perfect balance BST
createTreePB :: (Ord a) => [a] -> Tree a
createTreePB [] = Empty
createTreePB s = cpb Empty (qsort s) 

cpb :: (Ord a) => Tree a -> [a] -> Tree a
cpb tr [] = tr
cpb tr t = cpb (insert tr e) t2
	where	
		e = middleEl t
		t2 = Data.List.delete e t

-- Element in middle
middleEl :: (Ord a) => [a] -> a
middleEl s = mEl s s 

mEl :: (Ord a) => [a] ->  [a] -> a
mEl    []    (h:s2) = h
mEl (_:[])   (h:s2) = h
mEl (_:_:s1) (_:s2) = mEl s1 s2

{- PRINT -}
inorder :: (Ord a) => Tree a -> [a]
inorder Empty = []
inorder (Node t1 v t2) = inorder t1 ++ [v] ++ inorder t2

preorder :: (Ord a) => Tree a -> [a]
preorder Empty = []
preorder (Node t1 v t2) = [v] ++ preorder t1 ++ preorder t2

postorder :: (Ord a) => Tree a -> [a]
postorder Empty = []
postorder (Node t1 v t2) = postorder t1 ++ postorder t2 ++ [v]

-- from wiki
levelorder :: (Ord a) => Tree a -> [a]
levelorder t = step [t]
	where
		step [] = []
		step ts = concatMap elements ts ++ step (concatMap subtrees ts)
		elements Empty = []
		elements (Node left x right) = [x]
		subtrees Empty = []
		subtrees (Node left x right) = [left,right]

qsort :: (Ord a) => [a] -> [a] 
qsort [] = []
qsort (h:t) = (qsort [x| x<-t, x < h]) ++ [h] ++ (qsort [x| x<-t, x>=h ])
