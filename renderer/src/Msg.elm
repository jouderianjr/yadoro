port module Msg exposing (Msg(..), showStopNotification)

import Types exposing (CurrentTimer, TimerType)


port showStopNotification : String -> Cmd msg


type Msg
    = Decrement
    | InitTimer TimerType
    | StartTimer TimerType CurrentTimer
    | PauseTimer TimerType CurrentTimer
    | StopTimer
