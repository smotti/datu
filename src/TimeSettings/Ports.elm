port module TimeSettings.Ports exposing (..)


port addEventListeners : Bool -> Cmd msg
port pomodoroTime : (String -> msg) -> Sub msg
port shortBreakTime : (String -> msg) -> Sub msg
port longBreakTime : (String -> msg) -> Sub msg
