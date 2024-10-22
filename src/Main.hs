{-# LANGUAGE OverloadedStrings #-}
import Web.Scotty
import Control.Monad.IO.Class
import qualified Code2token as C
import Token2info as TI
import Types
import qualified Data.Text.Lazy as L
import Data.Aeson
import qualified Data.ByteString.Lazy.Char8 as Char8
import Func
import System.Environment

main::IO ()
main = do
    port <- read <$> getEnv "PORT"
    baseURL <- getEnv "baseURL":: IO String
    scotty port $ do
        get "/auth" $ do
            client_id <- param "client_id"
            client_secret <- param "client_secret"
            let state=Char8.unpack $ encode (Cred client_id client_secret)
            let url="https://accounts.google.com/o/oauth2/auth?"
                        ++"response_type=code"
                        ++"&scope=https://www.googleapis.com/auth/userinfo.profile+https://www.googleapis.com/auth/userinfo.email&"
                        ++"client_id="++(client_id)++"&"
                        ++"redirect_uri="++(baseURL)++"/callback&"
                        ++"access_type=offline&prompt=consent&"
                        ++"state="++state
            redirect $ L.pack url

        get "/" $ do
            cont <- liftIO $ readFile "./html/home.html"
            html $ L.replace "{{baseURL}}" (L.pack baseURL) $ L.pack cont
        get "/callback" $ do
            state <- param "state"
            let justCred= decode (Char8.pack state) :: Maybe Cred
                cred=fromJust justCred
                grant_type="authorization_code" 
                redirect_uri="http://localhost:3000/callback"
            code <- param "code"
            let auth = Auth (getID cred) (getSec cred) grant_type code redirect_uri  
            tokens <- liftIO $ C.getToken auth
            let access_code = getAcc tokens
            liftIO $ putStrLn access_code
            userInfo <- liftIO $ TI.getInfo access_code
            Web.Scotty.json $ CombineInfo userInfo tokens auth

