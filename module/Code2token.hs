{-# LANGUAGE OverloadedStrings #-}
module Code2token where
	import qualified Data.ByteString.Lazy.Char8 as L8
	import           Network.HTTP.Client        (defaultManagerSettings, newManager)
	import           Network.HTTP.Simple
	import			 Network.HTTP.Client.TLS
	import           Data.Aeson
	data Auth = Auth String String String String String
	instance ToJSON Auth where
		toJSON (Auth client_id client_secret grant_type code redirect_uri) = object
				[
					"client_id" .= client_id,
					"client_secret" .= client_secret,
					"grant_type" .= grant_type,
					"code" .= code,
					"redirect_uri" .= redirect_uri
				]
	
					
	getToken :: String->String->String->String->String->IO String
	getToken client_id client_secret grant_type code redirect_uri = do
		let auth =Auth client_id client_secret grant_type code redirect_uri  
		manager <- newManager tlsManagerSettings

		let request 
			= setRequestMethod "POST"
			$ setRequestBodyJSON auth
			$ setRequestHeaders [
				("user-agent","Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.106 Safari/537.36")
			]
			$ setRequestSecure True
			$ setRequestManager manager "https://accounts.google.com/o/oauth2/token"
		response <- httpLBS request
		return $ L8.unpack $ getResponseBody response