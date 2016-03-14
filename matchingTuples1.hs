module TupleFunctions where

addEmUp :: (Num a) => (a,a) -> a
addEmUp (x, y) = x + y

addEmUp2Alt :: (Num a) => (a,a) -> a
addEmUp2Alt xs = fst xs  + snd xs


k (x, y) = x -- projects first argument
k1 = k ((4-1), 10) -- = 3
k2 = k ("three", (1 + 2))
k3 = k (3, True)



g :: (a, b, c) -> (d, e, f) -> ((a, d), (c, f))
g (a,_,c) (d,_, f) = ((a,d), (c, f))

functionC x y =  case x > y of
                   True -> y
                   False -> x

ifEvenAdd2 n =  case even n of
                  True -> n + 2
                  False -> n

