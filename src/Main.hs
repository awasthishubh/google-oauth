{-# LANGUAGE OverloadedStrings #-}
import Web.Scotty
import Control.Monad.IO.Class
import qualified Code2token as C
import Token2info as TI
import qualified Data.Text as T
import qualified Data.Text.Lazy as L

main::IO ()
main=do
    putStrLn "From Main"
    let client_id="698827909931-28n38gm9dgg7gjaainvo77tu90kchcl0.apps.googleusercontent.com" 
        client_secret="vwLCiXN99on2Fl6cako-niOS" 
        grant_type="authorization_code" 
        code="4/xQEJc9xnAHRhoUUil-RTKzOgfL1vppEkaEBWnoHMq4rWj27ku4PlA8SQgYjVTGrOgR2NzZZl_vfrOl4t1ukVqT0" 
        redirect_uri="http://localhost:3000/callback"
        access_code="ya29.a0Adw1xeXck4Q8qt0Z0S_UyBN14dFgi7hk6tnbOUS-_zJXKD8iF6uJBrfaeHQzHJ0_nOTnmG2miBTqtCz42TKfrrAzWdYt81cQKAuYGw_9UQSn5Ae-2nx_eWVzxFIsvyIBVIPLlwlNQ7rPLdg9Ah0w0sHAFnq_r_UCGdo"
    userInfo <- TI.getInfo access_code
    putStrLn $ show userInfo
    -- tokens<-C.getToken client_id client_secret grant_type code redirect_uri

    -- putStrLn $ show tokens
-- import qualified Data.ByteString.Lazy.Char8 as BS
-- import Data.Aeson
-- main::IO ()
-- main=do
--     let foo = BS.pack "{\"Name\" : {\"Name\" : \"Stitch\", \"Age\" : 3, \"Friend\": \"Lilo\"}, \"Age\" : 3, \"Friend\": \"Lilo\"}"
--     let res = decode foo::Maybe Object
--     putStrLn.show $ res