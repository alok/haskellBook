module FunctionWithWhere where printInc n = print plusTwo where plusTwo = n + 2

sayHello:: String -> IO ()
sayHello x = putStrLn ("hello" ++ ", " ++ x ++ "!")

sumTimesN :: Double -> Double -> Double -> Double
sumTimesN a b c = (a + b) * c


triple x = x * 3

areaCirc :: Double -> Double
areaCirc r = pi * r ^ 2

(quot x y) * y + (rem x y) == x
(div x y) * y + (x `mod` y) == x
