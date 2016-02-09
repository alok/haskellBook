import Data.List

len = genericLength

coprime :: (Integral a) => a -> [a]
coprime a = filter (\x -> gcd a x == 1) [1..a]

et :: Integer -> Integer
et = len . coprime

factCheck :: Integer -> Integer -> Integer
factCheck p n
    | n `mod` p == 0 = 1 + factCheck p (n `div` p)
    | otherwise = 0

factorial :: Integer -> Integer
factorial a =  product [1..a]
