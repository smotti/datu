module TimeSettings.Subscriptions exposing (subscriptions)

import TimeSettings.Messages exposing (Msg(..))
import TimeSettings.Models exposing (Model)
import TimeSettings.Ports exposing (..)


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
    [ longBreakTime InputLongBreakTime
    , pomodoroTime InputPomodoroTime
    , shortBreakTime InputShortBreakTime
    ]
