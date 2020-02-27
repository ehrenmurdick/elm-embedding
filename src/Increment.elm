module Increment exposing (..)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


type alias Flags =
    {}


type alias Model =
    { num : Int }


init : Model
init =
    { num = 0 }


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | num = model.num + 1 }

        Decrement ->
            { model | num = model.num - 1 }


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [] [ text (toString model.num) ]
        , button [ onClick Increment ] [ text "+" ]
        ]
