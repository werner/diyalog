module Diyalog exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on, onClick, targetValue)

import Animation exposing (px)

import Styles exposing (..)

type Msg = OkModal
         | CloseModal
         | Animate Animation.Msg

type ModalVisibility = ShowModal
                     | HideModal

type alias Model = { style      : Animation.State
                   , visibility : ModalVisibility }

view : Model -> Html Msg
view model = 
    div [] [ button [ id "my-btn"
                    , onClick OkModal ]
                    [ text "Open Modal" ]
           , div [ id "diyalog-modal"
                 , modalVisibility model.visibility ]
                 [ div [ modalBackground
                       , onClick CloseModal ] []
                 , div ( Animation.render model.style ++ 
                                    [ modalContent
                                    , id "modal-content" ]
                       )
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
            ( { model | style =
                            Animation.interrupt
                                [ Animation.to 
                                    [ Animation.top (px -50.0)
                                    , Animation.opacity 0.0
                                    ]
                                , Animation.to
                                    [ Animation.top (px 20.0)
                                    , Animation.opacity 1.0
                                    ]
                                ]
                                model.style
                      , visibility = ShowModal }, Cmd.none )
        CloseModal ->
            ( { model | style = Animation.style
                                [ Animation.top (px -50.0)
                                , Animation.opacity 0.0 ]
                      , visibility = HideModal }, Cmd.none )
        Animate animMsg ->
            ( { model | style = Animation.update animMsg model.style }, Cmd.none )

subscriptions : Model -> Sub Msg
subscriptions model =
    Animation.subscription Animate [ model.style ]

main : Program Never Model Msg
main =
    program
        {
          init = ( { style = Animation.style
                                [ Animation.top (px -50.0)
                                , Animation.opacity 0.0 ]
                   , visibility = HideModal }, Cmd.none )
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
