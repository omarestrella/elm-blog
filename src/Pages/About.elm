module Pages.About exposing (Model, Msg, Params, page)

import Html.Styled exposing (..)
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)


page : Page Params Model Msg
page =
    Page.static
        { view = view
        }


type alias Model =
    Url Params


type alias Msg =
    Never



-- VIEW


type alias Params =
    ()


view : Url Params -> Document Msg
view { params } =
    { title = "About"
    , body =
        [ div []
            [ h1 [] [ text "My Blog" ]
            , p [] [ text "There are many blogs out there, but this one is mine." ]
            ]
        ]
    }
