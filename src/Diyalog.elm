module Diyalog exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on, onClick, targetValue)

import Styles exposing (..)

type Msg = OkModal
         | CloseModal

type ModalVisibility = ShowModal
                     | HideModal

type alias Model = { visibility : ModalVisibility }

view : Model -> Html Msg
view model = 
    div [] [ button [ id "my-btn"
                    , onClick OkModal ]
                    [ text "Open Modal" ]
           , div [ id "diyalog-modal" 
                 , modalVisibility model.visibility ]
                 [ div [ modalBackground
                       , onClick CloseModal ] []
                 , div [ modalContent ]
                       [ div [ modalHeader ]
                           [ button [ closeCss 
                                    , onClick CloseModal ] 
                                    [ text "x" ]
                           , div [ modalHeaderTitle ] 
                                 [ text "Modal Header" ] 
                           ]
                       , div [ modalBody ]
                             [ p [] [ text "Some Modal Body"] 
                             , p [] [ text "Some other Modal Body"] ] 
                       , div [ modalFooter ]
                             [ h3 [] [ text "Modal Footer"] ]
                       ]
                 ]
           ]

update : Msg -> Model -> ( Model, Cmd Msg)
update msg model =
    case msg of
        OkModal ->
            ( { model | visibility = ShowModal }, Cmd.none )
        CloseModal ->
            ( { model | visibility = HideModal }, Cmd.none )

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

main : Program Never Model Msg
main =
    program
        {
          init = ( { visibility = HideModal }, Cmd.none )
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

modalVisibility : ModalVisibility -> Attribute msg
modalVisibility visibility =
    case visibility of
        ShowModal ->
            modalShow
        HideModal ->
            modalHide
