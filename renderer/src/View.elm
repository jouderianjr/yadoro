module View exposing (view)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (onClick)
import Element.Font as Font
import Html exposing (Html)
import Html.Attributes as HtmlAttr
import Model exposing (Model)
import Msg exposing (Msg(..))
import Types exposing (CurrentTimer, PomodoroConfig, State(..), TimerType(..))
import Utils exposing (intToFormattedString, when)


secondaryColor : Color
secondaryColor =
    rgb255 75 255 75


blackColor : Color
blackColor =
    rgb255 0 0 0


view : Model -> Html Msg
view model =
    layout
        [ width fill
        , height fill
        , Background.color blackColor
        , Font.color secondaryColor
        , centerX
        , centerY
        , Font.family
            [ Font.typeface "DS Digital"
            , Font.sansSerif
            ]
        , Font.color secondaryColor
        ]
        (viewMain model)


viewMain : Model -> Element Msg
viewMain model =
    case model.state of
        Idle ->
            viewIdle model.pomodoroConfig

        Running timerType currentTimer ->
            viewTimer timerType currentTimer True

        Paused timerType currentTimer ->
            viewTimer timerType currentTimer False


viewIdle : PomodoroConfig -> Element Msg
viewIdle { workTime, restTime } =
    column
        [ centerX, centerY, spacing 20 ]
        [ column [ spacing 8, centerX, centerY ]
            [ el [ centerX, Font.size 36 ] <| timerText workTime
            , el [ centerX, Font.size 20 ] <| timerText restTime
            ]
        , row [ centerX, spacing 20 ]
            [ button "far fa-keyboard" (InitTimer Work)
            , button "fas fa-bed" (InitTimer Rest)
            ]
        ]


viewTimer : TimerType -> CurrentTimer -> Bool -> Element Msg
viewTimer timerType currentTimer isRunning =
    column
        [ Font.size 36
        , spacing 20
        , centerX
        , centerY
        , paddingXY 0 20
        ]
        [ column [ spacing 8, centerX ]
            [ viewTimerType timerType
            , el [ centerX, Font.size 20 ] (text "Paused")
                |> when (not isRunning)
            ]
        , el [ centerX ] (timerText currentTimer)
        , if isRunning then
            viewRunningButtons timerType currentTimer

          else
            viewPauseButtons timerType currentTimer
        ]


viewTimerType : TimerType -> Element Msg
viewTimerType timerType =
    el [ centerX ] <|
        text <|
            case timerType of
                Work ->
                    "Work Time"

                Rest ->
                    "Rest Time"


viewRunningButtons : TimerType -> CurrentTimer -> Element Msg
viewRunningButtons timerType currentTimer =
    row [ centerX, spacing 20 ]
        [ button "fas fa-pause" (PauseTimer timerType currentTimer)
        , button "fas fa-circle" StopTimer
        ]


viewPauseButtons : TimerType -> CurrentTimer -> Element Msg
viewPauseButtons timerType currentTimer =
    el [ centerX ] <|
        button "fas fa-play" (StartTimer timerType currentTimer)


button : String -> Msg -> Element Msg
button icon msg =
    Html.i [ HtmlAttr.class icon ] []
        |> html
        |> el
            ([ Font.color secondaryColor
             , Font.size 18
             , pointer
             , onClick msg
             , paddingXY 16 8
             , Border.width 1
             , Border.color secondaryColor
             , Border.rounded 8
             , mouseOver
                [ Background.color secondaryColor
                , Font.color blackColor
                ]
             ]
                ++ colorTransition 100
            )


timerText : Int -> Element Msg
timerText val =
    val
        |> intToFormattedString
        |> text


colorTransition : Int -> List (Attribute msg)
colorTransition time =
    [ ( "transition-property", "color, background-color, border-color" )
    , ( "transition-duration", String.fromInt time ++ "ms" )
    , ( "transition-timing-function", "linear" )
    ]
        |> List.map stylePair


stylePair : ( String, String ) -> Attribute msg
stylePair ( k, v ) =
    htmlAttribute <| HtmlAttr.style k v
