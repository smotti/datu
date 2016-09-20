module Pomodoro.Commands exposing (..)

import Pomodoro.Messages exposing(Msg)
import Pomodoro.Models exposing(PomodoroStep(..))
import Notification exposing(notification, notifications)


showNotification : PomodoroStep -> Cmd Msg
showNotification step =
  case step of
    Pomodoro -> notification notifications.pomodoro
    ShortBreak -> notification notifications.shortBreak
    LongBreak -> notification notifications.longBreak
