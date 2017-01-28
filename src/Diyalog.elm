module Diyalog exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on, onClick, targetValue)

import Animation exposing (px)

import Styles exposing (..)
import Utils  exposing (..)
import Message exposing (..)

type alias Model = { style       : Animation.State
                   , body        : Html Msg
                   , headerTitle : String
                   , fullHeader  : (String -> Html Msg)
                   , fullBody    : (Html Msg -> Html Msg)
                   , fullFooter  : Html Msg
                   , visibility  : ModalVisibility }

view : Model -> Html Msg
view model = 
    div [] [ button [ id "my-btn"
                    , onClick ShowingModal ]
                    [ text "Open Modal" ]
           , div [ id "diyalog-modal"
                 , modalVisibility model.visibility ]
                 [ div [ modalBackground
                       , onClick CloseModal ] []
                 , div ( Animation.render model.style ++ 
                                    [ modalContent
                                    , id "modal-content" ]
                       )
                       [ model.fullHeader model.headerTitle
                       , model.fullBody   model.body
                       , model.fullFooter
                       ]
                 ]
           ]


update : Msg -> Model -> ( Model, Cmd Msg)
update msg model =
    case msg of
        ShowingModal ->
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

        OkModal command ->
            ( { model | style = Animation.style
                                [ Animation.top (px -50.0)
                                , Animation.opacity 0.0 ]
                      , visibility = HideModal }, command )

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
                   , body        = text ""
                   , headerTitle = ""
                   , fullHeader  = setFullHeader
                   , fullBody    = setFullBody
                   , fullFooter  = setFullFooter
                   , visibility  = HideModal }, Cmd.none )
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
