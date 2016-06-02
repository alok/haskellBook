{-# LANGUAGE GeneralizedNewtypeDeriving #-}

f:: dog -> Integer
f x = 2

data Doggies a = Husky a | Mastiff a deriving (Eq, Show)
-- when data constructors take arguments, those arguments refer to *other*
-- types.

-- Price *depends* on Integer

data Price = Price Integer deriving (Eq, Show)

data Manufacturer =
      Mini |
      Mazda |
      Tata
      deriving (Eq, Show)

data Airline =
      PapuAir |
      CatapultsRUs |
      TakeYourChancesUnited
      deriving (Eq, Show)

data Size = Size Integer deriving (Eq, Show)

data Vehicle = Car Manufacturer Price | Plane Airline Size deriving (Eq, Show)

myCar    = Car Mini (Price 14000)
urCar    = Car Mazda (Price 20000)
clownCar = Car Tata (Price 7000)
doge     = Plane PapuAir (Size 3000)

isCar :: Vehicle -> Bool
isCar (Car _ _) = True
isCar _ = False

areCars :: [Vehicle] -> [Bool]
areCars =  map isCar

vehicles :: [Vehicle]
vehicles = [myCar, urCar, clownCar, doge]

getManufacturer :: Vehicle -> Manufacturer
getManufacturer (Car maker _) = maker

newtype Goats = Goats Int deriving (Eq, Show, TooMany)
newtype Cows = Cows Int deriving (Eq, Show)

tooManyGoats :: Goats -> Bool
tooManyGoats (Goats n) =  n > 42
