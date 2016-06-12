module Maybe where

ifEvenAdd2 :: Integer -> Maybe Integer
ifEvenAdd2 x = if even x then Just (x + 2) else Nothing

type Name = String
type Age = Integer

data Person = Person Name Age deriving (Eq, Show)

makePerson :: Name -> Age -> Maybe Person
makePerson name age =  if name /= "" && age >= 0 then Just (Person name age) else Nothing

-- emumerate failure modes
data PersonInvalid = NameEmpty | AgeTooLow deriving (Eq, Show)

flattenJust (Just x) = flattenJust x
flattenJust x = x

