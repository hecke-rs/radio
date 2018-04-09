module Page.Signin exposing (Model, Msg, init, update, view)

import Data.Session exposing (Session)
import Elements.Form exposing (passwordInput, submit, textInput, viewFieldErrors)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Util exposing ((=>))
import Validate exposing (Validator, ifBlank, validate)


---- model ----


type alias Model =
    { username : String
    , password : String
    , errors : List Error
    }


init : Model
init =
    { username = ""
    , password = ""
    , errors = []
    }



---- view ----


view : Session -> Model -> Html Msg
view session model =
    section [ class "page", class "login" ]
        [ viewForm model ]


viewForm : Model -> Html Msg
viewForm model =
    Html.form [ onSubmit SubmitForm ]
        [ span []
            [ label [ for "username" ] [ text "Username" ]
            , textInput [ id "username", class "basic-slide", onInput SetUsername ] []
            , viewFieldErrors Username model.errors
            ]
        , span []
            [ label [ for "password" ] [ text "Password" ]
            , passwordInput [ id "password", class "basic-slide", onInput SetPassword ] []
            , viewFieldErrors Password model.errors
            ]
        , button [ class "purple-lozenge" ]
            [ text "log in" ]
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
            case Debug.log "validation" (validate modelValidator model) of
                [] ->
                    model => Cmd.none

                errors ->
                    { model | errors = errors } => Cmd.none

        SetUsername username ->
            { model | username = username } => Cmd.none

        SetPassword password ->
            { model | password = password } => Cmd.none



---- validation ----


type Field
    = Username
    | Password


type alias Error =
    ( Field, String )


modelValidator : Validator Error Model
modelValidator =
    Validate.all
        [ ifBlank .username (Username => "username can't be blank")
        , ifBlank .password (Password => "password can't be blank")
        ]
