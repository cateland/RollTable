module Main exposing (main)

import Dice exposing (Dice)
import Html exposing (..)
import Table exposing (DisplayableLine, Line, tableToDisplay)


exampleTable =
    { title = "Example table"
    , lines = [ Line 2 "value1", Line 1 "value 2", Line 1 "value 3", Line 1 "value 4" ]
    , description = "Benchmark table, roll with two D3"
    , diceGroup = Just [ Dice.Dice3, Dice.Dice3 ]
    }


renderLine : DisplayableLine -> Html msg
renderLine line =
    tr [] [ td [] [ text line.interval ], td [] [ text line.value ] ]


main =
    let
        displayableTable =
            tableToDisplay exampleTable
    in
    table [] [ thead [] [ tr [] [ td [] [ text "Roll" ], td [] [ text "value" ] ] ], tbody [] (List.map renderLine displayableTable) ]
