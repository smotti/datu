module TimeSettings.View exposing (viewSettings)


import Date exposing (fromTime)
import Date.Format exposing (format)
import Html exposing (Html, a, button, div, input, p, span)
import Html.Attributes exposing (attribute, class, href, id, style, type', value)
import Html.Events exposing (onClick)
import Time exposing (Time)
import TimeSettings.Messages exposing (Msg(..))
import TimeSettings.Models exposing (Model)


viewSettings : Model -> Html Msg
viewSettings model =
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
        , onClick ToggleSettingsView
        ] 
        [ (viewSettingsChevron model.viewSettings) ]
      ]
    -- Time settings
    , div [ class "row collapse", id "settings", style [("text-align", "center")] ]
      [ p [ class "col-xs-12 col-md-4" ]
        [ (makeInputSpinbox "pomodoroTime" model.pomodoroTime) ]
      , p [ class "col-xs-12 col-md-4" ]
        [ (makeInputSpinbox "shortBreakTime" model.shortBreakTime) ]
      , p [ class "col-xs-12 col-md-4" ]
        [ (makeInputSpinbox "longBreakTime" model.longBreakTime) ]
      ]
    ]


viewSettingsChevron : Bool -> Html Msg
viewSettingsChevron show =
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


makeInputSpinbox : String -> Time -> Html Msg
makeInputSpinbox nodeId initValue =
  div 
    [ class "spinbox"
    , id nodeId
    , attribute "data-initialize" "spinbox"
    ]
    [ input
      [ class "form-control input-mini spinbox-input"
      , type' "text"
      , value <| format "%M" <| fromTime initValue
      ] []
    , div [ class "spinbox-buttons btn-group btn-group-vertical" ]
      [ button
        [ type' "button"
        , class "btn btn-default spinbox-up btn-xs"
        ]
        [ span [ class "glyphicon glyphicon-chevron-up" ] [] ]
      , button
        [ type' "button"
        , class "btn btn-default spinbox-down btn-xs"
        ]
        [ span [ class "glyphicon glyphicon-chevron-down" ] [] ]
      ]
    ]
