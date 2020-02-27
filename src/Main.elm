module Main exposing (..)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }


type alias Model =
    { greeting : String }


type alias Flags =
    {}


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { greeting = "" }, Cmd.none )


type Msg
    = Greet String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Greet s ->
            ( { model | greeting = s }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions m =
    Sub.none


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick (Greet "hi") ] [ text "hi" ]
        , text model.greeting
        , button [ onClick (Greet "hello") ] [ text "hello" ]
        ]
