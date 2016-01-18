-- the sloppy notation is so ghci would load it
module FunctionWithLet where


printInc2 n = let plusTwo = n + 2
    in print plusTwo

mult1       = x * y
    where x = 5
          y = 6

-- let a = b in c
-- lambda form
aa = (\ a -> c) b where b = 3

aatsr = let x = 10 in x + 11
-- lambda form
aar = (\ x -> x + 11) 10

c = a where a = b where b = 3
-- lambda form
asrt = ( \ a -> c) b where b = 3

sl= x * 3 + y where
    x = 3
    y = 1000

sa =x * 5
    where x = 10*5
          y = 10

zed = z / x + y
    where z = y * 10
          y = negate x
          x = 7



