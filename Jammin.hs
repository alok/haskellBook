module Jammin where

import Data.List
import Data.Ord (comparing)
import Data.Function (on)

data Fruit =
  Peach
  | Plum
  | Apple
  | Blackberry
  deriving (Eq, Ord, Show)

data JamJar =
  Jam {fruit :: Fruit, number :: Int}
  deriving (Eq, Ord, Show)

row1 :: JamJar
row1 = Jam Peach 3

row2 :: JamJar
row2 = Jam Plum 2

row3 :: JamJar
row3 = Jam Apple 1

allJam :: [JamJar]
allJam = [row1, row2, row3]

seeRecords :: [Int]
seeRecords = map number allJam

totalJarsOfJam :: [JamJar] -> Int
totalJarsOfJam =  sum . map number

mostRow :: [JamJar] -> JamJar
mostRow = maximumBy (comparing number)

sortFruit :: [JamJar] -> [JamJar]
sortFruit = sortBy (comparing fruit)

groupJam :: [JamJar] -> [[JamJar]]
groupJam = groupBy ((==) `on` fruit)

-- can be generalized to replace 'fruit' with any function
