module Action where
-- | Sum type for application events
data Action
  = InitAction
  | Tick !Double
  | NoOp
  deriving (Show, Eq)
