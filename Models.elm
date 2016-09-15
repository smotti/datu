module Models exposing (..)

import Time exposing (Time, minute)


type PomodoroStep
  = Pomodoro
  | ShortBreak
  | LongBreak


type alias Model =
  { showSettings : Bool
  , pomodoroTime : Time
  , shortBreakTime : Time
  , longBreakTime : Time
  , timer : Time
  , pomodoroStep : PomodoroStep
  , timerEnabled : Bool
  }


model : Model
model =
  { showSettings = False
  , pomodoroTime = 25 * minute
  , shortBreakTime = 5 * minute
  , longBreakTime = 25 * minute
  , timer = 0
  , pomodoroStep = Pomodoro
  , timerEnabled = False
  }
