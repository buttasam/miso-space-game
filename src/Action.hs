module Action where
-- | Sum type for application events
data Action
  = InitAction
  | NoOp
  deriving (Show, Eq)
