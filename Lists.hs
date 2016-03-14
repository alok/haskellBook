module Lists where

myTail :: [a] -> Maybe [a]
myTail []     = Nothing
myTail [x] = Nothing
myTail (_:xs) = Just xs

-- my own version of enumFromTo
eft :: (Enum a, Ord a) => a -> a -> [a]
eft x y = case compare x y of
            GT -> []
            EQ -> [x]
            LT -> x: eft (succ x) y

-- split on delim
myWords :: String  -> [String]
myWords []   = []
myWords xs =  takeWhile (/= ' ') xs : (myWords . drop 1 . dropWhile (/= ' ') $ xs)
