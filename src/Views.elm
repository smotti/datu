module Views exposing (..)

import Date exposing (fromTime)
import Date.Format exposing (format)
import Debug exposing (log)
import Html exposing (Html, a, button, div, h1, h2, input, p, span, text)
import Html.Attributes exposing (attribute, class, href, id, placeholder, style,
  value)
import Html.Events exposing (onClick)
import Messages exposing (..)
import Models exposing (Model, PomodoroStep(..))
import Update exposing (..)


timerFormat : String
timerFormat =
  "%M:%S"


viewPomodoro : Model -> Html Msg
viewPomodoro model =
  div [ class "container-fluid" ]
    [ div [ class "row" ]
      [ div [ class "col-xs-12 col-md-8 col-md-offset-2 jumbotron" ]
        -- TODO: Change heading based on step and also show time here
        [ (viewStepHeader model)
        {--
        , p [ class "row" ]
          [ span [ class "col-xs-8 col-md-6 col-xs-offset-2 col-md-offset-3" ]
            [ input [ class "form-control" , placeholder "Task Name" ] [] ]
          ]
        --}
        -- Control Buttons
        , p [ class "row", style [("text-align", "center")] ]
          -- Start/Stop
          [ (viewPlayButton model) 
          -- Pomodoro
          , div [ class "col-xs-3 col-md-3" ]
            [ button [ class "btn btn-primary", onClick <| Do Pomodoro ]
              [ span
                [ class "glyphicon glyphicon-calendar"
                , attribute "aria-hidden" "true"
                ] []
              ]
            ]
          -- Short Break
          , div [ class "col-xs-3 col-md-3" ]
            [ button [ class "btn btn-primary", onClick <| Do ShortBreak ]
              [ span
                [ class "glyphicon glyphicon-headphones"
                , attribute "aria-hidden" "true"
                ] []
              ]
            ]
          -- Long Break
          , div [ class "col-xs-3 col-md-3" ]
            [ button [ class "btn btn-primary", onClick <| Do LongBreak ]
              [ span
                [ class "glyphicon glyphicon-eye-close"
                , attribute "aria-hidden" "true"
                ] []
              ]
            ]
          ]
        , (viewTimerSettings model)
        ]
      , text <| toString model
    ]
  ]


viewStepHeader : Model -> Html Msg
viewStepHeader { pomodoroStep, timer } =
  div [ class "row" ]
    [ h1 [ style [("text-align", "center")] ] [ text <| toString pomodoroStep ]
    , h2 [ style [("text-align", "center")] ]
      [ text <| format timerFormat <| fromTime <| timer ]
    ]


viewPlayButton : Model -> Html Msg
viewPlayButton { timerEnabled } =
  let
    (msg, glyph) =
      if timerEnabled then
        (StopTimer, "glyphicon-stop")
      else
        (StartTimer, "glyphicon-play")
  in
    div [ class "col-xs-3 col-md-3" ]
      [ button [ class "btn btn-primary", onClick msg ]
        [ span
          [ class <| "glyphicon " ++ glyph
          , attribute "aria-hidden" "true"
          ] []
        ]
      ]


viewTimerSettings : Model -> Html Msg
viewTimerSettings model =
  div [ class "row" ]
    [ p [ class "row" ]
      [ a 
        [ class "btn col-xs-12 col-md-12"
        , attribute "role" "button"
        , attribute "data-toggle" "collapse"
        , href "#settings"
        , attribute "aria-expanded" "false"
        , attribute "aria-controls" "settingsCollapsable"
        , style [("text-align", "center")]
        , onClick ToggleTimerSettings
        ] 
        [ (viewTimerSettingsChevron model.showSettings) ]
      ]
    -- Timer settings
    , div [ class "row collapse", id "settings", style [("text-align", "center")] ]
      [ p [ class "col-xs-4 col-md-4" ] [ text "Pomodoro Timer" ]
      , p [ class "col-xs-4 col-md-4" ] [ text "SB Timer" ]
      , p [ class "col-xs-4 col-md-4" ] [ text "LB Timer" ]
      ]
    ]

viewTimerSettingsChevron : Bool -> Html Msg
viewTimerSettingsChevron show =
  if show then
    span
      [ class "glyphicon glyphicon-chevron-up"
      , attribute "aria-hidden" "true"
      ] []
  else
    span
      [ class "glyphicon glyphicon-chevron-down"
      , attribute "aria-hidden" "true"
      ] []
