module Main exposing (main)
import Html exposing (..)

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

---- init ----
init : (Model, Cmd Msg)
init = (Model 2, Cmd.none)

---- model ----
type alias Model = {
  x: Int
}

---- update ----
type Msg
  = Hnng

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Hnng -> (model, Cmd.none)

---- subscriptions ----
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

---- view ----
view : Model -> Html Msg
view model =
  div [] [ text "hnng" ]
