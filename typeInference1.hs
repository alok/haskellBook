-- f :: Num a => a  -> a -> a
import Data.List
f x y =  x  + y + 3

myAlph x   = x < 'z'
myConcat x = x ++ "yo"
myTake x   = take x "hey you"
myCom x    = x > genericLength [1..10]

h = head [(0, "dog"), (1, "kitty")]

x = 5 
y = x + 5
w = y/3 * 10

z = 4 / y

-- since ^ binds tighter, we get (^5) 10, which is OK
bigNum = (^) 5 $ 10
-- shouldn't work as we have too many args

main :: IO ()
main = do
    print $ 1 + 2
    putStrLn $ show 10
    print $ negate (-1)
    print ((+) 0 blah)
        where blah = negate 1

data X
data Y
data Z

xz::X -> Z
xz = undefined

yz::Y -> Z
yz = undefined

xform :: (X, Y) -> (Z, Z)
xform (x,y) = (xz x, yz y)
-- take x, apply it to first arg (xz), apply the result to ys, and take the fst
munge :: (x -> y) -> (y -> (w,z)) -> x -> w
munge xw yw x = fst . yw . xw $ x
