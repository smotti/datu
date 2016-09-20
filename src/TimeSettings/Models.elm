module TimeSettings.Models exposing (..)

import Time exposing (Time, minute)


type alias Model =
  { pomodoroTime : Time
  , shortBreakTime : Time
  , longBreakTime : Time
  , viewSettings : Bool
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


defaultSettings : Model
defaultSettings =
  { pomodoroTime = defaultPomodoroTime
  , shortBreakTime = defaultShortBreakTime
  , longBreakTime = defaultLongBreakTime
  , viewSettings = False
  }
