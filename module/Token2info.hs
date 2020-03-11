{-# LANGUAGE OverloadedStrings #-}
module Token2info where
	-- import qualified Data.ByteString.Lazy.Char8 as L8
	import           Network.HTTP.Client        (defaultManagerSettings, newManager)
	import           Network.HTTP.Simple
	import			 Network.HTTP.Client.TLS
	import Data.Aeson.Types
	import Types
	import qualified Data.ByteString.Char8 as K

	getInfo :: String -> IO Object
	getInfo access_code = do
		manager <- newManager tlsManagerSettings
		let request 
			= setRequestMethod "GET"
			$ setRequestHeaders [
				("user-agent" , "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.106 Safari/537.36"),
				("Authorization" , K.pack $ "Bearer "++access_code)
			]
			$ setRequestSecure True
			$ setRequestManager manager "https://www.googleapis.com/oauth2/v2/userinfo"
		response <- getResponseBody <$> httpJSON request :: IO Object
		return response