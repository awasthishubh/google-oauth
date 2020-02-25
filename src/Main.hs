{-# LANGUAGE OverloadedStrings #-}
import Web.Scotty
import qualified Data.Text as T

main = scotty 3000 $ do
    matchAny "/" $ do
        html "Hello World!"
