module M1114 where

data Product a b =
  a :&: b
  deriving (Eq, Show)
