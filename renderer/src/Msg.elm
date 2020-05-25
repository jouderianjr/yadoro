port module Msg exposing (Msg(..), showStopNotification)


port showStopNotification : String -> Cmd msg


type Msg
    = Decrement
    | StartTimer
    | PauseTimer
