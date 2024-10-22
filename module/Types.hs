{-# LANGUAGE OverloadedStrings #-}
module Types where
	import Data.Aeson
	import Data.Aeson.Types

	data Token = Token String String deriving(Show)
	instance ToJSON Token where
		toJSON (Token access_code refresh) = object
				[
					"access_code" .= access_code,
					"refresh" .= refresh
				]

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
	
	data Cred = Cred String String deriving(Show)
	instance ToJSON Cred where
		toJSON (Cred client_id client_secret) = object
				[
					"client_id" .= client_id,
					"client_secret" .= client_secret
				]
	instance FromJSON Cred where
		parseJSON = withObject "cred" $ \o ->
			Cred <$> o .: "client_id" <*> o .: "client_secret"
		
	data CombineInfo = CombineInfo Object Token Auth
	instance ToJSON CombineInfo where
		toJSON (CombineInfo userInfo tokens auth) = object
				[
					"userInfo" .= userInfo,
					"tokens" .= tokens,
					"config" .= auth
				]