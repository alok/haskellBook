import Data.List

($>) :: a -> (a -> b) -> b
($>) = flip ($)

-- filter list to get evens < 4
fn x = x $> sort $> filter (< 4) $> map even $> and
-- [3,1,4,2,2,6]
--
-- .
