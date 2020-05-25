module Update exposing (update)

import Model exposing (Model, State(..))
import Msg exposing (Msg(..), showStopNotification)
import Utils exposing (ifThenElse)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Decrement ->
            let
                newTimer =
                    model.currentTimer - 1

                newState =
                    ifThenElse (newTimer == 0) Finished model.state

                newCmd =
                    ifThenElse (newTimer == 0) (showStopNotification "") Cmd.none
            in
            ( { model
                | currentTimer = newTimer
                , state = newState
              }
            , newCmd
            )

        StartTimer ->
            ( { model | state = Running }, Cmd.none )

        PauseTimer ->
            ( { model | state = Paused }, Cmd.none )
