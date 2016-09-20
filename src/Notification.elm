port module Notification exposing (..)


port permission : (String -> msg) -> Sub msg
port notification : String -> Cmd msg

-- TODO: Refactor. This means move things related to notification into this
--       module. Like the update part (AllowNotification), maybe even the commands parts.
