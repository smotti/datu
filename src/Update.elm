module Update exposing (..)

import Alert exposing (alert)
import Commands exposing (showNotification)
import Debug
import Messages exposing (..)
import Models exposing (..)
import Notification exposing (permission)
import Time exposing (second)
import TimeSettings.Subscriptions as TSS
import TimeSettings.Update as TSU


subscriptions : Model -> Sub Msg
subscriptions { timeSettings, timerEnabled } =
  Sub.batch
    [ if timerEnabled then Time.every second Tick else Sub.none
    , alert ShowAlert
    , permission AllowNotifications
    , Sub.map TimeSettingsMsg <| TSS.subscriptions timeSettings
    ]


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Do step ->
      let
        time = getStepTime { model | pomodoroStep = step }
      in
        ( { model | pomodoroStep = step
                  , timer = time
                  , timerEnabled = False
          }
        , Cmd.none
        )

    StartTimer ->
      ( { model | timerEnabled = True } , Cmd.none )

    StopTimer ->
      let
        time = getStepTime model
      in
        ( { model | timer = time
                  , timerEnabled = False
          }
        , Cmd.none
        )

    Tick _ ->
      let
        newTimer =
          if not (model.timer <= 0) then
            model.timer - second
          else
            model.timer
        stepTime =
          getStepTime model
        mustStop =
          if model.timer <= 0 then True else False
        cmd =
          if mustStop then
            showNotification model.pomodoroStep
          else
            Cmd.none
      in
        ( { model | timer = if not mustStop then newTimer else stepTime
                  , timerEnabled = not mustStop
          }
        , cmd
        )

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

    TimeSettingsMsg tsMsg ->
      let
        ( newTimeSettings, cmd ) =
          TSU.update tsMsg model.timeSettings
        newTimer =
          case model.pomodoroStep of
            LongBreak -> newTimeSettings.longBreakTime
            Pomodoro -> newTimeSettings.pomodoroTime
            ShortBreak -> newTimeSettings.shortBreakTime
      in
        ( if model.timerEnabled then
            { model | timeSettings = newTimeSettings }
          else
            { model | timeSettings = newTimeSettings, timer = newTimer }
        , Cmd.map TimeSettingsMsg cmd
        )
