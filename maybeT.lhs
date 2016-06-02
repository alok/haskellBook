This is available [here] as a .lhs file.

Let's just deal with the `MaybeT` transformer.

First some imports:

> import Control.Monad
> import Control.Monad.Trans
> import Control.Monad.Trans.Maybe

Rules of thumb:

* In a monad stack IO is always on the bottom.

* `MaybeT m` is a new monad type which adds the power of the Maybe monad to the monad `m` - e.g. `MaybeT IO`.

We'll get into what that power is later. For now, get used to thinking of `MaybeT IO` as the maybe+IO monad stack.

* Just like `IO Int` is a monad expression returning an `Int`, `MaybeT IO Int` is a `MaybeT IO` expression returning an `Int`.

* Every expression in a `do` block must be from the same monad.

I.e. this works because each statement is in the IO-monad

> greet :: IO ()                               -- type:
> greet = do putStr "What is your name? "      -- IO ()
>            n <- getLine                      -- IO String
>            putStrLn $ "Hello, " ++ n         -- IO ()

This will not work because `putStr` is not in the `MaybeT IO` monad:

    mgreet :: MaybeT IO ()
    mgreet = do putStr "What is your name? "    -- IO monad - need MaybeT IO
                ...

Fortunately there is a way to fix this.

* To transform an `IO` expression into a `MaybeT IO` expression use `liftIO`.

`liftIO` is polymorphic, but in our case it has the type:

    liftIO :: IO a -> MaybeT IO a

> mgreet :: MaybeT IO ()                             -- types:
> mgreet = do liftIO $ putStr "What is your name? "  -- MaybeT IO ()
>             n <- liftIO getLine                    -- MaybeT IO String
>             liftIO $ putStrLn $ "Hello, " ++ n     -- MaybeT IO ()

Now all of the statement in `mgreet` are from the `MaybeT IO` monad.

* Every monad has a "run" function.

The run function "runs" the top-most layer of a monad stack returning
a value from the inside layer.

For `MaybeT IO`, the run function is:

    runMaybeT :: MaybeT IO a -> IO a

Example:

    ghci> :t runMaybeT mgreet 
    mgreet :: IO ()

    ghci> runMaybeT mgreet
    What is your name? user5402
    Hello, user5402

Also try running: 

    runMaybeT (forever mgreet)

You'll beed to use Ctrl-C to break out of the loop.

So far `mgreet` doesn't do anything more than what we could do in IO.
Now we'll work on an example which demonstrates the mixing the power of
the Maybe monad with IO.

Adding Maybe powers to IO
===

We'll start with a program which asks some questions:

> askfor :: String -> IO String
> askfor prompt = do
>   putStr $ "What is your " ++ prompt ++ "? "
>   getLine
>
> survey :: IO (String,String)
> survey = do n <- askfor "name"
>             c <- askfor "favorite color"
>             return (n,c)

Now suppose we want to give the user the ability to end the survey
early by typing END in response to a question. We might handle it
this way:

> askfor1 :: String -> IO (Maybe String)
> askfor1 prompt = do
>   putStr $ "What is your " ++ prompt ++ " (type END to quit)? "
>   r <- getLine
>   if r == "END"
>     then return Nothing
>     else return (Just r)

> survey1 :: IO (Maybe (String, String))
> survey1 = do
>   ma <- askfor1 "name"
>   case ma of
>     Nothing -> return Nothing
>     Just n  -> do mc <- askfor1 "favorite color"
>                   case mc of
>                     Nothing -> return Nothing
>                     Just c  -> return (Just (n,c))

The problem is that `survey1` has the familiar staircasing issue which
doesn't scale if we add more questions.

We can use the MaybeT monad transformer to help us here.

> askfor2 :: String -> MaybeT IO String
> askfor2 prompt = do
>   liftIO $ putStr $ "What is your " ++ prompt ++ " (type END to quit)? "
>   r <- liftIO getLine
>   if r == "END"
>     then MaybeT (return Nothing)    -- has type: MaybeT IO String
>     else MaybeT (return (Just r))   -- has type: MaybeT IO String

Note how all of the statemens in `askfor2` have the same monad type.

We've used a new function:

    MaybeT :: IO (Maybe a) -> MaybeT IO a

Here is how the types work out:

                      Nothing     :: Maybe String
               return Nothing     :: IO (Maybe String)
       MaybeT (return Nothing)    :: MaybeT IO String

                     Just "foo"   :: Maybe String
             return (Just "foo")  :: IO (Maybe String)
     MaybeT (return (Just "foo")) :: MaybeT IO String

Here `return` is from the IO-monad.

Now we can write our survey function like this:

> survey2 :: IO (Maybe (String,String))
> survey2 =
>   runMaybeT $ do a <- askfor2 "name"
>                  b <- askfor2 "favorite color"
>                  return (a,b)

Try running `survey2` and ending the questions early by typing END as a response to either question.

Short-cuts
===

I know I'll get comments from people if I don't mention the following short-cuts.

The expression:

    MaybeT (return (Just r))    -- return is from the IO monad

may also be written simply as:

    return r                    -- return is from the MaybeT IO monad

Also, another way of writing `MaybeT (return Nothing)` is:

    mzero

Furthermore, two consecutive liftIO statements may always combined into a single `liftIO`, e.g.:

    do liftIO $ statement1
       liftIO $ statement2 

is the same as:

    liftIO $ do statement1
                statement2

With these changes, our `askfor2` function may be written:

    askfor2 prompt = do
      r <- liftIO $ do
             putStr $ "What is your " ++ prompt ++ " (type END to quit)?"
             getLine
      if r == "END"
        then mzero
        else return r

In a sense, `mzero` becomes a way of breaking out of the monad - like throwing an exception.