import Data.List

-- Will it typecheck?
f :: Float 
-- f ::  Num a => a
-- needs Float bc Int is not w/ a decimal point
f = 1.0

g :: (Fractional a) => a
g =  1.0

i :: Num a => a
i = 1

h :: RealFrac a => a
h = 1.0

freud :: Ord a => a -> a
freud x =  x

myX = 1:: Int 

sigmund :: Num a => a -> a
sigmund x =  myX

mySort :: [Char]  -> [Char]
mySort = sort

-- won't work because mySort can only output strings, coercing the
-- return type of signifier to be string
-- signifier :: Ord a => [a]  -> a
signifier :: String  -> String 
signifier xs = head (mySort xs)
