module Action where

import qualified Data.Set as Set

import Miso

-- | Sum type for application events
data Action
  = InitAction
  | Tick !Double
  | KeyboardPress !(Set.Set Int)
  | NoOp
  deriving (Show, Eq)
