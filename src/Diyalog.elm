module Diyalog exposing (..)

import Html exposing (..)
import Json.Decode as Decode
import Mouse exposing (Position)
import Html.Attributes as Attr exposing (..)
import Html.Events exposing (on, onClick, targetValue)
import Html.CssHelpers exposing (withNamespace)

import ModalCss exposing (..)

{ id, class, classList } =
    Html.CssHelpers.withNamespace ""

type Msg = OkModal
         | HideModal
         | DragStart Position
         | DragAt Position
         | DragEnd Position

type alias Model = { visibility : CssClasses 
                   , position   : Mouse.Position
                   , drag       : Maybe Drag }

type alias Drag = { start   : Mouse.Position
                  , current : Mouse.Position }

view : Model -> Html Msg
view model = 
    let
        realPosition = getPosition model
    in
        div [] [ button [ Attr.id "myBtn"
                        , onClick OkModal ]
                        [ text "Open Modal" ]
               , div [ id DiyalogModal 
                     , class [ model.visibility ] ]
                     [ div [ class [ ModalBackground]
                           , onClick HideModal ] []
                     , div [ class [ ModalContent ]
                           , onMouseDown
                           , style [ "left" => px realPosition.x
                                   , "top"  => px realPosition.y ]
                           ]
                           [ div [ class [ ModalHeader ] ]
                               [ button [ class [ CloseCss ] 
                                            , onClick HideModal ] 
                                            [ text "x" ]
                               , div [ class [ ModalHeaderTitle ] ] 
                                     [ text "Modal Header" ] 
                               ]
                           , div [ class [ ModalBody ] ]
                                 [ p [] [ text "Some Modal Body"] 
                                 , p [] [ text "Some other Modal Body"] ] 
                           , div [ class [ ModalFooter ] ]
                                 [ h3 [] [ text "Modal Footer"] ]
                           ]
                     ]
               ]

update : Msg -> Model -> ( Model, Cmd Msg)
update msg ({visibility, position, drag} as model) =
    case msg of
        OkModal ->
            ( { model | visibility = ShowModalCss }, Cmd.none )
        HideModal ->
            ( { model | visibility = HideModalCss }, Cmd.none )
        DragStart xy ->
            ( { model | position = position, drag = Just <| Drag xy xy } , Cmd.none ) 
        DragAt xy ->
            ( { model | position = position
              , drag = Maybe.map (\{start} -> Drag start xy) drag  }, Cmd.none ) 
        DragEnd xy ->
            ( { model | position = getPosition model, drag = Nothing } , Cmd.none ) 

subscriptions : Model -> Sub Msg
subscriptions model =
  case model.drag of
    Nothing ->
      Sub.none

    Just _ ->
      Sub.batch [ Mouse.moves DragAt, Mouse.ups DragEnd ]

main : Program Never Model Msg
main =
    program
        {
          init = ( { visibility = HideModalCss
                   , position = Position 200 200
                   , drag = Nothing  }, Cmd.none )
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


onMouseDown : Attribute Msg
onMouseDown =
  on "mousedown" (Decode.map DragStart Mouse.position)

getPosition : Model -> Position
getPosition {position, drag} =
  case drag of
    Nothing ->
      position

    Just {start,current} ->
      Position
        (position.x + current.x - start.x)
        (position.y + current.y - start.y)

px : Int -> String
px number =
  toString number ++ "px"

(=>) : a -> b -> ( a, b )
(=>) = (,)
