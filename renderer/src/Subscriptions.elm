module Subscriptions exposing (subscriptions)

import Model exposing (Model)
import Msg exposing (Msg(..))
import Time
import Types exposing (State(..))


subscriptions : Model -> Sub Msg
subscriptions model =
    case model.state of
        Running _ _ ->
            Time.every 1000 (always Decrement)

        _ ->
            Sub.none
