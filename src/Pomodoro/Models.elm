module Pomodoro.Models exposing (..)

import Time exposing (Time)
import TimeSettings.Models as TSMo


type PomodoroStep
  = Pomodoro
  | ShortBreak
  | LongBreak


type alias Model =
  { timeSettings : TSMo.Model
  , timer : Time
  , timerEnabled : Bool
  , pomodoroStep : PomodoroStep
  }


model : Model
model =
  { timeSettings = TSMo.defaultSettings
  , timer = TSMo.defaultPomodoroTime
  , timerEnabled = False
  , pomodoroStep = Pomodoro
  }


getStepTime : Model -> Time
getStepTime model =
  case model.pomodoroStep of
    Pomodoro -> model.timeSettings.pomodoroTime
    ShortBreak -> model.timeSettings.shortBreakTime
    LongBreak -> model.timeSettings.longBreakTime
