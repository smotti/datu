module Pomodoro.Update exposing (update)

import Pomodoro.Commands exposing (showNotification)
import Pomodoro.Messages exposing (..)
import Pomodoro.Models exposing (..)
import Time exposing (second)
import TimeSettings.Update as TSU


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
