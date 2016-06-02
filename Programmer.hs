module Programmer where

data OperatingSystem =
  GnuPlusLinux
    | OpenBSDPlusNevermindJustBSDStill
    | Mac
    | Windows
    deriving (Eq, Show)

data ProgrammingLanguage =
  Haskell
    | Agda
    | Idris
    | PureScript deriving (Eq, Show)

data Programmer =
  Programmer { os :: OperatingSystem
             , lang :: ProgrammingLanguage }
             deriving (Eq, Show)

opList :: [OperatingSystem]
opList = [ GnuPlusLinux, OpenBSDPlusNevermindJustBSDStill, Mac, Windows]

langList :: [ProgrammingLanguage]
langList = [Haskell, Agda, Idris, PureScript]

allValsOfProgrammer :: [Programmer]
allValsOfProgrammer = [Programmer opSys language |
                       opSys <- opList, language <- langList]
