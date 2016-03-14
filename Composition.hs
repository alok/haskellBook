module Composition where

take5 :: Type -> Type
take5 xs =  take 5 . enumFrom $ 3

take5Odd :: Integer -> [Integer]
take5Odd xs =  take 5 . filter odd . enumFrom $ x

