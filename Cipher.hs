module Cipher where

import Data.Char


caesar :: Char -> Int -> Char
-- TODO fix wrap around
caesar a x = chr . (+ ord a) . flip mod (ord a) . (+x) . ord $ a

unCaesar :: Char -> Int -> Char
-- TODO make this work
-- unCaesar a x = chr . (subtract ord a) . flip mod (ord a) . (subtract x) . ord $ a
-- unCaesar a x = chr . subtract x . flip mod (ord a) . subtract (ord a) . ord $ a
