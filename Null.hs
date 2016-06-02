data Automobile = Null
                | Car { make  :: String
                      , model :: String
                      , year  :: Integer}
                deriving (Eq, Show)

-- don't *do* this. use Maybe instead of Null and move Car to its own separate
-- type declaration to avoid calling a partial function like `model Null`

data Car2 = Car2 { make2  :: String
                 , model2 :: String
                 , year2  :: Integer}
                 deriving (Eq, Show)

data Automobile2  = Null2 | Automobile2 Car2 deriving (Eq, Show)
