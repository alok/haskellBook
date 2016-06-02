module AsPatterns where

import           Data.Char (toUpper)
import           Data.List.Split (splitOn)

subseq :: String -> String -> Bool
subseq "" "" = True
subseq _ "" = False
subseq "" _ = True
subseq subStr@(subHead:subTail)(strHead:strTail) = if subHead == strHead
                                                       then subseq subTail strTail
                                                       else subseq subStr strTail

capitalizeStr :: String -> String
capitalizeStr "" = ""
capitalizeStr (leadChar:strTail) = toUpper leadChar : strTail

capitalizeBlock :: (String -> [String]) -> String -> [(String, String)]
capitalizeBlock delimFunction s = map (\x -> (x, capitalizeStr x)) splitList
                        where splitList = delimFunction s


capitalizeSentence = capitalizeBlock splitOn ' '
capitalizeParagraph = capitalizeBlock splitOn '.'
