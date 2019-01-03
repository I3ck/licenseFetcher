module Main where

import LicenseFetcher
import Options.Applicative

--------------------------------------------------------------------------------

data Args = Args
  { aName    :: String
  , aVersion :: String
  , aDir     :: Maybe String
  }

args :: Parser Args
args = Args
  <$> strOption
    (  long    "packagename"
    <> short   'n'
    <> help    "Name of the package"
    <> metavar "String"
    )
  <*> strOption
    (  long    "packageversion"
    <> short   'v'
    <> help    "Version of the package"
    <> metavar "String"
    )
  <*> optional ( strOption
    (  long    "licensedir"
    <> short   'd'
    <> help    "Path where the license shall be stored"
    <> metavar "String"
    ))

opts :: ParserInfo Args
opts = info (helper <*> args)
  (  fullDesc
  <> progDesc "Fetch the license of provided Haskell package"
  <> header   "licenseFetcher"
  )

--------------------------------------------------------------------------------

main :: IO ()
main = do
  a <- execParser opts
  let p = Package    . aName    $ a
      v = Version    . aVersion $ a
      d = Directory <$> aDir      a
  fetchStore d p v
