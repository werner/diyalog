module ModalCss exposing (..)

import Css exposing (..)
import Css.Elements exposing (input, label)
import Css.Namespace exposing (namespace)

type CssClasses
    = ShowModalCss
    | HideModalCss
    | ModalContent
    | CloseCss

zIndex : Int -> Mixin
zIndex i =
    property "z-index" <| toString i

css : Stylesheet
css = 
    (stylesheet << namespace "modal")
    [ (.) ShowModalCss
          [ display block 
          , basicCss
          ]
    , (.) HideModalCss
          [ display none
          , basicCss
          ]
    , (.) ModalContent
          [ backgroundColor (hex "fefefe")
          , margin2 (pct 15) auto
          , padding (px 20)
          , border3 (px 1) solid (hex "888")
          , width (pct 80) ]
    , (.) CloseCss
          [ color (hex "aaa")
          , float right
          , fontSize (px 28)
          , fontWeight bold
          , hover [ color (hex "ffffff")
                  , textDecoration none
                  , cursor pointer ] 
          , focus [ color (hex "ffffff")
                  , textDecoration none
                  , cursor pointer ]
          ]
    ]

basicCss = 
    mixin
        [ position fixed
        , zIndex 1
        , left (px 0)
        , top (px 0)
        , width (pct 100)
        , height (pct 100)
        , overflow auto
        , backgroundColor (rgb 0 0 0)
        , backgroundColor (rgba 0 0 0 0.4) 
        ]
