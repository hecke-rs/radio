module Elements.Page exposing (frame, fullscreenFrame)

import Html exposing (..)
import Html.Attributes exposing (..)


frame : Html msg -> Html msg
frame content =
    div
        [ class "app" ]
        [ viewHeader
        , main_ [] [ content ]
        , viewFooter
        ]


fullscreenFrame : Html msg -> Html msg
fullscreenFrame content =
    div [ class "app" ]
        [ main_ [] [ content ] ]


viewHeader : Html msg
viewHeader =
    Html.text ""


viewFooter : Html msg
viewFooter =
    Html.text ""
