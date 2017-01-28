module Styles exposing (..)

import Html exposing (Attribute)
import Html.Attributes exposing (style)

basicCss : List ( String, String )
basicCss = [ ("position", "fixed")
           , ("font-family", "Helvetica")
           , ("z-index", "1")
           , ("left", "0px")
           , ("width", "100%")
           , ("height", "100%")
           , ("overlow", "auto") ]

modalShow : Attribute msg
modalShow = 
    style <|
     [ ("display", "block")
     ] ++ basicCss

modalHide : Attribute msg
modalHide = 
    style <|
     [ ("display", "none")
     ] ++ basicCss

modalBackground : Attribute msg
modalBackground = 
    style
      [ ("position", "fixed") 
      , ("z-index", "-1")
      , ("top", "0px")
      , ("width", "100%")
      , ("height", "100%")
      , ("background-color", "#fff")
      , ("opacity", "0.6")
      ]

modalContent : Attribute msg
modalContent = 
    style
      [ ("position", "relative")
      , ("background-color", "#fefefe")
      , ("margin", "auto")
      , ("padding", "0px")
      , ("border", "1px solid #888")
      , ("width", "50%")
      , ("box-shadow", "0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19)")
      , ("-webkit-animation-name", "animatetop")
      , ("-webkit-animation-duration", "0.4s")
      , ("-moz-animation-name", "animatetop")
      , ("-moz-animation-duration", "0.4s")
      , ("animation-name", "animatetop")
      , ("animation-duration", "0.4s") ]

modalHeader : Attribute msg
modalHeader = 
    style
      [ ("padding", "2px 16px")
      , ("background-color", "#fff")
      , ("color", "#000")
      , ("height", "40px")
      , ("border-bottom", "1px groove") ]

modalHeaderTitle : Attribute msg
modalHeaderTitle = 
    style
      [ ("font-size", "20px")
      , ("font-weight", "bold")
      , ("padding-top", "5px") ]

modalBody : Attribute msg
modalBody = 
    style
      [ ("padding", "2px 16px") ]

modalFooter : Attribute msg
modalFooter = 
    style
      [ ("padding", "2px 16px") 
      , ("background-color", "#fff")
      , ("color", "#000")
      , ("height", "40px")
      , ("border-top", "1px groove") ]

closeCss : Attribute msg
closeCss = 
    style
      [ ("color", "#aaa")
      , ("float", "right")
      , ("font-size", "20px")
      , ("font-weight", "bold")
      , ("border", "1px none")
      , ("background-color", "#fff")
      , ("cursor", "pointer") ]

footerButtonClose : Attribute msg
footerButtonClose =
    style <|
      [ ("background-image", "none")
      , ("color", "#d9534f")
      , ("background-color", "transparent")
      , ("border-color", "#d9534f") ] ++ basicButton

footerButtonOk : Attribute msg
footerButtonOk =
    style <|
      [ ("background-image", "none")
      , ("color", "#5cb85c")
      , ("background-color", "transparent")
      , ("border-color", "#5cb85c") ] ++ basicButton

basicButton : List ( String, String )
basicButton = [ ("display", "inline-block")
              , ("text-align", "center") 
              , ("white-space", "nowrap")
              , ("vertical-align", "middle")
              , ("border", "1px solid")
              , ("padding", "0.5rem 1rem")
              , ("border-radius", "0.25rem")
              , ("cursor", "pointer")
              , ("margin-left", "10px")
              , ("transition", "all .2s ease-in-out")]

actionsGroup : Attribute msg
actionsGroup =
    style
      [ ("float", "right") ]
