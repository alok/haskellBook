module Penguins where

data WherePenguinsLive =
    Galapagos   |
        Antarctic    |
            Australia   |
                SouthAfrica |
                    SouthAmerica
                    deriving (Eq, Show)

data Penguin = Peng WherePenguinsLive
    deriving (Eq, Show)

-- we can do this

isSouthAfrica :: WherePenguinsLive -> Bool
isSouthAfrica Galapagos    = True
isSouthAfrica Antarctic     = False
isSouthAfrica Australia    = False
isSouthAfrica SouthAfrica  = False
isSouthAfrica SouthAmerica = False

-- or we can do this (better)

isSouthAfrica' :: WherePenguinsLive -> Bool
isSouthAfrica' Galapagos = True
isSouthAfrica' _         = False

gimmeWhereTheyLive :: Penguin -> WherePenguinsLive
gimmeWhereTheyLive (Peng whereItLives) = whereItLives

humboldt  = Peng SouthAmerica
gentoo    = Peng Antarctic
macaroni  = Peng Antarctic
little    = Peng Australia
galapagos = Peng Galapagos

galapagosPenguin :: Penguin -> Bool
galapagosPenguin (Peng Galapagos) = True
galapagosPenguin _                = False

antarcticPenguin :: Penguin -> Bool
antarcticPenguin (Peng Antarctic) = True
antarcticPenguin _                = False

-- in this final function, the || operator
-- is an `or` function, which will return True -- if either value is True

antarcticOrGalapagos :: Penguin -> Bool
antarcticOrGalapagos p =
    galapagosPenguin p || antarcticPenguin p
