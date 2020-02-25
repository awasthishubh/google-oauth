{-# LANGUAGE OverloadedStrings #-}
import Web.Scotty
import Control.Monad.IO.Class
import Code2token
import Token2info
import qualified Data.Text as T
import qualified Data.Text.Lazy as L

main = scotty 3000 $ do
    get "/" $ do
        liftIO $ putStrLn $ "Hello World!!"
        text $L.pack info