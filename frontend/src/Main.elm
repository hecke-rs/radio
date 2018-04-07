module Main exposing (main)

import Data.Session exposing (Session)
import Html exposing (..)
import Navigation exposing (Location)
import Route exposing (Route)


{-| Initialize the whole application; called from Javascript.
-}
main =
    Navigation.program (RouteTo << Route.fromLocation)
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



---- model ----


{-| A sum type representing a page. Owns page state, if it has it.
-}
type Page
    = Root
    | Login


{-| The global applcation state. Owns the session and current page
(and all the associated state that comes with).
-}
type alias Model =
    { page : Page
    , session : Session
    }


initialPage : Page
initialPage =
    Root


{-| Initializes application state, variable over the current hashroute.
-}
init : Location -> ( Model, Cmd Msg )
init _ =
    ( Model initialPage { user = Nothing }, Cmd.none )



---- update ----


{-| Sum type of all messages in the application.
-}
type Msg
    = RouteTo (Maybe Route)


{-| Takes the current state and a message to process; returns a tuple of
the new state plus any commands we wish to dispatch.
-}
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


{-| Takes the current state and renders the application HTML.
-}
view : Model -> Html Msg
view model =
    div [] [ text "hnng" ]
