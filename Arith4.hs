module Arith4 where

roundTrip :: (Show a, Read b ) => a -> b
roundTrip  =  read . show
-- equivalent to id

main = do
  print $ (roundTrip 4)::b
  print $ id 4
