data DayOfWeek =
-- vals to left are 'less than'
    Mon | Tue | Weds | Thu | Fri | Sat | Sun
    deriving (Eq, Show)

instance Ord DayOfWeek where
    compare Fri Fri = EQ
    compare Fri _ = GT
    compare _ Fri = LT
-- TODO how to enable default compare for this?
    compare _ _ = EQ

-- can't use Num bc complex nums are not totally ordered
-- no type sig needed though because of inference
-- addWeird :: (Real r) => r -> r -> r
addWeird x y = if x > 1 then x + y else x;
