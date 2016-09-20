module Update exposing (..)

import Alert exposing (alert)
import Commands exposing (showNotification)
import Debug
import Messages exposing (..)
import Models exposing (Model, PomodoroStep(..), getStepTime)
import Notification exposing (permission)
import Time exposing (Time, second)


subscriptions : Model -> Sub Msg
subscriptions { timerEnabled } =
  Sub.batch
    [ if timerEnabled then Time.every second Tick else Sub.none
    , alert ShowAlert
    , permission AllowNotifications
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

    ToggleTimerSettings ->
      ( { model | showSettings = if model.showSettings then False else True }
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
