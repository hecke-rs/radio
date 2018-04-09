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
    Html.text "foo"


type Msg
    = Foo
