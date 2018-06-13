module Game where

import Model

moveShipLeft :: Model -> Model
moveShipLeft m@(Started ship score) = m { ship = (sanitizeEdges (fst ship) 1, (snd ship)), score = score }

moveShipRight :: Model -> Model
moveShipRight  m@(Started ship score) = m { ship = (sanitizeEdges (fst ship) (-1), (snd ship)), score = score }

moveShipUp :: Model -> Model
moveShipUp m@(Started ship score) = m { ship = ((fst ship), sanitizeEdges (snd ship) (-1)), score = score }

moveShipDown :: Model -> Model
moveShipDown m@(Started ship score) = m { ship = ((fst ship), sanitizeEdges (snd ship) 1), score = score }


sanitizeEdges :: Integer -> Integer -> Integer
sanitizeEdges coord delta
  | newCoord < 0 = coord
  | newCoord > (screenSize - shipSize) = coord
  | otherwise = newCoord
    where newCoord = coord + delta