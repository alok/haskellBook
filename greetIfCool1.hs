module greetIfCool1 where
    greetIfCool :: String  -> IO ()
    greetIfCool coolness =
        if cool then
            putStrLn "eyyy"
       else
           putStrLn "no"
           where cool =coolness == "frosty yo"

f:: (a,b)  -> (c,d) -> ((b,d), (a,c))
-- take snd and zip together and then repeat for fst
((snd x, snd y),(fst x , fst y))
