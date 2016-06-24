module Functors where

class Functor' f  where
  fmap' :: (a -> b) -> f a -> f b

data Tree a = Leaf | Node (Tree a) a (Tree a) deriving (Eq, Show)

instance Functor' fmap' where
  fmap' _ Leaf = Leaf
  fmap' f Node left a right = (fmap' f left) f a (fmap' f right)
