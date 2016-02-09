-- 1.
data TisAnInteger =
    TisAn Integer

instance Eq TisAnInteger where
    (==) (TisAn a) (TisAn a') = a == a'

-- 2.
data TwoIntegers =
    Two Integer Integer

instance Eq TwoIntegers where
    (==) (Two a b) (Two a' b') = a == a' && b == b'

-- 3.
data StringOrInt =
    TisAnInt Int
    | TisAString String

instance Eq StringOrInt where
    (==) (TisAnInt a) (TisAnInt a') = a == a'
    (==) (TisAString a) (TisAString a') = a == a'
    (==) _ _ = False

-- 4.
-- TODO why does this need an arg for the type and the 3 above don't?
data Pair a = Pair a a

instance (Eq a) => Eq (Pair a) where
    (==) (Pair a b) (Pair a' b') = (a == a') && (b == b')

-- 5.
data Tuple a b =
    Tuple a b

-- 6.
data Which a =
    ThisOne a
    | ThatOne a

-- 7.
data EitherOr a b =
    Hello a
    | Goodbye b
