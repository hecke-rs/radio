module Data.User exposing (User, decoder)

import Data.AuthToken as AuthToken exposing (AuthToken)
import Data.Role as Role exposing (Role)
import Json.Decode exposing (Decoder, string)
import Json.Decode.Pipeline exposing (decode, required)


type alias User =
    { username : String
    , token : AuthToken
    , role : Role
    }


decoder : Decoder User
decoder =
    decode User
        |> required "username" string
        |> required "token" AuthToken.decoder
        |> required "role" Role.decoder
