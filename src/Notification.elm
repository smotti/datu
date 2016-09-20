port module Notification exposing (..)


port permission : (String -> msg) -> Sub msg
port notification : String -> Cmd msg

-- TODO: Refactor. This means move things related to notification into this
--       module. Like the update part (AllowNotification), maybe even the commands parts.

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
