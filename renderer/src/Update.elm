module Update exposing (update)

import Model exposing (Model)
import Msg exposing (Msg(..), showStopNotification)
import Types exposing (State(..), TimerType(..), timerTypeToStopMessage)
import Utils exposing (ifThenElse)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Decrement ->
            case model.state of
                Running timerType currentTimer ->
                    let
                        newCurrentTimer =
                            currentTimer - 1
                    in
                    ( { model
                        | state =
                            ifThenElse
                                (newCurrentTimer == 0)
                                Idle
                                (Running timerType newCurrentTimer)
                      }
                    , ifThenElse
                        (newCurrentTimer == 0)
                        (showStopNotification <| timerTypeToStopMessage <| timerType)
                        Cmd.none
                    )

                _ ->
                    ( model, Cmd.none )

        InitTimer timerType ->
            ( { model
                | state =
                    Running timerType <|
                        case timerType of
                            Work ->
                                model.pomodoroConfig.workTime

                            Rest ->
                                model.pomodoroConfig.restTime
              }
            , Cmd.none
            )

        StartTimer timerType currentTimer ->
            ( { model | state = Running timerType currentTimer }
            , Cmd.none
            )

        PauseTimer timerType currentTimer ->
            ( { model | state = Paused timerType currentTimer }, Cmd.none )

        StopTimer ->
            ( { model | state = Idle }, Cmd.none )
