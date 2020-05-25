module View exposing (view)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (onClick)
import Element.Font as Font
import Html exposing (Html)
import Html.Attributes as HtmlAttr
import Model exposing (Model, PomodoroConfig, State(..))
import Msg exposing (Msg(..))
import Utils exposing (intToFormattedString)


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
        ]
    <|
        column
            [ width fill
            , height fill
            ]
            [ el [ alignRight ] <| viewSettings
            , viewMain model
            ]


viewMain : Model -> Element Msg
viewMain model =
    case model.state of
        Idle ->
            viewIdle model.pomodoroConfig

        Running ->
            viewTimer model

        _ ->
            text "holi guapi"


viewIdle : PomodoroConfig -> Element Msg
viewIdle { workTime, restTime } =
    column
        [ Font.family
            [ Font.typeface "DS Digital"
            , Font.sansSerif
            ]
        , width fill
        , height fill
        ]
        [ el [ centerX, Font.size 36, Font.color secondaryColor ] <| text <| intToFormattedString workTime
        , el [ centerX, Font.size 20, Font.color secondaryColor ] <| text <| intToFormattedString restTime
        , el [ centerX, paddingXY 0 20 ] <| button "fas fa-play" StartTimer
        ]


viewTimer : Model -> Element Msg
viewTimer model =
    column
        [ Font.family
            [ Font.typeface "DS Digital"
            , Font.sansSerif
            ]
        , Font.color secondaryColor
        , Font.size 36
        , width fill
        , height fill
        , spacing 20
        , centerX
        , centerY
        , paddingXY 0 20
        ]
        [ el [ centerX ] <| text <| intToFormattedString model.currentTimer
        , viewButtons model
        ]


viewButtons : Model -> Element Msg
viewButtons model =
    row
        [ centerX
        , spacing 20
        ]
    <|
        case model.state of
            Idle ->
                [ button "fas fa-play" StartTimer ]

            Running ->
                [ button "fas fa-pause" PauseTimer ]

            Paused ->
                [ button "fas fa-play" StartTimer ]

            Finished ->
                [ button "fas fa-redo" StartTimer ]


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


viewSettings : Element Msg
viewSettings =
    Html.i [ HtmlAttr.class "fas fa-cog" ] []
        |> html
        |> el
            [ Font.color secondaryColor
            , paddingEach
                { top = 10
                , right = 10
                , left = 0
                , bottom = 0
                }
            , Font.size 18
            ]
