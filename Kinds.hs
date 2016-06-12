-- kinds are just types that take other types as arguments

data Example a = Blah | RoofGoats | Woot a deriving (Eq, Show)

-- you can map a data constructor over a structure since data constructers are
-- just functions

-- = [Just 1, Just 2, Just 3]
exampleMap = fmap Just [1, 2, 3]

id :: a -> a
id a = a

replaceWord :: String -> String -> String -> String
replaceWord xs str replaceStr = unwords . map (\x -> if x == str then replaceStr else x) . words $ xs


-- head is a partial function, so watch out
countWord :: String -> Integer
countWord xs = count (words xs) 0
  where
    count :: [String] -> Integer -> Integer
    count [] n = n
    count ["the"] n = n -- watch out for case of `head []`
    count ("the" : xs) n = if head (head xs) `elem` "aeiou"
                           then count xs (n + 1)
                           else count xs n
    count (_ : xs) n = count xs n

vowelsInWord :: String -> Integer
vowelsInWord word = fromIntegral . length . filter testVowel $ word
  where testVowel x = x `elem` "aeiou"

consonantsInWord :: String -> Integer
consonantsInWord word = fromIntegral . length . filter testConstonant $ word
  where testConstonant x = x `notElem` "aeoiu"

newtype Word' = Word' String deriving (Eq, Show)

validWord :: String -> Maybe Word'
validWord word = if numOfVowels > numOfConsonants then Nothing else Just (Word' word)
  where numOfVowels = vowelsInWord word
        numOfConsonants = consonantsInWord word
-- count consonants
--
data Nat = Zero | Succ Nat deriving (Eq, Show)


natToInt :: Nat -> Integer
-- tail recursion is ugly, but i'm a fiend for speed sometimes
natToInt n = natToInt' n 0
  where
    natToInt' Zero n = n
    natToInt' (Succ x) n = natToInt' x (n+1)


intToNat :: Integer -> Maybe Nat
intToNat n = if n < 0 then Nothing else Just $ intToNat' n
  where intToNat' 0 = Zero
        intToNat' n = Succ $ intToNat' $ n -1

isJust :: Maybe a -> Bool
isJust (Just _) = True
isJust Nothing = False

fromJust :: Maybe a -> a
fromJust Nothing = error "not possible"
fromJust (Just x) = x

isNothing :: Maybe a -> Bool
isNothing x = not $ isJust x

mayybee :: b -> (a -> b) -> Maybe a -> b
mayybee acc f Nothing = acc
mayybee acc f (Just a) = f a

fromMaybe :: a -> Maybe a -> a
fromMaybe fallbackVal Nothing = fallbackVal
fromMaybe _ (Just a) = a

headMaybe :: [a] -> Maybe a
headMaybe [] = Nothing
headmaybe (x:xs) = Just x

catMaybes :: [Maybe a] -> [a]
catMaybes = map fromJust . filter isJust

flipMaybe :: [Maybe a] -> Maybe [a]
-- TODO find a better solution that doesn't involve going over the list 3 times
flipMaybe xs = if any isNothing xs then Nothing else Just $ map fromJust xs

lefts' :: [Either a b] -> [a]
-- if Left add its val to list else keep going
lefts' = foldr (\x xs -> getLeft x: xs) []
  where
    getLeft :: Either a b -> a
    getLeft (Left x) = x
    getLeft (Right _) = []
    -- GHC defines lefts as lefts x = [a | Left a <- x]
    --
rights' :: [Either a b] -> [b]
rights' x = [a | Right a <- x]

partitionEithers' :: [Either a b] -> ([a], [b])
partitionEithers' xs = (lefts' xs, rights' xs)

eitherMaybe' :: (b -> c) -> Either a b -> Maybe c
eitherMaybe' _ (Left _) = Nothing
eitherMaybe' f (Right b) = f b

either' :: (a -> c) -> (b -> c) -> Either a b -> c
either' f g (Left a)= f a
either' f g (Right b)= g b


