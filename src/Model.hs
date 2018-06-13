module Model where

-- | Type synonym for an application model
data Model
  = NotStarted
  | Started
    { ship :: Ship
    }
  deriving (Show, Eq)

type Ship = (Integer, Integer)


initShip :: Ship
initShip = (400, 400)
