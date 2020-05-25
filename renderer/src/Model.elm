module Model exposing (Model, PomodoroConfig, State(..), init)


type State
    = Idle
    | Running
    | Paused
    | Finished


type TimerType
    = Work
    | Rest


type alias Model =
    { currentTimer : Int
    , pomodoroConfig : PomodoroConfig
    , state : State
    }


type alias PomodoroConfig =
    { workTime : Int
    , restTime : Int
    }


defaultPomodoroConfig : PomodoroConfig
defaultPomodoroConfig =
    { workTime = 25 * 60
    , restTime = 5 * 60
    }


init : Model
init =
    { currentTimer = 25 * 60
    , pomodoroConfig = defaultPomodoroConfig
    , state = Idle
    }
