module Data.AuthToken exposing (AuthToken, decoder)

import Json.Decode as Decode exposing (Decoder)


type AuthToken
    = AuthToken String


decoder : Decoder AuthToken
decoder =
    Decode.string |> Decode.map AuthToken
