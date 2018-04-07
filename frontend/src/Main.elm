module Main exposing (main)

import Data.Session exposing (Session)
import Html exposing (..)
import Navigation exposing (Location)
import Route exposing (Route)


main =
    Navigation.program (RouteTo << Route.fromLocation)
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



---- model ----


type Page
    = Root
    | Login


type alias Model =
    { page : Page
    , session : Session
    }


initialPage : Page
initialPage =
    Root


init : Location -> ( Model, Cmd Msg )
init _ =
    ( Model initialPage { user = Nothing }, Cmd.none )



---- update ----


type Msg
    = RouteTo (Maybe Route)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RouteTo _ ->
            ( model, Cmd.none )



---- subscriptions ----


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



---- view ----


view : Model -> Html Msg
view model =
    div [] [ text "hnng" ]
