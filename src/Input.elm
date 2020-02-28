module Input exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    String


inputField : String -> (String -> msg) -> Model -> Html msg
inputField name f str =
    input
        [ value str
        , onInput f
        , type_ "text"
        , placeholder name
        ]
        []
