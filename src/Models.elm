module Models exposing (..)

import Pomodoro.Models as PMo


type alias Alert =
  { message : String
  , ofType: String
  }


type alias Model =
  { pomodoro : PMo.Model
  , showAlert : Bool
  , alert : Maybe Alert
  , allowNotifications : Bool
  }

model : Model
model =
  { pomodoro = PMo.model
  , showAlert = False
  , alert = Nothing
  , allowNotifications = False
  }
