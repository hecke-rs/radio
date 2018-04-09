module Elements.Form exposing (passwordInput, submit, textInput, viewFieldErrors)

import Html exposing (Attribute, Html, li, text, ul)
import Html.Attributes exposing (class, type_)


{-| Renders a text input.
-}
textInput : List (Attribute msg) -> List (Html msg) -> Html msg
textInput attrs =
    Html.input (type_ "text" :: attrs)


{-| Renders a password input.
-}
passwordInput : List (Attribute msg) -> List (Html msg) -> Html msg
passwordInput attrs =
    Html.input (type_ "password" :: attrs)


submit : List (Attribute msg) -> List (Html msg) -> Html msg
submit attrs =
    Html.button (type_ "submit" :: attrs)


viewFieldErrors : a -> List ( a, String ) -> Html msg
viewFieldErrors field errors =
    errors
        |> List.filter (\( f, _ ) -> f == field)
        |> viewErrors


viewErrors : List ( a, String ) -> Html msg
viewErrors errors =
    errors
        |> List.map (\( _, error ) -> li [] [ text error ])
        |> ul [ class "errors" ]
