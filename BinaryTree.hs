data BinaryTree a = Leaf
                  | Node (BinaryTree a) a (BinaryTree a)
                  deriving (Eq, Ord, Show)

insert' :: (Ord a) => a -> BinaryTree a -> BinaryTree a
insert' b Leaf = Node Leaf b Leaf
insert' b (Node left a right)
  | b <= a = Node (insert' b left) a right
  | b > a = Node left a (insert' b right)

tmap :: (a -> b) -> BinaryTree a -> BinaryTree b
tmap _ Leaf =  Leaf
tmap f (Node left a right) = Node (tmap f left) (f a) (tmap f right)

testTree' :: BinaryTree Integer
testTree' = Node (Node Leaf 3 Leaf) 1 (Node Leaf 4 Leaf)
mapExpected = Node (Node Leaf 4 Leaf) 2 (Node Leaf 5 Leaf)

-- acceptance test for mapTree
mapOkay = if tmap (+1) testTree' == mapExpected
          then print "yup okay!"
          else error "test failed!"

inOrder :: BinaryTree a -> [a]
inOrder Leaf =  []
inOrder (Node left a right) = concat [inOrder left, [a], inOrder right]

testTree = Node (Node Leaf 1 Leaf) 2 (Node Leaf 3 Leaf)

tfold :: (a -> b -> b) -> b -> BinaryTree a -> b
tfold f acc tree = foldr f acc (inOrder tree)
