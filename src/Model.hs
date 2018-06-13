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

-- | Define constants and init data
initShip :: Ship
initShip = ((screenSize `div` 2) - halfOfShip, screenSize - 3 * halfOfShip)
    where halfOfShip = shipSize `div` 2

initScore :: Integer
initScore = 0

screenSize :: Integer
screenSize = 600

shipSize :: Integer
shipSize = 30
