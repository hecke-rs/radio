module Page.Signin exposing (Model, Msg, OutMsg(..), init, update, view)

import Data.Session exposing (Session)
import Data.User as User exposing (User)
import Elements.Form exposing (passwordInput, submit, textInput, viewFieldErrors)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Decode exposing (Decoder, decodeString, field, string)
import Request.User
import Route
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
        [ viewFieldErrors Form model.errors
        , span []
            [ label [ for "username" ] [ text "Username" ]
            , textInput [ id "username", onInput SetUsername ] []
            , viewFieldErrors Username model.errors
            ]
        , span []
            [ label [ for "password" ] [ text "Password" ]
            , passwordInput [ id "password", onInput SetPassword ] []
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
    | RequestCompleted (Result Http.Error User)


type OutMsg
    = Nop
    | SetUser User


update : Msg -> Model -> ( ( Model, Cmd Msg ), OutMsg )
update msg model =
    case msg of
        SubmitForm ->
            case validate modelValidator model of
                [] ->
                    { model | errors = [] } => Http.send RequestCompleted (Request.User.signIn model) => Nop

                errors ->
                    { model | errors = errors } => Cmd.none => Nop

        SetUsername username ->
            { model | username = username } => Cmd.none => Nop

        SetPassword password ->
            { model | password = password } => Cmd.none => Nop

        RequestCompleted (Err error) ->
            let
                errorMessages =
                    case error of
                        Http.BadStatus resp ->
                            resp.body |> decodeString (field "message" string) |> Result.map List.singleton |> Result.withDefault []

                        _ ->
                            [ "unable to perform login" ]
            in
            { model | errors = List.map (\msg -> ( Form, msg )) errorMessages } => Cmd.none => Nop

        RequestCompleted (Ok user) ->
            model => Route.modifyUrl Route.Root => SetUser user



---- validation ----


type Field
    = Form -- errors applying to the whole form
    | Username
    | Password


type alias Error =
    ( Field, String )


modelValidator : Validator Error Model
modelValidator =
    Validate.all
        [ ifBlank .username (Username => "username can't be blank")
        , ifBlank .password (Password => "password can't be blank")
        ]
