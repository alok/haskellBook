module Palindrome where

import Control.Monad
import Data.Char (isAlphaNum, toLower)

palindrome :: IO ()
palindrome = 
  forever $ do line1 <- getLine
               if checkPalindrome
                    line1
                  then putStrLn
                         "yes"
                  else putStrLn
                         "no"

checkPalindrome :: String -> Bool
checkPalindrome s = 
  filteredStr == reverse
                   filteredStr
  where filteredStr = 
          palFilter
            s
        palFilter = 
          map
            toLower . filter
                        isAlphaNum
