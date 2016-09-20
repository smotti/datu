module View exposing (..)

import Debug
import Html exposing (Attribute, Html, button, div, span, text)
import Html.App as App
import Html.Attributes exposing (attribute, class, style, type')
import Messages exposing (..)
import Models exposing (Model)
import Pomodoro.View exposing (viewPomodoro)
import Update exposing (..)


view : Model -> Html Msg
view model =
  div [ class "container-fluid" ]
    [ (viewAlert model)
    , App.map PomodoroMsg (viewPomodoro model.pomodoro)
    , text <| toString model
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
