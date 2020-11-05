module Models exposing (..)

import Json.Decode as Decode exposing (Decoder, string)
import Json.Decode.Pipeline exposing (required)


type alias Post =
    { id : String
    , title : String
    , body : String
    }


type alias Comment =
    { id : String
    , postId : String
    , name : String
    , body : String
    }


postDecoder : Decoder Post
postDecoder =
    Decode.succeed Post
        |> required "id" string
        |> required "title" string
        |> required "body" string


commentDecoder : Decoder Comment
commentDecoder =
    Decode.succeed Comment
        |> required "id" string
        |> required "postId" string
        |> required "name" string
        |> required "body" string
