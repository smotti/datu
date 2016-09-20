module Models exposing (..)

import Time exposing (Time)
import TimeSettings.Models as TSMo


type PomodoroStep
  = Pomodoro
  | ShortBreak
  | LongBreak


type alias Alert =
  { message : String
  , ofType: String
  }


type alias Model =
  { timeSettings : TSMo.Model
  , timer : Time
  , pomodoroStep : PomodoroStep
  , timerEnabled : Bool
  , showAlert : Bool
  , alert : Maybe Alert
  , allowNotifications : Bool
  }


type alias Notifications =
  { pomodoro : String
  , shortBreak : String
  , longBreak : String
  }


notifications : Notifications
notifications =
  { pomodoro = "Time is up. Take a break."
  , shortBreak = "Time is up. Back to work."
  , longBreak = "Dude wake up! Time to get back to work."
  }


model : Model
model =
  { timeSettings = TSMo.defaultSettings
  , timer = TSMo.defaultPomodoroTime
  , pomodoroStep = Pomodoro
  , timerEnabled = False
  , showAlert = False
  , alert = Nothing
  , allowNotifications = False
  }


getStepTime : Model -> Time
getStepTime model =
  case model.pomodoroStep of
    Pomodoro -> model.timeSettings.pomodoroTime
    ShortBreak -> model.timeSettings.shortBreakTime
    LongBreak -> model.timeSettings.longBreakTime
