module Commands exposing (..)

import Messages exposing(Msg)
import Models exposing(notifications, PomodoroStep(..))
import Notification exposing(notification)


showNotification : PomodoroStep -> Cmd Msg
showNotification step =
  case step of
    Pomodoro -> notification notifications.pomodoro
    ShortBreak -> notification notifications.shortBreak
    LongBreak -> notification notifications.longBreak
