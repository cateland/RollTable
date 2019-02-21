module Dice exposing (Dice(..), DiceGroup, diceGroupMinMaxValue, name)


type Dice
    = Dice3
    | Dice4
    | Dice6
    | Dice8
    | Dice10
    | Dice12
    | Dice20
    | Dice100


type alias DiceGroup =
    List Dice


maxValue : Dice -> Int
maxValue dice =
    case dice of
        Dice3 ->
            3

        Dice4 ->
            4

        Dice6 ->
            6

        Dice8 ->
            8

        Dice10 ->
            10

        Dice12 ->
            12

        Dice20 ->
            20

        Dice100 ->
            100


name : Dice -> String
name dice =
    "D(" ++ String.fromInt (maxValue dice) ++ ")"


accumulateMax : Dice -> Int -> Int
accumulateMax dice accumulatedMaxValue =
    accumulatedMaxValue + maxValue dice


diceGroupMinMaxValue : DiceGroup -> ( Int, Int )
diceGroupMinMaxValue diceGroup =
    let
        min =
            List.length diceGroup

        max =
            List.foldl accumulateMax 0 diceGroup
    in
    ( min, max )
