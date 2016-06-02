module Ch8 where

f :: Bool -> Maybe Integer
f False = Just 0
f _     = Nothing

-- TODO fix the case of dividing by just one negative
divBy:: Integer -> Integer -> Maybe Integer
divBy _ 0 = Nothing
divBy 0 _ = Just 0
divBy num denom = if num * denom > 0
                     then Just $ go num denom 0
                     else Just $ negate $ go (abs num) (abs denom) 0
                       where go n d count
                              | abs n < abs d = count
                              | otherwise = go (n - d) d (count + 1)

mc91 :: Integer  -> Integer
mc91 n = if n > 100
         then
         n - 10
         else
         (mc91 . mc91) (n + 11)


