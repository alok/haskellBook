-- module Main where

import           Control.Monad (forever)
import           Data.Char     (toLower)
import           Data.List     (intersperse)
import           Data.Maybe    (isJust)
import           System.Exit   (exitSuccess)
import           System.Random (randomRIO)


type WordList = [String]

minWordLength = 6
maxWordLength = 9


allWords :: IO WordList
allWords = do
  dict <- readFile "data/dict.txt"
  return (lines dict)


gameWords :: IO WordList
gameWords = do
  aw <- allWords
  return (filter gameLength aw)
    where gameLength w = minWordLength < l && l < maxWordLength where l = length w


randomWord :: WordList -> IO String
randomWord wl = do
  randomIndex <- randomRIO (0, length wl - 1)
  return (wl !! randomIndex)


main :: IO ()
main = randomWord gameWords

randomWord' :: IO String
randomWord' = gameWords >>= randomWord

-- the word, our correct guesses (could be empty -> Nothing), our guesses
data Puzzle = Puzzle String [Maybe Char] [Char] deriving (Eq)

instance Show Puzzle where
  show (Puzzle _ discovered guessed) =
    intersperse ' ' ( fmap renderPuzzleChar discovered)
    ++ " Guessed so far: "
    ++ guessed

freshPuzzle :: String -> Puzzle
freshPuzzle str = Puzzle str (map (const Nothing) str) []

-- fn that looks at puzzle string and finds if Char is part of string
charInWord :: Puzzle -> Char -> Bool
charInWord (Puzzle word _ _) char = char `elem` word

alreadyGuessed :: Puzzle -> Char -> Bool
alreadyGuessed (Puzzle _ _ guessed) char = char `elem` guessed

renderPuzzleChar :: Maybe Char -> Char
renderPuzzleChar Nothing = '_'
renderPuzzleChar (Just char) = char

fillInChar :: Puzzle -> Char -> Puzzle
fillInChar puzzle@(Puzzle word filledInSoFar guessed) char
  | alreadyGuessed puzzle char = puzzle
  | charInWord puzzle char = Puzzle word (checkGuesses word newGuesses) newGuesses
  | not (charInWord puzzle char) = Puzzle word filledInSoFar newGuesses
  | otherwise = error "can't be here"
  where
    newGuesses = char : guessed
    checkGuesses :: String -> String -> [Maybe Char]
    checkGuesses word guesses = map (\c -> if c `elem` guesses then Just c else Nothing) word
-- fillInChar with Char 'c'

preTestPuzzle = Puzzle "cabc" [Nothing, Just 'a', Nothing, Nothing] "a"
postTestPuzzle = Puzzle "cabc" [Just 'c', Just 'a', Nothing, Just 'c'] "ca"

testChar :: Bool
testChar = fillInChar preTestPuzzle 'c' == postTestPuzzle

