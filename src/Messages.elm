module Messages exposing (..)

import Pomodoro.Messages as PM
import Time exposing (Time)


type Msg
  = PomodoroMsg PM.Msg
  | ShowAlert (String, String)
  | AllowNotifications String
