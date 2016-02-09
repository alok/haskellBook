data Trivial = Trivial'

instance Eq Trivial where
    (==) Trivial' Trivial' = True

data DayOfWeek = Mon | Tue | Wed | Thu | Fri | Sat | Sun

data Date = Date DayOfWeek Int

instance Eq Date where
        (==) (Date weekday monthNum)
            (Date weekday' monthNum') =
            (weekday == weekday') && (monthNum == monthNum')

data Identity a = Identity a

-- define identity
instance Eq a => Eq (Identity a) where
    (==) (Identity v) ( Identity v') = v == v'
