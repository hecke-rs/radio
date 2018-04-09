module Page.Signin exposing (Model, Msg, init, update, view)

import Data.Session exposing (Session)
import Elements.Form exposing (passwordInput, submit, textInput)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Util exposing ((=>))


---- model ----


type alias Model =
    { username : String
    , password : String
    }


init : Model
init =
    { username = ""
    , password = ""
    }



---- view ----


view : Session -> Model -> Html Msg
view session model =
    section [ class "page", class "login" ]
        [ viewForm ]


viewForm : Html Msg
viewForm =
    Html.form []
        [ textInput [ placeholder "Username", onInput SetUsername ] []
        , passwordInput [ placeholder "Password", onInput SetPassword ] []
        , submit [] [ text "log in" ]
        ]



---- update ----


type Msg
    = SubmitForm
    | SetUsername String
    | SetPassword String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SubmitForm ->
            model => Cmd.none

        SetUsername username ->
            { model | username = username } => Cmd.none

        SetPassword password ->
            { model | password = password } => Cmd.none
