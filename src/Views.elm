module Views exposing (..)

import Date exposing (fromTime)
import Date.Format exposing (format)
import Debug exposing (log)
import Html exposing (Html, a, button, div, h1, h2, input, label, p, span, text)
import Html.Attributes exposing (attribute, class, href, id, name, placeholder,
  style, type', value)
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
      [ (viewAlert model)
      , div [ class "col-xs-12 col-md-8 col-md-offset-2 jumbotron" ]
        [ (viewStepHeader model)
        {--
        , p [ class "row" ]
          [ span [ class "col-xs-8 col-md-6 col-xs-offset-2 col-md-offset-3" ]
            [ input [ class "form-control" , placeholder "Task Name" ] [] ]
          ]
        --}
        -- Control Buttons
        , p [ class "row" ] [ (viewControlBottons model) ]
        , (viewTimerSettings model)
        ]
      --, text <| toString model
    ]
  ]


viewAlert : Model -> Html Msg
viewAlert { showAlert, alert } =
  let
      msg =
        case alert of
          Nothing -> "Unkown error"
          Just a -> a.message
      ofType =
        case alert of
          Nothing -> "alert-danger"
          Just a -> a.ofType
      display =
        if showAlert then ("display", "block") else ("display", "none")
  in
    div
      [ class <| "alert alert-dismissible " ++ ofType
      , attribute "role" "alert"
      , style <| display :: [("text-align", "center")]
      ]
      [ button
        [ type' "button"
        , class "close"
        , attribute "data-dismiss" "alert"
        , attribute "aria-label" "Close"
        ]
        [ span [ attribute "aria-hidden" "true" ] [ text "x" ] ]
      , text msg
      ]


viewStepHeader : Model -> Html Msg
viewStepHeader { pomodoroStep, timer } =
  div [ class "row" ]
    [ h1 [ style [("text-align", "center")] ] [ text <| toString pomodoroStep ]
    , h2 [ style [("text-align", "center")] ]
      [ text <| format timerFormat <| fromTime timer ]
    ]


viewControlBottons : Model -> Html Msg
viewControlBottons model =
  let
    currentStep = model.pomodoroStep
  in
    div
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
