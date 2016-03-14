module Ch7Exercises where

tensDigit :: (Integral a) => a -> a
tensDigit x =  (snd . divMod x)  10
-- or just x `mod` 10

foldBool3 :: a -> a -> Bool -> a
foldBool3 x y z = case z of
                    True  -> x
                    False -> y

foldBool3' x y z
  | z == True = x
  | z == False = y
  | otherwise = undefined
