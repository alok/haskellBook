module Max where

-- a tail recursive implementation of `maximum`

max' a b = if a > b then a else b


maximum' [x] = x
maximum' xs = max' (head xs) (maximum (tail xs))
