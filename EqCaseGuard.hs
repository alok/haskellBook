module EqCaseGuard where

type Name = String
type Age = Integer

data Person = Person Name Age deriving (Eq, Show)

data PersonInvalid = NameEmpty | AgeTooLow deriving (Eq, Show)

errorString :: PersonInvalid -> String
errorString NameEmpty =  "NameEmpty"
errorString AgeTooLow =  "AgeTooLow"

-- instance Show PersonInvalid where
  -- show = errorString

blah :: PersonInvalid -> String
blah x
  | x == NameEmpty = "NameEmpty"
  | x == AgeTooLow = "AgeTooLow"
  | otherwise = error "not possible"

-- creates a valid person or it fails and gives one of
-- the failure modes in an explicit way, rather than
-- some ad-hoc crap

-- failure case is usually Left
makePerson :: Name -> Age -> Either PersonInvalid Person
makePerson name age
  | name == "" = Left NameEmpty
  | age < 0 = Left AgeTooLow
  | name /= "" && age >= 0 = Right (Person name age)
  | otherwise = error "you shouldn't be able to get here"

type ValidatePerson a = Either [PersonInvalid] a

-- we write *independent* validation functions to decouple them and rely on
-- Either to handle it

ageOK :: Age -> Either [PersonInvalid] Age
ageOK age =  if age >= 0 then Right age else Left [AgeTooLow] 

nameOK :: Name -> Either [PersonInvalid] Name
nameOK name =  if name /= "" then Right name else Left [NameEmpty]

mkPerson :: Name -> Age -> ValidatePerson Person
mkPerson name age = mkPerson' (nameOK name) (ageOK age)
  where
  mkPerson' :: ValidatePerson Name -> ValidatePerson Age -> ValidatePerson Person
  mkPerson' (Right nameGood) (Right ageGood) = Right (Person nameGood ageGood)
  mkPerson' (Left nameBad) (Left ageBad) = Left (nameBad ++ ageBad)
  mkPerson' (Left nameBad) _ = Left nameBad
  mkPerson' _ (Left ageBad) = Left ageBad


