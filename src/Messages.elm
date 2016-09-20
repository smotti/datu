module Messages exposing (..)

import Models exposing (PomodoroStep)
import TimeSettings.Messages as TSM
import Time exposing (Time)


type Msg
  = TimeSettingsMsg TSM.Msg
  | Tick Time
  | StartTimer
  | StopTimer
  | Do PomodoroStep
  | ShowAlert (String, String)
  | AllowNotifications String
