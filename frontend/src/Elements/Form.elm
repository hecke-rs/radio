module Elements.Form exposing (passwordInput, submit, textInput)

import Html exposing (Attribute, Html)
import Html.Attributes exposing (type_)


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
