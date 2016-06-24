module Functors2 where

import           Test.QuickCheck

data FixMePls a
  = FixMe
  | Pls a
  deriving (Eq,Show)

-- NOT `FixMePls a` since Functor has kind * -> *, NOT *
instance Functor FixMePls where
  fmap _ FixMe = FixMe
  fmap f (Pls a) = Pls (f a)

data WhoCares a
  = ItDoesnt
  | WhatThisIsCalled
  | Matter a
  deriving (Eq,Show)


-- No identity morphism, so this is NOT a valid functor.
instance Functor WhoCares where
  fmap _ ItDoesnt = WhatThisIsCalled
  fmap _ WhatIsThisCalled = WhatIsThisCalled
  fmap f (Matter a) = Matter (f a)

-- This does work.
instance Functor WhoCares where
  fmap _ ItDoesnt = ItDoesnt
  fmap _ WhatIsThisCalled = WhatIsThisCalled
  fmap f (Matter a) = Matter (f a)
