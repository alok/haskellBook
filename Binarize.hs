a = [[3,2,1.2],[3,5,0.1]]

f :: (Num a, Ord a) => [a] -> [Integer]
f =  map (\x -> if x > 0 then 1 else 0)

g ::(Num a, Ord a) => [[a]] -> [[Integer]]
g = map f
