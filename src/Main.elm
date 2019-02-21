module Main exposing (main)

import Browser
import Dice exposing (Dice, name)
import Html exposing (..)
import Table exposing (DisplayableLine, Line, Table, Value, tableToDisplay)


type Msg
    = RollTable


type alias Result =
    ( Value, List ( Dice, Int ) )


type alias Model =
    { table : Table
    , result : Maybe Result
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model
        { title = "Example table"
        , lines = [ Line 2 "value1", Line 1 "value 2", Line 1 "value 3", Line 1 "value 4" ]
        , description = "Benchmark table, roll with two D3"
        , diceGroup = Just [ Dice.Dice3, Dice.Dice3 ]
        }
        (Just ( "value2", [ ( Dice.Dice3, 1 ), ( Dice.Dice3, 2 ) ] ))
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msf model =
    ( model, Cmd.none )


renderLine : DisplayableLine -> Html Msg
renderLine line =
    tr [] [ td [] [ text line.interval ], td [] [ text line.value ] ]


renderDiceRoll : ( Dice, Int ) -> Html Msg
renderDiceRoll ( dice, roll ) =
    li [] [ text (name dice ++ ":" ++ String.fromInt roll) ]


renderDicesRolls : Maybe Result -> Html Msg
renderDicesRolls result =
    case result of
        Just ( _, rolls ) ->
            let
                total =
                    List.foldl (\( _, value ) acc -> acc + value) 0 rolls
            in
            ul [] (List.append (List.map renderDiceRoll rolls) [ li [] [ text ("total:" ++ String.fromInt total) ] ])

        Nothing ->
            ul [] []


renderRolledValue : Maybe Result -> Html Msg
renderRolledValue result =
    case result of
        Just ( value, _ ) ->
            span [] [ text value ]

        Nothing ->
            span [] []


view : Model -> Html Msg
view model =
    let
        displayableTable =
            tableToDisplay model.table
    in
    div []
        [ table [] [ thead [] [ tr [] [ td [] [ text "Roll" ], td [] [ text "value" ] ] ], tbody [] (List.map renderLine displayableTable) ]
        , renderDicesRolls model.result
        , renderRolledValue model.result
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main =
    Browser.element { init = init, subscriptions = subscriptions, update = update, view = view }
