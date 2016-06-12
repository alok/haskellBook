module Return where

import System.IO ()

main :: IO ()
main = do
  c  <- getChar
  c' <- getChar
  c  <- getChar
  if c == c'
     then putStrLn "True"
     else return ()

twoo :: IO Bool
twoo = do
  c  <- getChar
  c' <- getChar
  return (c == c')

