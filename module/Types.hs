{-# LANGUAGE OverloadedStrings #-}
module Types where
	import Data.Aeson.Types

	data Token = Token String String deriving(Show)
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