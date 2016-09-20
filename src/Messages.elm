module Messages exposing (..)

import Models exposing (PomodoroStep)
import Time exposing (Time)


type Msg
  = ToggleTimerSettings
  | Tick Time
  | StartTimer
  | StopTimer
  | Do PomodoroStep
  | ShowAlert (String, String)
  | AllowNotifications String
  | InputPomodoroTime String
  | InputShortBreakTime String
  | InputLongBreakTime String
