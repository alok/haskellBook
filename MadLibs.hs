{-# LANGUAGE DeriveGeneric #-}

module MadLibs where

import           Data.Monoid
import           GHC.Generics
import           Test.QuickCheck

type Verb = String

type Adjective = String

type Adverb = String

type Noun = String

type Exclamation = String

madLib
  :: Exclamation -> Adverb -> Noun -> Adjective -> String
madLib e adv noun adj =
  mconcat [e
          ,"! he said "
          ,adv
          ," as he jumped into his car "
          ,noun
          ," and drove off with this "
          ,adj
          ," wife."]

asc :: Eq a
    => (a -> a -> a) -> a -> a -> a -> Bool
asc (<>) a b c = a <> (b <> c) == (a <> b) <> c

monoidId :: (Eq m,Monoid m)
         => m -> m -> Bool
monoidId m idElem = m `mappend` idElem == m && idElem `mappend` m == m

monoidAssoc :: (Eq m,Monoid m)
            => m -> m -> m -> Bool
monoidAssoc a b c = a <> (b <> c) == (a <> b) <> c

type S = String

type B = Bool

newtype Mem s a =
  Mem {runMem :: s -> (a,s)}

f' = Mem $ \s -> ("hi",s + 1)


main :: IO ()
main =
  quickCheck
    (monoidAssoc :: S -> S -> S -> B -- quickCheck
                                    -- (monoidId :: Mem String Int -> Mem String Int -> B)
     )
