module Datu exposing (main)

import Html.App as App
import Messages exposing (Msg)
import Models exposing (Model, model)
import Update exposing (subscriptions, update)
import View exposing (view)


init : (Model, Cmd Msg)
init =
    (model, Cmd.none)


main =
  App.program
    { init = init
    , update = update
    , view = view
    , subscriptions = subscriptions
    }
