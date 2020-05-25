module Main exposing (main)

import Browser
import Model exposing (Model)
import Msg exposing (Msg(..))
import Subscriptions exposing (subscriptions)
import Update exposing (update)
import View exposing (view)


main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> ( Model.init, Cmd.none )
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
