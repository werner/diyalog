module Diyalog exposing (Model, view, update, initial, subscriptions)

{-| A Dialog for Elm

# The model
@docs Model

# The view
@docs view

# The update
@docs update

# The subscriptions
@docs subscriptions

# The initial state
@docs initial

-}

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on, onClick, targetValue)

import Animation exposing (px)

import Styles exposing (..)
import Utils  exposing (..)
import Diyalog.Message exposing (..)

{-| Set up the model with style as the animation for the modal to show up, uses a pretty basic animation.
    The body property is the modal body, headerTitle just the title, fullHeader is the complete header with css
    fullBody is the whole body with css and the body, fullFooter should include the buttons with the actions.
    You don't need to modify visibility -}
type alias Model msg = { style           : Animation.State
                       , mainModalCss    : Attribute msg
                       , modalContentCss : Attribute msg
                       , body            : Html msg
                       , headerTitle     : String
                       , fullHeader      : (String -> Html msg)
                       , fullBody        : (Html msg -> Html msg)
                       , fullFooter      : Html msg
                       , visibility      : ModalVisibility }

{-| This is the modal itself -}
view : (Msg -> msg) -> Model msg -> Html msg
view msg model = 
    div [ modalVisibility model.visibility ]
        [ div [ modalBackground
              , Html.Attributes.map msg <| onClick CloseModal ] []
        , div ( Animation.render model.style ++ [ model.mainModalCss
                                                , style [("display", "block")]
                                                , id "diyalog-modal" ])
              [ div [ model.modalContentCss
                    , id "modal-content" ]
                    [ model.fullHeader model.headerTitle
                    , model.fullBody   model.body
                    , model.fullFooter
                    ]
              ]
        ]

{-| -}
update : Msg -> Model msg -> ( Model msg, Cmd Msg)
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

        OkModal ->
            ( { model | style = Animation.style
                                [ Animation.top (px -50.0)
                                , Animation.opacity 0.0 ]
                      , visibility = HideModal }, Cmd.none )

{-| -}
subscriptions : Model msg -> Sub Msg
subscriptions model =
    Animation.subscription Animate [ model.style ]

{-| -}
initial : (Msg -> msg) -> Model msg
initial msg = { style = Animation.style
                                [ Animation.top (px -50.0)
                                , Animation.opacity 0.0 ]
              , body            = text ""
              , headerTitle     = ""
              , fullHeader      = setFullHeader msg
              , fullBody        = setFullBody
              , fullFooter      = setFullFooter msg
              , modalContentCss = modalContent
              , mainModalCss    = mainModalCss
              , visibility      = HideModal }
