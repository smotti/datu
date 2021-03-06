module Pomodoro.View exposing (viewPomodoro)

import Date exposing (fromTime)
import Date.Format exposing (format)
import Html exposing (Html, button, div, h1, h2, input, label, p, span, text)
import Html.App as App
import Html.Attributes exposing (attribute, class, id, name, style, type')
import Html.Events exposing (onClick)
import Pomodoro.Messages exposing (Msg(..))
import Pomodoro.Models exposing (..)
import TimeSettings.View as TSV


timerFormat : String
timerFormat =
  "%M:%S"


viewPomodoro : Model -> Html Msg
viewPomodoro model =
  div [ class "row" ]
    [ div [ class "col-xs-12 col-md-8 col-md-offset-2 jumbotron" ]
      [ (viewStepHeader model)
      -- Control Buttons
      , (viewControlButtons model)
      , App.map TimeSettingsMsg (TSV.viewSettings model.timeSettings)
      ]
    ]


viewStepHeader : Model -> Html Msg
viewStepHeader { pomodoroStep, timer } =
  div [ class "row" ]
    [ h1 [ style [("text-align", "center")] ] [ text <| toString pomodoroStep ]
    , h2 [ style [("text-align", "center")] ]
      [ text <| format timerFormat <| fromTime timer ]
    ]


viewControlButtons : Model -> Html Msg
viewControlButtons model =
  let
    currentStep = model.pomodoroStep
  in
    p [ class "row" ]
      [ div
        [ class "btn-group col-xs-12 col-md-12"
        , attribute "data-toggle" "buttons"
        , style [("display", "flex"), ("justify-content", "center")]
        ]
        [ (viewPlayButton model)
        , label
          [ class <| "btn btn-primary " ++ isActiveStep Pomodoro currentStep
          , onClick <| Do Pomodoro
          ]
          [ input 
            [ type' "radio"
            , name "options"
            , id "doPomodoro"
            , attribute "autocomplete" "off"
            ] []
          , span
            [ class "glyphicon glyphicon-calendar"
            , attribute "aria-hidden" "true"
            ] []
          ]
        , label
          [ class <| "btn btn-primary " ++ isActiveStep ShortBreak currentStep
          , onClick <| Do ShortBreak
          ]
          [ input 
            [ type' "radio"
            , name "options"
            , id "doShortBreak"
            , attribute "autocomplete" "off"
            ] []
          , span
            [ class "glyphicon glyphicon-headphones"
            , attribute "aria-hidden" "true"
            ] []
          ]
        , label
          [ class <| "btn btn-primary " ++ isActiveStep LongBreak currentStep
          , onClick <| Do LongBreak
          ]
          [ input
            [ type' "radio"
            , name "options"
            , id "doLongBreak"
            , attribute "autocomplete" "off"
            ] []
          , span
            [ class "glyphicon glyphicon-eye-close"
            , attribute "aria-hidden" "true"
            ] []
          ]
        ]
      ]


isActiveStep : PomodoroStep -> PomodoroStep -> String
isActiveStep step currentStep =
  if step == currentStep then "active" else ""


viewPlayButton : Model -> Html Msg
viewPlayButton { timerEnabled } =
  let
    (msg, glyph) =
      if timerEnabled then
        (StopTimer, "glyphicon-stop")
      else
        (StartTimer, "glyphicon-play")
    pressed =
      if timerEnabled then "true" else "false"
    active =
      if timerEnabled then "active" else ""
  in
    button
    [ class <| "btn btn-primary " ++ active
    , onClick msg
    , type' "button"
    , attribute "data-toggle" "button"
    , attribute "aria-pressed" pressed
    , attribute "autocomplete" "off"
    ]
    [ span
      [ class <| "glyphicon " ++ glyph
      , attribute "aria-hidden" "true"
      ] []
    ]
