module AdvancedEmbedded exposing (..)

import Html exposing (..)
import Main
import Ports


type alias Flags =
    { main : Main.Flags
    }


type alias Model =
    { main : Main.Model
    }


type Msg
    = MMsg Main.Msg


init : Flags -> ( Model, Cmd Msg )
init f =
    let
        ( mmodel, mcmd ) =
            Main.init f.main
    in
    ( { main = mmodel }, Cmd.map MMsg mcmd )


view : Model -> Html Msg
view m =
    div []
        [ Html.map MMsg (Main.view m.main)
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MMsg mmsg ->
            let
                ( mmodel, mcmd ) =
                    Main.update mmsg model.main
            in
            ( { model | main = mmodel }
            , Cmd.batch
                [ Ports.log "parent app log"
                , Cmd.map MMsg mcmd
                ]
            )


subscriptions : Model -> Sub Msg
subscriptions m =
    Sub.batch
        [ Sub.map MMsg (Main.subscriptions m.main)

        -- replace `Sub.none` here with parent app's subscriptions, or another
        -- child's subscriptions
        , Sub.none
        ]


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }
