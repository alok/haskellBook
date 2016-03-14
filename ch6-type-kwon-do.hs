chk :: Eq b => (a -> b) -> a -> b -> Bool
chk f a b = f a == b

arith :: Num b =. (a -> b) -> Integer  -> a -> b
arith f z a = f a + z

-- all the same function written in increasingly dumb ways
mTh1 x y z = x * y * z
mTh3 = \x -> \y -> \z -> x * y * z
mTh4 x y = \z -> x * y * z
mTh2 x = \y -> \z -> x * y * z

addOneIfOdd x =  case odd x of
                   True -> f x
                   False -> x
                       where f n = (\ n -> n + 1)

addFive = (\ x y -> if x > y then y else x) + 5

-- write flip without lambda
lambdaFlip f =  \ x y -> f y x
mflip f x y =  f y x

