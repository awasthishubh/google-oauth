{-# LANGUAGE OverloadedStrings #-}
import Web.Scotty
import Control.Monad.IO.Class
import qualified Code2token as C
import Token2info as TI
import Types
import qualified Data.Text as T
import qualified Data.Text.Lazy as L
import Data.Aeson
import qualified Data.ByteString.Lazy as B
import qualified Data.ByteString.Lazy.Char8 as Char8

getAcc::Token->String
getAcc (Token a b) = b

main::IO ()
main = scotty 3000 $ do
    get "/auth" $ do
        client_id <- param "client_id"
        client_secret <- param "client_secret"
        let state=encode (Cred client_id client_secret)
        liftIO $ print state
        html $ L.pack $ Char8.unpack state

    get "/" $ do
        html "Hello World!"
    get "/callback" $ do
        let client_id="698827909931-28n38gm9dgg7gjaainvo77tu90kchcl0.apps.googleusercontent.com" 
            client_secret="vwLCiXN99on2Fl6cako-niOS" 
            grant_type="authorization_code" 
            redirect_uri="http://localhost:3000/callback"
        code <- param "code"
        tokens <- liftIO $ C.getToken client_id client_secret grant_type code redirect_uri
        let access_code = getAcc tokens
        liftIO $ putStrLn access_code
        userInfo <- liftIO $ TI.getInfo access_code
        Web.Scotty.json userInfo

