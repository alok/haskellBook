module Gen where

import           Test.QuickCheck
import           Test.QuickCheck.Gen (oneof)

-- data
data Fool
  = Fulse
  | Frue
  deriving (Eq,Show)

-- generator
-- foolGen :: Gen Fool
-- foolGen = oneof $ wrap [Fulse,Frue]
-- where wrap = fmap return
-- foolGen = return Fulse
-- instance
foolGen :: Gen Fool
foolGen = frequency (zip freqs wrappedVals)
  where freqs = [2,1]
        wrappedVals = fmap return [Fulse,Frue]

instance Arbitrary Fool where
  arbitrary = foolGen

main :: IO ()
main = sample foolGen
