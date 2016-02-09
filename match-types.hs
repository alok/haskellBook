-- Match the Types

data Person = Person Bool

-- so I don't have to see "Person True" instead of "True"
instance Show Person where
    show (Person x) = show x

printPerson :: Person -> IO ()
printPerson person = putStrLn (show person)

data Mood = Blah | Woot deriving (Show, Eq)

settleDown x = if x == Woot
                  then Blah
                  else x

type Subject = String
type Verb = String
type Object = String
data Sentence = Sentence Subject Verb Object deriving (Eq, Show)

-- s1 takes 1 more arg
s1 = Sentence "dogs" "drool"

-- s2 is fully applied
s2 = Sentence "Julie" "loves" "dogs"

data Rocks = Rocks String deriving (Eq, Show)

data Yeah = Yeah Bool deriving (Eq, Show)

data Papu = Papu Rocks Yeah deriving (Eq, Show)

phew = Papu (Rocks "chases") (Yeah True)

truth = Papu (Rocks "chomskydoz") (Yeah True)

equalityForall :: Papu -> Papu -> Bool
equalityForall p p' = p == p'

-- Will it typecheck?
i = 1

f :: Float 
f = 1.0

g :: (Fractional a) => a
g =  1.0
