module Styles.Global exposing (..)

import Css exposing (..)


body =
    Css.batch
        [ fontFamilies [ "Helvetica Neue", "Helvetica", "Arial", "sans-serif" ]
        , margin (px 20)
        ]


navigation =
    Css.batch [ displayFlex ]


navigationLink =
    Css.batch [ color (rgb 0 100 200), textDecoration underline, marginRight (px 20) ]
