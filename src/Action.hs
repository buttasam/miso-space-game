{-|
Module      : Action
Description : Module defines application events
Copyright   : (c) Samuel Butta, 2018
License     : MIT
Maintainer  : samuel@butta.cz
-}
module Action where

import qualified Data.Set as Set
import Miso

data Action
  = InitAction
  | Tick !Double
  | KeyboardPress !(Set.Set Int)
  | Create !(Int, Int)
  | NoOp
  deriving (Show, Eq)
