module Main where

import Test.QuickCheck

-- for sum types
import Test.QuickCheck.Gen (oneof)

data Trivial = Trivial deriving (Eq, Show)
data Identity a = Identity a deriving (Eq, Show)


trivialGen :: Gen Trivial
trivialGen = return Trivial

identityGen :: Arbitrary a => Gen (Identity a)
identityGen = do
  a <- arbitrary
  return (Identity a)

instance Arbitrary Trivial where
  arbitrary = trivialGen

instance Arbitrary a => Arbitrary (Identity a) where
  arbitrary = identityGen

identityGenInt :: Gen (Identity Int)
-- the Int declaration specializes this function to be more concrete
identityGenInt = identityGen

main :: IO ()
main = sample trivialGen

-- arbitrary products

data Pair a b = Pair a b deriving (Eq, Show)

pairGen :: (Arbitrary a, Arbitrary b) => Gen (Pair a b)

pairGen = do
  a <- arbitrary
  b <- arbitrary
  return (Pair a b)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Pair a b) where
  arbitrary = pairGen

pairGenIntString :: Gen (Pair Int String)
pairGenIntString = pairGen

data Sum a b = First a | Second b deriving (Eq, Show)

sumGenEqual :: (Arbitrary a, Arbitrary b) => Gen (Sum a b)
sumGenEqual = do
  a <- arbitrary
  b <- arbitrary
  oneof . fmap return $ [First a, Second b]

sumGenCharInt :: Gen (Sum Char Int)
sumGenCharInt = sumGenEqual

sumGenFirstPls = do
  a <- arbitrary
  b <- arbitrary
  frequency $ zip [10, 1] (fmap return [First a, Second b])

sumGenCharIntFirst :: Gen (Sum Char Int)
sumGenCharIntFirst = sumGenFirstPls

-- TODO create list of arbitrary vals of len N
