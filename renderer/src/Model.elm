module Model exposing (Model, init)

import Types exposing (PomodoroConfig, State(..), defaultPomodoroConfig)


type alias Model =
    { pomodoroConfig : PomodoroConfig
    , state : State
    }


init : Model
init =
    { pomodoroConfig = defaultPomodoroConfig
    , state = Idle
    }
