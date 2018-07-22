module Main exposing (main)

import Data.Session exposing (Session)
import Data.User exposing (User)
import Elements.Page as Page
import Html exposing (..)
import Http
import Navigation exposing (Location)
import Page.Home as Home
import Page.Signin as Signin
import Request.User
import Route exposing (Route)
import Util exposing ((=>))


{-| Initialize the whole application; called from Javascript.
-}
main : Program Flags Model Msg
main =
    Navigation.programWithFlags (RouteTo << Route.fromLocation)
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



---- model ----


{-| A sum type representing a page. Owns page state, if it has it.
-}
type Page
    = Blank
    | Home Home.Model
    | Signin Signin.Model
    | NotFound -- essentially our 404 page


{-| The global applcation state. Owns the session and current page
(and all the associated state that comes with).
-}
type alias Model =
    { page : Page
    , session : Session
    }


initialPage : Page
initialPage =
    Blank


type alias Flags =
    { token : Maybe String
    }


{-| Initializes application state, variable over the current hashroute.

Is additionally responsible for hydrating the user session - it fires a
request to the "get user endpoint" if we currently have a token;
that's later handled by the HydratedUser message.

-}
init : Flags -> Location -> ( Model, Cmd Msg )
init flags location =
    let
        ( model, cmd ) =
            routeTo (Route.fromLocation location)
                { page = Blank
                , session = { user = Nothing }
                }
    in
    case flags.token of
        Just token ->
            model => Cmd.batch [ cmd, Http.send HydratedUser <| Request.User.hydrate token ]

        Nothing ->
            model => cmd



---- update ----


{-| Sum type of all messages in the application.
-}
type Msg
    = RouteTo (Maybe Route)
    | HydratedUser (Result Http.Error User)
    | HomeMsg Home.Msg
    | SigninMsg Signin.Msg


{-| Takes the current state and a message to process; returns a tuple of
the new state plus any commands we wish to dispatch.
-}
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "msg" msg of
        RouteTo route ->
            routeTo route model

        HydratedUser (userResult) ->
            -- just forget the session if we have any error
            { model | session = { user = Result.toMaybe userResult } } => Cmd.none

        _ ->
            updatePage model.page msg model


{-| Routes to a given route from the current state.
-}
routeTo : Maybe Route -> Model -> ( Model, Cmd Msg )
routeTo route model =
    case route of
        Nothing ->
            { model | page = NotFound } => Cmd.none

        Just Route.Root ->
            { model | page = Home Home.init } => Cmd.none

        Just Route.Signin ->
            { model | page = Signin Signin.init } => Cmd.none


updatePage : Page -> Msg -> Model -> ( Model, Cmd Msg )
updatePage page msg model =
    case ( msg, page ) of
        ( SigninMsg subMsg, Signin subModel ) ->
            let
                ( ( pageModel, cmd ), extMsg ) =
                    Signin.update subMsg subModel

                newModel =
                    case extMsg of
                        Signin.Nop ->
                            model

                        Signin.SetUser user ->
                            { model | session = { user = Just user } }
            in
            { newModel | page = Signin pageModel } => Cmd.map SigninMsg cmd

        ( _, NotFound ) ->
            -- disregard all messages when we're on the NotFound page
            model => Cmd.none

        ( _, _ ) ->
            -- disregard messages that arrived for the wrong page
            model => Cmd.none



---- subscriptions ----


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



---- view ----


{-| Takes the current state and renders the application HTML.
-}
view : Model -> Html Msg
view model =
    viewPage model.session model.page


viewPage : Session -> Page -> Html Msg
viewPage session page =
    case page of
        Blank ->
            -- for the initial page load
            Html.text ""

        Home subModel ->
            Home.view session subModel |> Page.frame |> Html.map HomeMsg

        Signin subModel ->
            Signin.view session subModel |> Page.fullscreenFrame |> Html.map SigninMsg

        NotFound ->
            Html.text "we did a wittle fucko boingo"
