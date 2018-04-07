module Route exposing (Route(..), fromLocation)

import Navigation exposing (Location)
import UrlParser as Url exposing ((</>), s, top)


type Route
    = Root
    | Signin


route : Url.Parser (Route -> a) a
route =
    Url.oneOf
        [ Url.map Root top
        , Url.map Signin (s "signin")
        ]


fromLocation : Location -> Maybe Route
fromLocation =
    Url.parseHash route
