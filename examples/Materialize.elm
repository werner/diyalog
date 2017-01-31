module Materialize exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on, onClick, targetValue)
import Diyalog exposing (..)
import Diyalog.Message exposing (..)
import Random

type Msg = DiyalogMsg Diyalog.Message.Msg
         | ChangeNumber Int

type alias Model = { modal : Diyalog.Model Msg, numberRandom : Int }

view : Model -> Html Msg
view model = 
    div [] [ a [ id "my-btn"
               , class "waves-effect waves-light btn"
               , onClick <| DiyalogMsg Diyalog.Message.ShowingModal 
               , href "#diyalog-modal"]
               [ text "Open Modal" ]
           , p [] []
           , div [] [ text <| "Mi number:" ++ toString model.numberRandom ]
           , Diyalog.view DiyalogMsg model.modal
           ]

update : Msg -> Model -> ( Model, Cmd Msg)
update msg model =
    case msg of
        DiyalogMsg msgModal ->
            case msgModal of
                OkModal ->
                    let (updateModal, cmd) = Diyalog.update msgModal model.modal
                    in
                        ( { model | modal = updateModal }, Random.generate ChangeNumber (Random.int 1 20) )
                _ ->
                    let (updateModal, cmd) = Diyalog.update msgModal model.modal
                    in
                        ( { model | modal = updateModal }, Cmd.none )

        ChangeNumber i ->
            ( { model | numberRandom = i}, Cmd.none )

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch [ Sub.map DiyalogMsg ( Diyalog.subscriptions model.modal ) ]

initial : Model
initial = let initialModal = Diyalog.initial DiyalogMsg
          in { modal = { initialModal | fullHeader = setFullHeader
                                      , headerTitle =  "My awesome Materialize modal"
                                      , mainModalCss = class "modal"
                                      , modalContentCss = class "modal-content"
                                      , fullBody = setFullBody
                                      , fullFooter = setFullFooter
                                      , body = p [] [ text " A modal example" ] }
             , numberRandom = 0 }

main : Program Never Model Msg
main =
    program
      {
        init = ( initial, Cmd.none )
      , view = view
      , update = update
      , subscriptions = subscriptions
      }

setFullHeader : String -> Html Msg
setFullHeader header = 
    div [ class "modal-header" ]
        [ button [ class "btn-flat"
                 , style [("float", "right")]
                 , onClick  <| DiyalogMsg CloseModal ] 
                 [ text "x" ]
        , div [ class "modal-title" ] 
              [ text header ] 
        ]

setFullBody : Html Msg -> Html Msg
setFullBody body =
    div [ class "modal-body" ]
        [ body ]

setFullFooter : Html Msg
setFullFooter = 
    div [ class "modal-footer" ]
        [ button [ class "modal-action modal-close waves-effect waves-green btn-flat"
                 , onClick <| DiyalogMsg CloseModal ]
                 [ text "Close" ]
        , button [ class "modal-action modal-close waves-effect waves-green btn-flat" 
                 , onClick <| DiyalogMsg OkModal ] 
                 [ text "Ok" ] ]

