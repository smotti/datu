module TimeSettings.Messages exposing (..)


type Msg
  = InputLongBreakTime String
  | InputPomodoroTime String
  | InputShortBreakTime String
  | ToggleSettingsView
