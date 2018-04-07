module Data.Role exposing (Role, decoder)

import Json.Decode as Decode exposing (Decoder, string)


type Role
    = Normal
    | DJ
    | Admin


decoder : Decoder Role
decoder =
    Decode.string |> Decode.andThen decodeOfString


decodeOfString : String -> Decoder Role
decodeOfString x =
    case x of
        "NORMAL" ->
            Decode.succeed Normal

        "DJ" ->
            Decode.succeed DJ

        "Admin" ->
            Decode.succeed Admin

        _ ->
            Decode.fail <| "Unknown role: " ++ x
