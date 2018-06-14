module Model where

-- | Type synonym for an application model
data Model
  = NotStarted
  | Started
    { ship :: Coords,
      score :: Integer,
      enemies :: [Coords],
      shots :: [Coords]
    }
  deriving (Show, Eq)

type Coords = (Integer, Integer)

-- | Define constants and init data
initShip :: Coords
initShip = ((screenSize `div` 2) - halfOfShip, screenSize - 3 * halfOfShip)
    where halfOfShip = shipSize `div` 2

initShot :: Coords -> Coords
initShot ship = ((fst ship) + (shipSize `div` 2) - (shotSize `div` 2), (snd ship))


initScore :: Integer
initScore = 0

screenSize :: Integer
screenSize = 600

shipSize :: Integer
shipSize = 30

shipSpeed :: Integer
shipSpeed = 5

shotSpeed :: Integer
shotSpeed = 10

shotSize :: Integer
shotSize = 10
