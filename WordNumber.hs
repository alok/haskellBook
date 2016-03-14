module WordNumber where

import Data.List (intersperse)

digitToWord :: Integer -> String
digitToWord n = case n of
                  0 -> "zero"
                  1 -> "one"
                  2 -> "two"
                  3 -> "three"
                  4 -> "four"
                  5 -> "five"
                  6 -> "six"
                  7 -> "seven"
                  8 -> "eight"
                  9 -> "nine"
                  _ -> "you shouldn't be here!"

digits :: Integer -> [Integer]
-- digits n = if n < 10 then [n] else reverse $ (rem n 10) : (digits (div n 10))
digits n = if n < 10 then [n] else digits (div n 10) ++ [rem n 10]

wordNumber :: Integer -> String
wordNumber n = (concat . intersperse "-" . map digitToWord) $ digits n

