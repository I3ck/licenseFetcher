module Main where

import LicenseFetcher

main :: IO ()
main = do 
    putStrLn . show $ fetch
