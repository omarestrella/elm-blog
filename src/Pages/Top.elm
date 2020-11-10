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
    { posts : List Models.Post }


type Msg
    = LoadedPosts (Result Http.Error (List Models.Post))


init : Url Params -> ( Model, Cmd Msg )
init _ =
    ( { posts = [] }, Api.getPosts LoadedPosts )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        LoadedPosts result ->
            case result of
                Ok posts ->
                    ( { model | posts = posts }, Cmd.none )

                Err _ ->
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


postView : Models.Post -> Html Msg
postView post =
    div []
        [ h3 []
            [ a [ href "#" ]
                [ text post.title ]
            ]
        ]


postsList : Model -> Html Msg
postsList model =
    div []
        (List.map postView model.posts)


view : Model -> Document Msg
view model =
    { title = "Home"
    , body =
        [ h1 [] [ text "Welcome to my blog!" ]
        , postsList model
        ]
    }
