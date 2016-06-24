module Monoids where

import Data.Monoid

newtype List a =
  List [a]
  deriving (Eq,Show)

instance Monoid (List a) where
  mempty = List []
  mappend (List a) (List b) = List (b ++ a)

newtype Sum2 =
  Sum2 Integer
  deriving (Eq,Show)

newtype Product' =
  Product' Integer
  deriving (Eq,Show)

instance Monoid Sum2 where
  mempty = Sum2 0
  mappend (Sum2 x) (Sum2 y) = Sum2 (x + y)

instance Monoid Product' where
  mempty = Product' 1
  mappend (Product' x) (Product' y) = Product' (x * y)

data Optional a
  = Nada
  | Only a
  deriving (Eq,Show)

instance Monoid a => Monoid (Optional a) where
  mempty = Only mempty
  Nada `mappend` x = x
  x `mappend` Nada = x
  (Only x) `mappend` (Only y) = Only (x `mappend` y)
