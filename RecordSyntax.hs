module RecordSyntax where

-- Just like data Person = MkPerson  String Integer deriving (Eq,Show)
data Person  = Person {name :: String
                      , age :: Integer}
                      deriving (Eq, Show)
-- easy way to extract data automatically
-- age x is = to using pattern match f (Person x _ ) = x
