module Model where

-- | Type synonym for an application model
data Model
  = NotStarted
  | Started
    { ship :: Ship,
      score :: Integer
    }
  deriving (Show, Eq)

type Ship = (Integer, Integer)


initShip :: Ship
initShip = (400, 400)

initScore :: Integer
initScore = 0
