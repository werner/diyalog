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

view : Model -> Html Msg
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

update : Msg -> Model -> ( Model, Cmd Msg)
update msg model =
    case msg of
        OkModal ->
            ( { model | visibility = ShowModalCss }, Cmd.none )
        HideModal ->
            ( { model | visibility = HideModalCss }, Cmd.none )

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

main =
    program
        {
          init = ( { visibility = HideModalCss }, Cmd.none )
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
      
