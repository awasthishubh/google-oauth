{-# LANGUAGE OverloadedStrings #-}
import Web.Scotty
import Control.Monad.IO.Class
import qualified Code2token as C
import qualified Token2info as T
import Token2info
import qualified Data.Text as T
import qualified Data.Text.Lazy as L

main::IO ()
main=do
    putStrLn "From Main"
    let client_id="698827909931-28n38gm9dgg7gjaainvo77tu90kchcl0.apps.googleusercontent.com" 
        client_secret="vwLCiXN99on2Fl6cako-niOS" 
        grant_type="authorization_code" 
        code="4/xQHTqltB6snh-cRcTGIj-QBMacfLnRFbGADvhxp7KlwwLa3kmTe3OrSPTI3RXHgYnbf-d3rXlZlrjxTWgKhHzhk" 
        redirect_uri="http://localhost:3000/callback"
    tokens<-C.getToken client_id client_secret grant_type code redirect_uri

    putStrLn $ show tokens
-- import qualified Data.ByteString.Lazy.Char8 as BS
-- import Data.Aeson
-- main::IO ()
-- main=do
--     let foo = BS.pack "{\"Name\" : {\"Name\" : \"Stitch\", \"Age\" : 3, \"Friend\": \"Lilo\"}, \"Age\" : 3, \"Friend\": \"Lilo\"}"
--     let res = decode foo::Maybe Object
--     putStrLn.show $ res