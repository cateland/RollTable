module Dice exposing (Dice(..), DiceGroup, diceGroupMinMaxValue)


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


accumulateMax : Dice -> Int -> Int
accumulateMax dice accumulatedMaxValue =
    case dice of
        Dice3 ->
            accumulatedMaxValue + 3

        Dice4 ->
            accumulatedMaxValue + 4

        Dice6 ->
            accumulatedMaxValue + 6

        Dice8 ->
            accumulatedMaxValue + 8

        Dice10 ->
            accumulatedMaxValue + 10

        Dice12 ->
            accumulatedMaxValue + 12

        Dice20 ->
            accumulatedMaxValue + 20

        Dice100 ->
            accumulatedMaxValue + 100


diceGroupMinMaxValue : DiceGroup -> ( Int, Int )
diceGroupMinMaxValue diceGroup =
    let
        min =
            List.length diceGroup

        max =
            List.foldl accumulateMax 0 diceGroup
    in
    ( min, max )
