module Main where

import LicenseFetcher

main :: IO ()
main = do
  license <- fetch (Package "attoparsec") (Version "0.13.2.2")
  putStrLn . getLicense $ license
  fetchStore (Just . Directory $ "test") (Package "attoparsec") (Version "0.13.2.2")
