module Page.Home exposing (Model, Msg, init, view)

import Data.Session exposing (Session)
import Html exposing (Html)


type alias Model =
    {}


init : Model
init =
    {}


view : Session -> Model -> Html Msg
view session model =
    let
        text =
            case session.user of
                Just user ->
                    "Just User : " ++ user.username

                _ ->
                    "Nothing"
    in
    Html.text text


type Msg
    = Foo
