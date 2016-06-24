{-# LANGUAGE DeriveGeneric #-}

module CheckSemigroup where

import           GHC.Generics
import           Test.QuickCheck

-- CLASS DECLARATION  ----------------------------------------------------------
class Semigroup a  where
  infixr 6 <>
  (<>) :: a -> a -> a

-- ASSOCIATIVITY PROPERTY TEST DECLARATION-------------------------------------
prop_Assoc :: (Eq m,Semigroup m)
           => m -> m -> m -> Bool
prop_Assoc a b c = a <> (b <> c) == (a <> b) <> c

-- DATA DECLARATIONS -----------------------------------------------------------
data Trivial =
  Trivial
  deriving (Eq,Show)

newtype Identity a =
  Identity a
  deriving (Eq,Show)

data Pair a b =
  Pair a
       b
  deriving (Eq,Show)

newtype BoolConj =
  BoolConj Bool
  deriving (Eq,Show)

data Or a b
  = Fst a
  | Snd b
  deriving (Eq,Show)

newtype Combine a b =
  Combine {unCombine :: a -> b}
  deriving ((Generic))

-- INSTANCES OF SEMIGROUP ------------------------------------------------------
instance Semigroup Trivial where
  _ <> _ = Trivial

instance Semigroup (Identity a) where
  a <> _ = a

instance Semigroup (Pair a b) where
  a <> _ = a

instance Semigroup BoolConj where
  (BoolConj False) <> _ = BoolConj False
  _ <> (BoolConj False) = BoolConj False
  (BoolConj True) <> (BoolConj True) = BoolConj True

instance Semigroup (Or a b) where
  (Snd a) <> _ = Snd a
  _ <> (Snd a) = Snd a
  (Fst a) <> (Fst b) = Fst b

-- INSTANCES OF ARBITRARY ------------------------------------------------------
instance Arbitrary Trivial where
  arbitrary = return Trivial

instance (Arbitrary a) => Arbitrary (Identity a) where
  arbitrary =
    do a <- arbitrary
       return (Identity a)

instance (Arbitrary a,Arbitrary b) => Arbitrary (Pair a b) where
  arbitrary =
    do a <- arbitrary
       b <- arbitrary
       return (Pair a b)

instance Arbitrary BoolConj where
  arbitrary =
    do a <- arbitrary :: Gen Bool
       return (BoolConj a)

instance (Arbitrary a,Arbitrary b) => Arbitrary (Or a b) where
  arbitrary =
    do a <- arbitrary
       b <- arbitrary
       oneof . fmap return $ [Fst a,Snd b]

-- TYPE ALIASES FOR QUICKCHECK -------------------------------------------------
type TrivialAssoc = Trivial -> Trivial -> Trivial -> Bool

type IdentityAssoc a = Identity a -> Identity a -> Identity a -> Bool

type PairAssoc a b = Pair a b -> Pair a b -> Pair a b -> Bool

type BoolConjAssoc = BoolConj -> BoolConj -> BoolConj -> Bool

type OrAssoc a b = Or a b -> Or a b -> Or a b -> Bool

main :: IO ()
main =
  do quickCheck (prop_Assoc :: Trivial -> Trivial -> Trivial -> Bool)
     quickCheck (prop_Assoc :: IdentityAssoc Int)
     quickCheck (prop_Assoc :: PairAssoc Int Bool)
     quickCheck (prop_Assoc :: BoolConjAssoc)
     quickCheck (prop_Assoc :: OrAssoc Int Int)
