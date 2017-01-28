module Message exposing (..)

import Animation

type Msg = ShowingModal
         | OkModal (Cmd Msg)
         | CloseModal
         | Animate Animation.Msg

