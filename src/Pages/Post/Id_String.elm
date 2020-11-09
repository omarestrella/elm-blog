module Pages.Post.Id_String exposing (Model, Msg, Params, page)

import Api
import Components.Loader as Loader
import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, src)
import Http
import Models exposing (Comment)
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
    = LoadingPost
    | LoadedPost Models.Post
    | Error


type Comments
    = LoadingComments
    | LoadedComments (List Models.Comment)


type alias Model =
    { post : Post
    , comments : Comments
    }


init : Url Params -> ( Model, Cmd Msg )
init { params } =
    ( { post = LoadingPost
      , comments = LoadingComments
      }
    , Cmd.batch [ loadPost params.id, loadComments params.id ]
    )



-- UPDATE


type Msg
    = ReplaceMe
    | GotPost (Result Http.Error Models.Post)
    | GotComments (Result Http.Error (List Models.Comment))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReplaceMe ->
            ( model, Cmd.none )

        GotPost result ->
            case result of
                Ok post ->
                    ( { model | post = LoadedPost post }, Cmd.none )

                Err err ->
                    ( { model | post = Error }, Cmd.none )

        GotComments result ->
            case result of
                Ok comments ->
                    ( { model | comments = LoadedComments comments }, Cmd.none )

                Err _ ->
                    ( { model | comments = LoadedComments [] }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


loadPost : String -> Cmd Msg
loadPost id =
    Api.getPost id GotPost


loadComments : String -> Cmd Msg
loadComments id =
    Api.getComments id GotComments



-- VIEW


commentView : Comment -> Html Msg
commentView comment =
    div []
        [ h5 [] [ text comment.name ]
        , p [] [ text comment.body ]
        ]


commentsView : Comments -> Html Msg
commentsView comments =
    case comments of
        LoadingComments ->
            Loader.element

        LoadedComments postComments ->
            div []
                (List.map commentView postComments)


postView : Model -> Html Msg
postView model =
    case model.post of
        LoadingPost ->
            Loader.element

        LoadedPost post ->
            div []
                [ h2 []
                    [ text post.title ]
                , p []
                    [ text post.body ]
                , div []
                    [ h3 []
                        [ text "Comments" ]
                    , commentsView model.comments
                    ]
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
