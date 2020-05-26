module Types exposing
    ( CurrentTimer
    , PomodoroConfig
    , State(..)
    , TimerType(..)
    , defaultPomodoroConfig
    , timerTypeToStopMessage
    )


type alias CurrentTimer =
    Int


type State
    = Idle
    | Running TimerType CurrentTimer
    | Paused TimerType CurrentTimer
    | Finished TimerType


type TimerType
    = Work
    | Rest


type alias PomodoroConfig =
    { workTime : Int
    , restTime : Int
    }


defaultPomodoroConfig : PomodoroConfig
defaultPomodoroConfig =
    { workTime = 25 * 60
    , restTime = 5 * 60
    }


timerTypeToStopMessage : TimerType -> String
timerTypeToStopMessage timerType =
    case timerType of
        Work ->
            "Rest? Work? You choose!"

        Rest ->
            "Back to work baby!"
