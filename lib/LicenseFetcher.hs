module LicenseFetcher
  ( Package(..)
  , Version(..)
  , License(..)
  , Directory(..)
  
  , fetch
  , fetchStore
  ) where

import Network.HTTP        (simpleHTTP, getRequest, getResponseBody)
import System.Directory    (withCurrentDirectory)

--------------------------------------------------------------------------------

newtype Package   = Package   { getPackage   :: String }
newtype Version   = Version   { getVersion   :: String }
newtype License   = License   { getLicense   :: String }
newtype Directory = Directory { getDirectory :: String }

--------------------------------------------------------------------------------

-- | Fetches the license of a versioned package
fetch :: Package -> Version -> IO License
fetch (Package p) (Version v) = do
  response <- simpleHTTP . getRequest $ "http://hackage.haskell.org/package/" ++ p ++ "-" ++ v ++ "/src/LICENSE"
  body     <- getResponseBody response
  pure . License $ body

--------------------------------------------------------------------------------

-- | Fetches the license of a versioned package and stores it as file in the provided directory
fetchStore :: Maybe Directory -> Package -> Version -> IO ()
fetchStore md pp@(Package p) vv  = do
  l <- fetch pp vv
  case md of
    Nothing            -> writeFile p (getLicense l)
    Just (Directory d) -> withCurrentDirectory d $ writeFile p (getLicense l) 
