module Pomodoro.Subscriptions exposing (subscriptions)

import Pomodoro.Messages exposing (Msg(..))
import Pomodoro.Models exposing (Model)
import Time exposing (every, second)
import TimeSettings.Subscriptions as TSS


subscriptions : Model -> Sub Msg
subscriptions { timeSettings, timerEnabled } =
  Sub.batch
    [ if timerEnabled then every second Tick else Sub.none
    , Sub.map TimeSettingsMsg <| TSS.subscriptions timeSettings
    ]
