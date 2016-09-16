module Update exposing (..)

import Messages exposing (..)
import Models exposing (Model, PomodoroStep(..))
import Time exposing (Time, second)


subscriptions : Model -> Sub Msg
subscriptions { timerEnabled } =
  if timerEnabled then
    Time.every second Tick
  else
    Sub.none


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Do step ->
      let
        time =
          case step of
            Pomodoro -> model.pomodoroTime
            ShortBreak -> model.shortBreakTime
            LongBreak -> model.longBreakTime
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
        time =
          case model.pomodoroStep of
            Pomodoro -> model.pomodoroTime
            ShortBreak -> model.shortBreakTime
            LongBreak -> model.longBreakTime
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
        mustStop =
          if model.timer <= 0 then
            True
          else
            False
      in
        -- TODO: Send notification when times up
        ( { model | timer = newTimer
                  , timerEnabled = not mustStop
          }
        , Cmd.none
        )
