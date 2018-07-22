module Request.User exposing (signIn)

import Data.User as User exposing (User)
import Http
import Json.Encode as Encode
import Util exposing ((=>))


signIn : { a | username : String, password : String } -> Http.Request User
signIn { username, password } =
    let
        creds =
            Http.jsonBody <|
                Encode.object
                    [ "username" => Encode.string username
                    , "password" => Encode.string password
                    ]
    in
    Http.post "http://localhost:5000/api/auth/signin" creds User.decoder



-- register : { a | username : String, password : String } -> Http.Request User
-- register { username, password } =
--     let
