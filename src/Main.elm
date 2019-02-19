module Main exposing (main)

import Html exposing (..)


type alias Value =
    String


type alias Line =
    { interval : Int
    , value : Value
    }


type alias Table =
    List Line


type alias RollableTable =
    List Value


type alias Range =
    ( Int, Int )


type alias DisplayableLine =
    { interval : String
    , value : Value
    }


type alias DisplayableTable =
    List DisplayableLine


lineToValues : Line -> List Value
lineToValues line =
    List.repeat line.interval line.value


tableToRollable : Table -> RollableTable
tableToRollable table =
    table
        |> List.map lineToValues
        |> List.foldl List.append []


lineToDisplay : Line -> ( Int, List DisplayableLine ) -> ( Int, List DisplayableLine )
lineToDisplay { interval, value } ( index, list ) =
    case interval of
        1 ->
            ( index + 1, { interval = String.fromInt index, value = value } :: list )

        _ ->
            ( index + interval, { interval = String.fromInt index ++ " - " ++ String.fromInt (index + interval - 1), value = value } :: list )


tableToDisplay : Table -> DisplayableTable
tableToDisplay table =
    List.reverse (Tuple.second (List.foldl lineToDisplay ( 1, [] ) table))


exampleTable =
    [ Line 2 "value1", Line 2 "value 2", Line 1 "value 3", Line 1 "value 4" ]


renderLine : DisplayableLine -> Html msg
renderLine line =
    tr [] [ td [] [ text line.interval ], td [] [ text line.value ] ]


main =
    let
        displayableTable =
            tableToDisplay exampleTable
    in
    table [] [ thead [] [], tbody [] (List.map renderLine displayableTable) ]
