{-|
Module      : Model
Description : Define application model
Copyright   : (c) Samuel Butta, 2018
License     : MIT
Maintainer  : samuel@butta.cz

Define application model, constants and init functions.
-}
module Model where

-- | Type synonym for an application model
data Model
  = GameOver { score :: Integer}
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

initEnemies :: [Coords]
initEnemies = [(100, -20), (300, -10), (480, -35)]

initShots :: [Coords]
initShots = []

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

enemySize :: Integer
enemySize = 40

enemySpeed :: Integer -> Integer
enemySpeed score = (score `div` 200) + 1
