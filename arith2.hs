module Arith2 where

add :: Integer  -> Integer -> Integer  
add x y  =  x + y

addPointFree :: Integer  -> Integer  -> Integer 
addPointFree  =  (+)

addOne  =  \x  ->  x + 1

addOnePF = (+1)

main = do
    print $ addOnePF . addOne $ 0
