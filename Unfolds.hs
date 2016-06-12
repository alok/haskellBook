import           Data.Maybe (fromJust, isNothing)

iterate' :: (a -> a) -> a -> [a]
iterate' f x = f x : iterate' f (f x)

unfoldr' :: (b -> Maybe (a, b)) -> b -> [a]
-- apply f to b to get a val of a in (a, b)
-- repeat with b in tuple to get another a
unfoldr' f b = if isNothing (f b) then [] else a : unfoldr' f b'
  where a = fst $ fromJust (f b)
        b' = snd $ fromJust (f b)

foldIterate :: (a -> a) -> a -> [a]
foldIterate f = unfoldr' (\a -> Just ( a, f a))

data BinaryTree a =
  Leaf
  | Node (BinaryTree a) a (BinaryTree a)
  deriving (Eq, Ord, Show)

unfold :: (a -> Maybe (a, b, a)) -> a -> BinaryTree b
unfold f a = if isNothing (f a) then Leaf else Node (unfold f a1) a2 (unfold f a3)
  where
    fst' (x, _, _) = x
    snd' (_, x, _) = x
    third (_, _, x) = x
    a1 = fst' $ fromJust (f a)
    a2 = snd' $ fromJust (f a)
    a3 = third $ fromJust(f a)

treeBuild :: Integer -> BinaryTree Integer
-- treeBuild =  unfold (\x -> if x <= 0 then Nothing else Just (x-1, x-1, x-1))
-- "seed" is at 0, and the value of 'n' controls how many steps before the tree terminates
treeBuild n =  unfold (\x -> if x >= n then Nothing else Just (x+1, x, x+1)) 0
