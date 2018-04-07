module Route exposing (Route(..), fromLocation)

import Navigation exposing (Location)
import UrlParser as Url exposing ((</>), top)


type Route
    = Root


route : Url.Parser (Route -> a) a
route =
    Url.oneOf
        [ Url.map Root top
        ]


fromLocation : Location -> Maybe Route
fromLocation =
    Url.parsePath route
