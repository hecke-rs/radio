module Route exposing (Route(..), fromLocation, modifyUrl)

import Html exposing (Attribute)
import Html.Attributes as Attr
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


asString : Route -> String
asString page =
    let
        components =
            case page of
                Root ->
                    []

                Signin ->
                    [ "signin" ]
    in
    "/" ++ String.join "/" components


href : Route -> Attribute msg
href route =
    Attr.href ("#" ++ asString route)


modifyUrl : Route -> Cmd msg
modifyUrl =
    asString >> Navigation.modifyUrl
