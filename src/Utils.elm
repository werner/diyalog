module Utils exposing (..)

import Html exposing (..)
import Html.Events exposing (on, onClick, targetValue)

import Diyalog.Message exposing (..)
import Styles  exposing (..)

type ModalVisibility = ShowModal
                     | HideModal

modalVisibility : ModalVisibility -> Attribute msg
modalVisibility visibility =
    case visibility of
        ShowModal ->
            modalShow
        HideModal ->
            modalHide

setFullHeader : String -> Html Msg
setFullHeader header = 
    div [ modalHeader ]
        [ button [ closeCss 
                 , onClick CloseModal ] 
                 [ text "x" ]
         , div [ modalHeaderTitle ] 
               [ text header ] 
         ]

setFullBody : Html Msg -> Html Msg
setFullBody body =
    div [ modalBody ]
        [ body ]

setFullFooter : Html Msg
setFullFooter = 
    div [ modalFooter ]
        [ div [ actionsGroup ]
              [ button [ footerButtonClose
                       , onClick CloseModal ]
                       [ text "Close" ]
              , button [ footerButtonOk 
                       , onClick OkModal ] 
                       [ text "Ok" ] ]
        ]
