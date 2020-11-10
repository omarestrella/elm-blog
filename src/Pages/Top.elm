module Pages.Top exposing (Model, Msg, Params, page)

import Api
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Http
import Models
import Shared
import Spa.Document exposing (Document)
import Spa.Generated.Route as Route
import Spa.Page as Page exposing (Page)
import Spa.Url exposing (Url)


type alias Params =
    ()


type alias Model =
    {}


type Msg
    = Never


init : Url Params -> ( Model, Cmd Msg )
init _ =
    ( {}, Cmd.none )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    ( model, Cmd.none )


page : Page Params Model Msg
page =
    Page.element
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Home"
    , body =
        [ h1 [] [ text "Welcome to my blog!" ]
        ]
    }
