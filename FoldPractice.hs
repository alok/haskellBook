module FoldPractice where

-- take 3 from each list elem and concat

concat3 :: [String] -> String
concat3 =  foldr (\x acc -> concat (take 3 x) acc ) ""

-- better written as:
-- concat . map (take 3) $ xs::[String]
