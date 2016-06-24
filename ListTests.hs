module ListTests where

import           Test.Hspec
import           Test.QuickCheck

main :: IO ()
main = hspec $ do
  it "x/2*2 = x forall x" $ do
    property $ x == halfIdentity (x :: Num)
      where halfIdentity x = let half y = y/2 in
                                 (*2) . half

