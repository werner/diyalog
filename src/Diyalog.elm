module Diyalog exposing (..)

import Html exposing (..)
import Html.Attributes as Attr exposing (..)
import Html.Events exposing (onClick)
import Html.CssHelpers exposing (withNamespace)

import ModalCss exposing (..)

{ id, class, classList } =
    Html.CssHelpers.withNamespace "modal"

type Msg = OkModal
         | HideModal

type alias Model = { visibility : CssClasses }

view model = 
    div [] [ button [ Attr.id "myBtn"
                    , onClick OkModal ]
                    [ text "Open Modal" ]
           , div [ Attr.id "myModal" 
                 , onClick HideModal
                 , class [ model.visibility ] ]
                 [ div [ class [ ModalContent ] ]
                       [ button [ class [ CloseCss ] 
                                , onClick HideModal  ] 
                                [ text "&times;" ]
                       , p [] [ text "My Modal" ] 
                       ]
                 ]
           ]

update msg model =
    case msg of
        OkModal ->
            { model | visibility = ShowModalCss }
        HideModal ->
            { model | visibility = HideModalCss }

main =
    beginnerProgram
        {
          model = { visibility = HideModalCss }
        , view = view
        , update = update
        }
      
