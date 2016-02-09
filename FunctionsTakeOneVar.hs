fnIgnoresArgs :: a -> a -> a -> String
fnIgnoresArgs x y z =  "Blah"

nonsense :: Bool -> Integer
nonsense True =  33
nonsense False =  22

curriedFn :: Integer -> Bool -> Integer
curriedFn i b =  i + nonsense b

anon :: Integer  -> Bool -> Integer
anon  =  \ i b -> (nonsense b)

anonManuallyNested :: Integer  -> Bool -> Integer
anonManuallyNested  =  \i  -> \b -> i + nonsense b


-- unconstrained types can only return a value since that's the
-- only universal type operation
unconstrainedPolymorphismIsNotSoGreat :: a -> a -> a
unconstrainedPolymorphismIsNotSoGreat x y =  x
-- or unconstrainedPolymorphismIsNotSoGreat x y =  y

twoArgsUnconstrained :: a -> b -> b
twoArgsUnconstrained x y = y
