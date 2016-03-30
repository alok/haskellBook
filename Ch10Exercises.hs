module Ch10Exercises where

import Data.Time
import Data.List (genericLength, sort, length, foldl')

data DatabaseItem = DbString String
                  | DbNumber Integer
                  | DbDate   UTCTime
                  deriving (Eq,  Ord, Show)

  -- TODO can you do something like filterAttribute UTCTime x to get the above function
  -- filterAttribute :: a -> [DatabaseItem] -> [b]
  -- filterAttribute attrType xs = foldr (\x acc -> getAttribute x:acc) [] . filter isAttribute $ xs
  --   where isAttribute (attrType x) = True
  --         isAttribute _ = False
  --         getAttribute (attrType x) = x
  --         getAttribute _ = error "undefined"
  --         -- isAttribute _ = error "undefined"

theDatabase :: [DatabaseItem]
theDatabase =
  [ DbDate (UTCTime (fromGregorian 1911 5 1) (secondsToDiffTime 34123))
    , DbNumber 9001 ,
    DbString "Hello, world!" ,
    DbDate (UTCTime (fromGregorian 1921 5 1) (secondsToDiffTime 34123)) ]

-- TODO figure out whta it means by "a list of the UTCTime values inside them"
filterDbDate :: [DatabaseItem] -> [UTCTime]
filterDbDate xs = foldr (\x acc -> getUTC x:acc) [] . filter isUTC $ xs
  where isUTC (DbDate _) = True
        isUTC _ = False
        getUTC (DbDate x) = x
        getUTC (DbString _) = error "undefined"
        getUTC (DbNumber _) = error "undefined"

filterDbNumber :: [DatabaseItem] -> [Integer]
filterDbNumber xs = foldr (\x acc -> getNum x:acc) [] . filter isNum $ xs
  where isNum (DbNumber _) = True
        isNum _ = False
        getNum (DbNumber x) = x
        getNum (DbString _) = error "undef"
        getNum (DbDate _) =  error  "undef"

getMostRecentDate :: [DatabaseItem] -> UTCTime
getMostRecentDate = minimum . filterDbDate

sumDbNumber :: [DatabaseItem] -> Integer
sumDbNumber =  fromIntegral . sum . filterDbNumber

avgDbNumber :: [DatabaseItem] -> Double
avgDbNumber xs =  (realToFrac . sumDbNumber) xs / (realToFrac . length) xs

myReverse :: [a] -> [a]
myReverse = foldl' (flip (:)) []
