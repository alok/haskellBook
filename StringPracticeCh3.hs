module StringPracticeCh3 where

dropLast :: String  -> String
dropLast =  init

drop4 :: String  -> String
drop4 s =  [s !! 4]

returnAwesome :: String  -> String
returnAwesome =  dropWhile (/='a')

rvrs :: String  -> String
rvrs s =  concat [drop 9 s, drop 5 $ take 9 s, take 5 s, "."]

main :: IO ()
main = print (rvrs "Curry is awesome")
