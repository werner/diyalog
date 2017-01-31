module Basic exposing (..)

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
    div [] [ button [ id "my-btn"
                    , onClick <| DiyalogMsg Diyalog.Message.ShowingModal ]
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
          in { modal = { initialModal | headerTitle = "My awesome Title"
                                      , body = simpleBody }
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

simpleBody : Html Msg
simpleBody = p [] [ text " A modal example" ]
