module ModalCss exposing (..)

import Css exposing (..)

type CssClasses
    = ShowModalCss
    | DiyalogModal
    | ModalBackground
    | HideModalCss
    | ModalContent
    | ModalHeader
    | ModalBody
    | ModalFooter
    | CloseCss

css : Stylesheet
css = 
    stylesheet
    [ (.) ShowModalCss
          [ display block 
          , basicCss
          ]
    , (.) HideModalCss
          [ display none
          , basicCss
          ]
    , (.) ModalBackground
          [ position fixed
          , zIndex -1
          , width (pct 100)
          , height (pct 100)
          , backgroundColor (rgb 0 0 0)
          , backgroundColor (rgba 0 0 0 0.4) 
          ]
    , (.) ModalContent
          [ position relative
          , backgroundColor (hex "fefefe")
          , margin auto
          , padding (px 0)
          , border3 (px 1) solid (hex "888")
          , width (pct 80)
          , boxShadow5 (px 0) (px 4) (px 8) (px 0) (rgba 0 0 0 0.2)
          , boxShadow5 (px 0) (px 6) (px 20) (px 0) (rgba 0 0 0 0.19)
          ]
    , (.) CloseCss
          [ color (hex "aaa")
          , float right
          , fontSize (px 28)
          , fontWeight bold
          , hover [ color (hex "000")
                  , textDecoration none
                  , cursor pointer ] 
          , focus [ color (hex "000")
                  , textDecoration none
                  , cursor pointer ]
          ]
    , (.) ModalHeader
          [ padding2 (px 2) (px 16)
          , backgroundColor (hex "5cb85c")
          , color (hex "fff") 
          ]
    , (.) ModalBody
          [ padding2 (px 2) (px 16) ]
    , (.) ModalFooter
          [ padding2 (px 2) (px 16)
          , backgroundColor (hex "5cb85c")
          , color (hex "fff")
          ]
    ]

basicCss : Mixin
basicCss = 
    mixin
        [ position fixed
        , zIndex 1
        , left (px 0)
        , top (px 0)
        , width (pct 100)
        , height (pct 100)
        , overflow auto
        ]

zIndex : Int -> Mixin
zIndex i =
    property "z-index" <| toString i
