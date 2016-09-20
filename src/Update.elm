module Update exposing (..)

import Alert exposing (alert)
import Debug
import Messages exposing (..)
import Models exposing (..)
import Notification exposing (permission)
import Pomodoro.Subscriptions as PS
import Pomodoro.Update as PU


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
    [ alert ShowAlert
    , permission AllowNotifications
    , Sub.map PomodoroMsg <| (PS.subscriptions model.pomodoro)
    ]


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ShowAlert (alertMsg, alertType) ->
      ( { model | showAlert = True
                , alert = Just { message = alertMsg, ofType = alertType }
        }
      , Cmd.none
      )

    AllowNotifications newPermission ->
      let
        show =
          if newPermission == "granted" then True else False
        showAlert =
          if not show then True else False
        alert =
          if showAlert then
            Just { message = "Need permission to show system notifications"
                 , ofType = "alert-warning"
                 }
          else
            Nothing
      in
        ( { model | allowNotifications = show
                  , showAlert = showAlert
                  , alert =  alert
          }
        , Cmd.none
        )

    PomodoroMsg pmsg ->
      let
        ( newPomodoro, cmd ) =
          PU.update pmsg model.pomodoro
      in
        ( { model | pomodoro = newPomodoro }, Cmd.map PomodoroMsg cmd )
