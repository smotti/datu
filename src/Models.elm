module Models exposing (..)

import Time exposing (Time, minute)


type PomodoroStep
  = Pomodoro
  | ShortBreak
  | LongBreak


type alias Alert =
  { message : String
  , ofType: String
  }


type alias Model =
  { showSettings : Bool
  , pomodoroTime : Time
  , shortBreakTime : Time
  , longBreakTime : Time
  , timer : Time
  , pomodoroStep : PomodoroStep
  , timerEnabled : Bool
  , showAlert : Bool
  , alert : Maybe Alert
  , showNotifications : Bool
  }


defaultPomodoroTime : Time
defaultPomodoroTime =
  25 * minute


defaultShortBreakTime : Time
defaultShortBreakTime =
  5 * minute


defaultLongBreakTime : Time
defaultLongBreakTime =
  25 * minute


model : Model
model =
  { showSettings = False
  , pomodoroTime = defaultPomodoroTime
  , shortBreakTime = defaultShortBreakTime
  , longBreakTime = defaultLongBreakTime
  , timer = defaultPomodoroTime
  , pomodoroStep = Pomodoro
  , timerEnabled = False
  , showAlert = False
  , alert = Nothing
  , showNotifications = False
  }
