module Guards1 where

myAbs :: Integer  -> Integer 
myAbs x
  | x < 0 = (-x)
  | otherwise = x

bloodNa :: Integer  -> String 
bloodNa x
  | x < 135 = "too low"
  | x > 145 = "too high"
  | otherwise = "just right"

pythagoreanTriangle :: (Real a) => a -> a -> a -> Bool
pythagoreanTriangle x y z
  | x^2 + y^2 == z^2 = True
| otherwise = False


