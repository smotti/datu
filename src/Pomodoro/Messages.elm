module Pomodoro.Messages exposing (..)

import Pomodoro.Models exposing(PomodoroStep(..))
import Time exposing (Time)
import TimeSettings.Messages as TSM


type Msg
  = Do PomodoroStep
  | StartTimer
  | StopTimer
  | Tick Time
  | TimeSettingsMsg TSM.Msg
