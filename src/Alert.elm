port module Alert exposing (..)


port alert : ((String, String) -> msg) -> Sub msg
