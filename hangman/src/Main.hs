module Main where

import           Control.Monad (forever, when)
import           Data.Char     (toLower)
import           Data.List     (intersperse, nub)
import           Data.Maybe    (isJust)
import           System.Exit   (exitSuccess)
import           System.Random (randomRIO)


newtype WordList = WordList [String] deriving (Eq, Show)

minWordLength = 2
maxWordLength = 2


allWords :: IO WordList
allWords = do
  dict <- readFile "data/dict.txt"
  return $ WordList (lines dict)


gameWords :: IO WordList
gameWords = do
  (WordList aw) <- allWords
  return $ WordList (filter gameLength aw)
    where gameLength w = minWordLength <= l && l <= maxWordLength where l = length (w :: String)


randomWord :: WordList -> IO String
randomWord (WordList wl) = do
  randomIndex <- randomRIO (0, length wl - 1)
  return (wl !! randomIndex)


randomWord' :: IO String
randomWord' = gameWords >>= randomWord

main :: IO ()
main = do
  word <- randomWord'
  let puzzle = freshPuzzle (fmap toLower word)
   in runGame puzzle

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

handleGuess :: Puzzle -> Char -> IO Puzzle
handleGuess puzzle guess = do
  -- wrap guess in list to make it a string
  putStrLn $ "Your guess was: " ++ show guess ++ [guess]
  case (charInWord puzzle guess, alreadyGuessed puzzle guess) of
    (_, True) -> do
      putStrLn "You already guessed that"
      return puzzle
    (True, False) -> do
      putStrLn "correct"
      return (fillInChar puzzle guess)
    (False, False) -> do
      putStrLn "no. try again"
      return (fillInChar puzzle guess)

gameOver :: Puzzle -> IO ()
gameOver (Puzzle wordToGuess filledInSoFar guessed) = if numGuessed - numCorrectGuesses > 7 then
                                            do
                                              putStrLn "you lose"
                                              putStrLn $ "the word was:" ++ wordToGuess
                                              exitSuccess
                                            else return ()
                                              where
                                                numGuessed = length guessed
                                                numCorrectGuesses = length correctGuesses
                                                correctGuesses = filter (/= Nothing) . nub $ filledInSoFar


gameWin :: Puzzle -> IO ()
gameWin (Puzzle _ filledInSoFar _) = if all isJust filledInSoFar then
                                       do
                                         putStrLn "you win"
                                         exitSuccess
                                       else return ()


runGame :: Puzzle -> IO ()
runGame puzzle = forever $ do
  gameOver puzzle
  gameWin puzzle
  putStrLn $ "current puzzle is:" ++ show puzzle
  putStrLn "guess a letter"
  guess <- getLine
  case guess of
    [char] -> handleGuess puzzle char >>= runGame
    _ -> putStrLn "guess must be a single character"
