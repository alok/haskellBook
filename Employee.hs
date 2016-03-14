module Employee where

data Employee = Coder
              | Manager
              | Veep
              | CEO
              deriving (Eq, Ord, Show)


reportBoss :: Employee -> Employee -> IO ()
reportBoss e e' =
    putStrLn $ show e ++ " is the boss of " ++ show e'

employeeRank :: Employee -> Employee -> IO ()
employeeRank e e' = case compare e e' of
                      GT -> reportBoss e e'
                      LT -> reportBoss e' e
                      EQ -> putStrLn "neither is boss"

employeeRank' :: (Employee -> Employee -> Ordering)
              -> Employee
              -> Employee
              -> IO ()

employeeRank' f e e' = case f e e' of
                         GT -> reportBoss e e'
                         LT -> reportBoss e' e
                         EQ -> putStrLn "neither is boss"


codersRuleCEOsDrool :: Employee -> Employee -> Ordering
codersRuleCEOsDrool Coder Coder = EQ
codersRuleCEOsDrool Coder _     = GT
codersRuleCEOsDrool _ Coder     = LT
codersRuleCEOsDrool e e'        = compare e e'
