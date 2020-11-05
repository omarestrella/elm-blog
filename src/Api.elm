module Api exposing (..)

import Http
import Json.Decode as Decode
import Models exposing (Post)
import Url.Builder as Url


getPost : String -> (Result Http.Error Post -> msg) -> Cmd msg
getPost id msg =
    let
        url =
            Url.absolute [ "api", "posts", id ] []
    in
    Http.get
        { url = url
        , expect = Http.expectJson msg (Decode.at [ "post" ] Models.postDecoder)
        }


getPosts : (Result Http.Error (List Post) -> msg) -> Cmd msg
getPosts msg =
    let
        url =
            Url.absolute [ "api", "posts" ] []
    in
    Http.get
        { url = url
        , expect = Http.expectJson msg (Decode.at [ "posts" ] (Decode.list Models.postDecoder))
        }
