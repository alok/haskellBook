module Ch9Exercises where


myOr :: [Bool] -> Bool
myOr [] = False
myOr (True: _) = True
myOr (_:xs) = myOr xs

myAnd :: [Bool] -> Bool
myAnd [] = True
myAnd (False:_) = False
myAnd (_:xs) = myAnd xs

myAny :: (a -> Bool) -> [a] -> Bool
myAny f xs =  myOr $ map f xs

myElem :: (Eq a) => a -> [a] -> Bool
myElem x =  myAny (== x)

squish :: [[a]] -> [a]
-- TODO make this less slow
squish xss = foldr (++) [] xss

squishMap :: (a -> [b]) -> [a] -> [b]
squishMap f xs =  squish $ map f xs

squishAgain :: [[[a]]] -> [a]
squishAgain xss =  squish . map squish $ xss
