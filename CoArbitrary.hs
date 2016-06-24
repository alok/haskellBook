{-# LANGUAGE DeriveGeneric #-}

module CoArbitrary where

import GHC.Generics
import Test.QuickCheck

data Bool' =
  True'
  | False'
  deriving (Generic)

instance CoArbitrary Bool'

trueGen :: Gen Bool
trueGen = coarbitrary True' arbitrary

falseGen :: Gen Bool
falseGen = coarbitrary False' arbitrary


main :: IO ()
main = sample falseGen
