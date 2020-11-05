module Pages.Post.Id_String exposing (Model, Msg, Params, page)

import Api
import Components.Loader as Loader
import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, src)
import Http
import Models
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)


page : Page Params Model Msg
page =
    Page.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- INIT


type alias Params =
    { id : String }


type Post
    = Loading
    | Loaded Models.Post
    | Error


type alias Model =
    { post : Post }


init : Url Params -> ( Model, Cmd Msg )
init { params } =
    ( { post = Loading }, loadPost params.id )



-- UPDATE


type Msg
    = ReplaceMe
    | LoadedPost (Result Http.Error Models.Post)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReplaceMe ->
            ( model, Cmd.none )

        LoadedPost result ->
            case result of
                Ok post ->
                    ( { model | post = Loaded post }, Cmd.none )

                Err err ->
                    ( { model | post = Error }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


loadPost : String -> Cmd Msg
loadPost id =
    Api.getPost id LoadedPost



-- VIEW


postView : Model -> Html Msg
postView model =
    case model.post of
        Loading ->
            Loader.element

        Loaded post ->
            div []
                [ h2 []
                    [ text post.title ]
                , p []
                    [ text post.body ]
                ]

        Error ->
            div [ css [ width (pct 100), displayFlex, alignItems center, flexDirection column ] ]
                [ p []
                    [ span [] [ text "Welp. " ]
                    , span [ css [ fontWeight bolder ] ] [ text "SOMEONE " ]
                    , span [] [ text "broke something." ]
                    ]
                , div []
                    [ img [ src "https://media.giphy.com/media/LPB950a64mBWy7G72n/giphy.gif" ] [] ]
                ]


view : Model -> Document Msg
view model =
    { title = "Post.Id_String"
    , body = [ postView model ]
    }
