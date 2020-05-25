module Subscriptions exposing (subscriptions)

import Model exposing (Model, State(..))
import Msg exposing (Msg(..))
import Time


subscriptions : Model -> Sub Msg
subscriptions model =
    case model.state of
        Running ->
            Time.every 1000 (always Decrement)

        _ ->
            Sub.none
