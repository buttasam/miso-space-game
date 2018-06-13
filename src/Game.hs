module Game where

import Model

moveShipLeft :: Model -> Model
moveShipLeft m@(Started ship score enemies) = m { ship = (sanitizeEdges (fst ship) shipSpeed, (snd ship)), score = score, enemies = enemies }

moveShipRight :: Model -> Model
moveShipRight  m@(Started ship score enemies) = m { ship = (sanitizeEdges (fst ship) (-shipSpeed), (snd ship)), score = score, enemies = enemies }

moveShipUp :: Model -> Model
moveShipUp m@(Started ship score enemies) = m { ship = ((fst ship), sanitizeEdges (snd ship) (-shipSpeed)), score = score, enemies = enemies }

moveShipDown :: Model -> Model
moveShipDown m@(Started ship score enemies) = m { ship = ((fst ship), sanitizeEdges (snd ship) shipSpeed), score = score, enemies = enemies }


sanitizeEdges :: Integer -> Integer -> Integer
sanitizeEdges coord delta
  | newCoord < 0 = coord
  | newCoord > (screenSize - shipSize) = coord
  | otherwise = newCoord
    where newCoord = coord + delta
