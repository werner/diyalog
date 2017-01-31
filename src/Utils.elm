module Utils exposing (..)

import Html exposing (..)
import Html.Attributes exposing (map)
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

setFullHeader : (Msg -> msg) -> String -> Html msg
setFullHeader msg header = 
    div [ modalHeader ]
        [ button [ closeCss 
                 , Html.Attributes.map msg <| onClick CloseModal ] 
                 [ text "x" ]
         , div [ modalHeaderTitle ] 
               [ text header ] 
         ]

setFullBody : Html msg -> Html msg
setFullBody body =
    div [ modalBody ]
        [ body ]

setFullFooter : (Msg -> msg) -> Html msg
setFullFooter msg = 
    div [ modalFooter ]
        [ div [ actionsGroup ]
              [ button [ footerButtonClose
                       , Html.Attributes.map msg <| onClick CloseModal ]
                       [ text "Close" ]
              , button [ footerButtonOk 
                       , Html.Attributes.map msg <| onClick OkModal ] 
                       [ text "Ok" ] ]
        ]
