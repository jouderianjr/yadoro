module Utils exposing (ifThenElse, intToFormattedString, when)

import Element exposing (Element, none)


when : Bool -> Element msg -> Element msg
when shouldShow element =
    if shouldShow then
        element

    else
        none


ifThenElse : Bool -> a -> a -> a
ifThenElse cond exp1 exp2 =
    if cond then
        exp1

    else
        exp2


intToFormattedString : Int -> String
intToFormattedString timer =
    let
        minutes =
            timer // 60

        seconds =
            timer
                |> remainderBy 60

        prettifyNumber num =
            let
                strNum =
                    String.fromInt num
            in
            ifThenElse
                (String.length strNum == 1)
                ("0" ++ strNum)
                strNum
    in
    prettifyNumber minutes ++ ":" ++ prettifyNumber seconds
