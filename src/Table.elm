module Table exposing (DisplayableLine, DisplayableTable, Line, Range, Table, Value, lineToDisplay, lineToValues, tableToDisplay)

import Dice exposing (DiceGroup, diceGroupMinMaxValue)


type alias Value =
    String


type alias Line =
    { interval : Int
    , value : Value
    }


type alias Table =
    { title : String
    , lines : List Line
    , description : String
    , diceGroup : Maybe DiceGroup
    }



-- type alias RollableTable =
--     List Value


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



-- tableToRollable : Table -> RollableTable
-- tableToRollable table =
--     table.lines
--         |> List.map lineToValues
--         |> List.foldl List.append []


lineToDisplay : Line -> ( Int, List DisplayableLine ) -> ( Int, List DisplayableLine )
lineToDisplay { interval, value } ( index, list ) =
    case interval of
        1 ->
            ( index + 1, { interval = String.fromInt index, value = value } :: list )

        _ ->
            ( index + interval, { interval = String.fromInt index ++ " - " ++ String.fromInt (index + interval - 1), value = value } :: list )


tableToDisplay : Table -> DisplayableTable
tableToDisplay table =
    case table.diceGroup of
        Just diceGroup ->
            let
                ( min, _ ) =
                    diceGroupMinMaxValue diceGroup
            in
            List.reverse (Tuple.second (List.foldl lineToDisplay ( min, [] ) table.lines))

        Nothing ->
            List.reverse (Tuple.second (List.foldl lineToDisplay ( 1, [] ) table.lines))
