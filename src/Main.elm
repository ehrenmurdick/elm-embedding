module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Input exposing (inputField)
import Ports
import Time


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }


type alias Model =
    { name : String
    , email : String
    }


type alias Flags =
    { name : String
    , email : String
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { name = flags.name
      , email = flags.email
      }
    , Cmd.none
    )


type Msg
    = Greet
    | SetName String
    | SetEmail String
    | Tick Time.Time


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Greet ->
            ( model, Ports.log "Greet" )

        SetName s ->
            ( { model | name = s }, Cmd.none )

        SetEmail s ->
            ( { model | email = s }, Cmd.none )

        Tick t ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions m =
    Time.every 1000 Tick


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ inputField "name" SetName model.name
        , inputField "email" SetEmail model.email
        , button [ onClick Greet ] [ text "greet" ]
        ]
