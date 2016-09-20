module Update exposing (..)

import Alert exposing (alert)
import Commands exposing (showNotification)
import Debug
import Messages exposing (..)
import Models exposing (..)
import Notification exposing (permission)
import Result exposing (withDefault)
import String
import Time exposing (Time, minute, second)
import TimeSettings exposing (..)


jsTimeToFloat : String -> Time -> Float
jsTimeToFloat time defaultTime =
  case String.toFloat time of
    Ok t -> t * minute
    Err _ -> defaultTime


subscriptions : Model -> Sub Msg
subscriptions { timerEnabled } =
  Sub.batch
    [ if timerEnabled then Time.every second Tick else Sub.none
    , alert ShowAlert
    , permission AllowNotifications
    , pomodoroTime InputPomodoroTime
    , shortBreakTime InputShortBreakTime
    , longBreakTime InputLongBreakTime
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

    ToggleTimerSettings ->
      let
        showSettings =
          if model.showSettings then False else True
        cmd =
          if showSettings then
            addEventListeners True
          else
            Cmd.none
      in
        ( { model | showSettings =  showSettings }
        , cmd
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

    InputPomodoroTime newTime ->
      let
        timeAsFloat = jsTimeToFloat newTime defaultPomodoroTime
      in
        ( { model | pomodoroTime = timeAsFloat, timer = timeAsFloat }, Cmd.none )

    InputShortBreakTime newTime ->
      let
        timeAsFloat = jsTimeToFloat newTime defaultShortBreakTime
      in
        ( { model | shortBreakTime = timeAsFloat, timer = timeAsFloat }, Cmd.none )

    InputLongBreakTime newTime ->
      let
        timeAsFloat = jsTimeToFloat newTime defaultLongBreakTime
      in
        ( { model | longBreakTime = timeAsFloat, timer = timeAsFloat }, Cmd.none )
