{-# LANGUAGE RecordWildCards #-}

module Game where

import Model

moveShipLeft :: Model -> Model
moveShipLeft m@Started{..} = m { ship = (sanitizeEdges (fst ship) shipSpeed, (snd ship)) }

moveShipRight :: Model -> Model
moveShipRight  m@Started{..} = m { ship = (sanitizeEdges (fst ship) (-shipSpeed), (snd ship)) }

moveShipUp :: Model -> Model
moveShipUp m@Started{..} = m { ship = ((fst ship), sanitizeEdges (snd ship) (-shipSpeed)) }

moveShipDown :: Model -> Model
moveShipDown m@Started{..} = m { ship = ((fst ship), sanitizeEdges (snd ship) shipSpeed) }


sanitizeEdges :: Integer -> Integer -> Integer
sanitizeEdges coord delta
  | newCoord < 0 = coord
  | newCoord > (screenSize - shipSize) = coord
  | otherwise = newCoord
    where newCoord = coord + delta


updateGame :: Model -> Model
updateGame m@Started{..} = m {ship = ship, score = score + 1, enemies = enemies}
