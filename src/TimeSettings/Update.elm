module TimeSettings.Update exposing (update)

import String
import Time exposing (Time, minute)
import TimeSettings.Messages exposing (Msg(..))
import TimeSettings.Models exposing (..)
import TimeSettings.Ports exposing (addEventListeners)


jsTimeToFloat : String -> Time -> Float
jsTimeToFloat time defaultTime =
  case String.toFloat time of
    Ok t -> t * minute
    Err _ -> defaultTime


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    InputLongBreakTime newTime ->
      let
        timeAsFloat = jsTimeToFloat newTime defaultLongBreakTime
      in
        ( { model | longBreakTime = timeAsFloat }, Cmd.none )

    InputPomodoroTime newTime ->
      let
        timeAsFloat = jsTimeToFloat newTime defaultPomodoroTime
      in
        ( { model | pomodoroTime = timeAsFloat }, Cmd.none )

    InputShortBreakTime newTime ->
      let
        timeAsFloat = jsTimeToFloat newTime defaultShortBreakTime
      in
        ( { model | shortBreakTime = timeAsFloat }, Cmd.none )

    ToggleSettingsView ->
      let
        viewSettings =
          if model.viewSettings then False else True
        cmd =
          if viewSettings then
            addEventListeners True
          else
            Cmd.none
      in
        ( { model | viewSettings =  viewSettings }
        , cmd
        )
