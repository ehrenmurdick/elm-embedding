module Embedded exposing (..)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Increment


type alias Model =
    { greeting : String
    , increment : Increment.Model
    }


init : Model
init =
    { greeting = ""
    , increment = Increment.init
    }


type Msg
    = Greet String
    | IncMsg Increment.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        Greet s ->
            { model | greeting = s }

        IncMsg m ->
            { model | increment = Increment.update m model.increment }


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick (Greet "hi") ] [ text "hi" ]
        , text model.greeting
        , button [ onClick (Greet "hello") ] [ text "hello" ]
        , Html.map IncMsg (Increment.view model.increment)
        ]
