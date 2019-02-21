module Main exposing (main)

import Browser
import Dice exposing (Dice)
import Html exposing (..)
import Table exposing (DisplayableLine, Line, Table, tableToDisplay)


type Msg
    = RollTable


type alias Model =
    { table : Table
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model
        { title = "Example table"
        , lines = [ Line 2 "value1", Line 1 "value 2", Line 1 "value 3", Line 1 "value 4" ]
        , description = "Benchmark table, roll with two D3"
        , diceGroup = Just [ Dice.Dice3, Dice.Dice3 ]
        }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msf model =
    ( model, Cmd.none )


renderLine : DisplayableLine -> Html msg
renderLine line =
    tr [] [ td [] [ text line.interval ], td [] [ text line.value ] ]


view : Model -> Html Msg
view model =
    let
        displayableTable =
            tableToDisplay model.table
    in
    table [] [ thead [] [ tr [] [ td [] [ text "Roll" ], td [] [ text "value" ] ] ], tbody [] (List.map renderLine displayableTable) ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main =
    Browser.element { init = init, subscriptions = subscriptions, update = update, view = view }
