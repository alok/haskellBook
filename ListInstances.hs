module ListInstances where

import           Data.Monoid
import           Listy

instance Monoid (Listy a) where
  mempty = Listy []
  mappend (Listy l) (Listy l') = Listy (l `mappend` l')
