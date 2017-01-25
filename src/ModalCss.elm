module ModalCss exposing (..)

import Css exposing (..)

type CssClasses
    = ShowModalCss
    | DiyalogModal
    | ModalBackground
    | HideModalCss
    | ModalContent
    | ModalHeader
    | ModalHeaderTitle
    | ModalBody
    | ModalFooter
    | CloseCss

type Animations = AnimateTop

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
          , backgroundColor (hex "fff")
          , opacity (num 0.6)
          ]
    , (.) ModalContent
          [ position relative
          , backgroundColor (hex "fefefe")
          , margin auto
          , padding (px 0)
          , border3 (px 1) solid (hex "888")
          , width (pct 50)
          , boxShadow5 (px 0) (px 4) (px 8) (px 0) (rgba 0 0 0 0.2)
          , boxShadow5 (px 0) (px 6) (px 20) (px 0) (rgba 0 0 0 0.19)
          , animationName AnimateTop
          , animationDuration 0.4
          ]
    , (.) CloseCss
          [ color (hex "aaa")
          , float right
          , fontSize (px 20)
          , fontWeight bold
          , border2 (px 1) none
          , backgroundColor (hex "fff")
          , hover [ color (hex "000")
                  , textDecoration none
                  , cursor pointer ] 
          , focus [ color (hex "000")
                  , textDecoration none
                  , cursor pointer ]
          ]
    , (.) ModalHeader
          [ padding2 (px 2) (px 16)
          , backgroundColor (hex "fff")
          , color (hex "000") 
          , height (px 40)
          , borderBottom2 (px 1) groove
          ]
    , (.) ModalHeaderTitle
          [ fontSize (px 20)
          , fontWeight bold
          , paddingTop (px 5) ]
    , (.) ModalBody
          [ padding2 (px 2) (px 16) ]
    , (.) ModalFooter
          [ padding2 (px 2) (px 16)
          , backgroundColor (hex "5cb85c")
          , color (hex "fff")
          , height (px 40)
          ]
    ]

basicCss : Mixin
basicCss = 
    mixin
        [ position fixed
        , fontFamilies ["Helvetica"]
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

animationName : Animations -> Mixin
animationName animation =
    let params = String.toLower <| toString animation
    in
        mixin
          [ property "animation-name" <| params
          , property "-webkit-animation-name" <| params 
          , property "-moz-animation-name" <| params ]

animationDuration : Float -> Mixin
animationDuration num =
    let params = toString num ++ "s"
    in
        mixin
          [ property "animation-duration" <| params
          , property "-webkit-animation-duration" <| params
          , property "-moz-animation-duration" <| params ]
