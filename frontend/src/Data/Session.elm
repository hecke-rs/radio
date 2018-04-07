module Data.Session exposing (Session)

import Data.User exposing (User)


type alias Session =
    { user : Maybe User }
