{-# LANGUAGE OverloadedStrings #-}
import Web.Scotty
import Control.Monad.IO.Class
import qualified Code2token as C
import Token2info
import qualified Data.Text as T
import qualified Data.Text.Lazy as L

main::IO ()
main=do
    putStrLn "From Main"
    let client_id="698827909931-28n38gm9dgg7gjaainvo77tu90kchcl0.apps.googleusercontent.com" 
        client_secret="vwLCiXN99on2Fl6cako-niOS" 
        grant_type="authorization_code" 
        code="4/wwECwhwV-m7Zf6BmQ26ILA_GrjVdrNn-0nK43UqtyEQ7TFDCb2J6jKrO9Nvi0doT1r9EXglVYEWyEhfibGh0Vys" 
        redirect_uri="http://localhost:3000/callback"
    res<-C.getToken client_id client_secret grant_type code redirect_uri
    putStrLn res