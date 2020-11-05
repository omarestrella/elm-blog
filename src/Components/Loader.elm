module Components.Loader exposing (..)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (class, css)


style : Style
style =
    Css.batch
        [ width (pct 100)
        , height (pct 100)
        , minHeight (px 400)
        , displayFlex
        , alignItems center
        , justifyContent center
        ]


element : Html msg
element =
    div [ css [ style ] ]
        [ div
            [ class "lds-roller" ]
            [ div [] []
            , div [] []
            , div [] []
            , div [] []
            , div [] []
            , div [] []
            , div [] []
            , div [] []
            ]
        ]
