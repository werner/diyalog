module Diyalog.Message exposing (Msg(..))

{-| The Message module

# The message
@docs Msg 
-}

import Animation

{-| -}
type Msg = ShowingModal
         | OkModal
         | CloseModal
         | Animate Animation.Msg

