module Addition where

import Test.Hspec
import Test.QuickCheck


dividedBy :: Integral a => a -> a -> (a, a)
dividedBy num denom = go num denom 0
  where go n d count
          | n < d = (count, n)
          | otherwise = go (n - d) d (count + 1)


mul :: (Integral a) => a -> a -> a
mul 0 _ = 0
mul _ 0 = 0
mul n m
  | n < m = mul m n
  | n < 0 && m < 0 = mul (abs n) (abs m)
  | n < 0 || m < 0 = negate $ mul (abs n) (abs m)
  | otherwise = n + mul n (m - 1)

-- main :: IO ()
-- main = hspec $
--   describe "Addition" $ do
--     it "1 + 1 is greater than 1" $
--       (1 + 1) > 1 `shouldBe` True
--     it "2+2 = 4" $
--       2 + 2 `shouldBe` 4
--     it "correct number of subtractions and remainder" $
--       dividedBy 7 2 `shouldBe` (3, 1)
--     it "0 in 1st arg case" $
--       mul 0 (-3) `shouldBe` 0
--     it "0 in 2nd arg case" $
--       mul 3 0 `shouldBe` 0
--     it "pos pos" $
--       mul 3 2 `shouldBe` 6
--     it "neg neg" $
--       mul (-3) (-2) `shouldBe` 6
--     it " pos neg" $
--       mul 3 (-2) `shouldBe` (-6)
--     it "neg pos" $
--       mul (-2) 3 `shouldBe` (-6)

main :: IO ()
main = hspec $
  describe "Addition" $ do
    it "all cases of mul" $ do
      mul 0 (-3) `shouldBe` 0
      mul 3 0 `shouldBe` 0
      mul 3 2 `shouldBe` 6
      mul (-3) (-2) `shouldBe` 6
      mul 3 (-2) `shouldBe` (-6)
      mul (-2) 3 `shouldBe` (-6)
    it  "x+1 > x forall x" $
      property $ \x -> x + 1 > (x :: Integer)

