{-# LANGUAGE RecordWildCards #-}

{-|
Module      : Game
Description : Game login module
Copyright   : (c) Samuel Butta, 2018
License     : MIT
Maintainer  : samuel@butta.cz

Defines game logic.
-}
module Game where

import Model

-- | Move ship left (update model).
moveShipLeft :: Model -> Model
moveShipLeft m@Started{..} = m { ship = (sanitizeEdges (fst ship) shipSpeed, (snd ship)) }

-- | Move ship right (update model).
moveShipRight :: Model -> Model
moveShipRight  m@Started{..} = m { ship = (sanitizeEdges (fst ship) (-shipSpeed), (snd ship)) }

-- | Move ship up (update model).
moveShipUp :: Model -> Model
moveShipUp m@Started{..} = m { ship = ((fst ship), sanitizeEdges (snd ship) (-shipSpeed)) }

-- | Move ship down left (update model).
moveShipDown :: Model -> Model
moveShipDown m@Started{..} = m { ship = ((fst ship), sanitizeEdges (snd ship) shipSpeed) }

-- | Calculate sanitized edges.
sanitizeEdges :: Integer -> Integer -> Integer
sanitizeEdges coord delta
  | newCoord < 0 = coord
  | newCoord > (screenSize - shipSize) = coord
  | otherwise = newCoord
    where newCoord = coord + delta


-- | Basic model update function (used for every time tick).
updateGame :: Model -> Model
updateGame m@Started{..}
  | isGameOver enemies = GameOver score
  | otherwise =  m { score = score + 1,
                     shots = filterShots $ moveShots shots,
                     enemies = filterLiveEnemies (moveEnemies enemies score) shots
                   }

-- | Add new shot to the list of shots.
shoot :: Model -> Model
shoot m@Started{..} = m { shots = [newShot] ++ shots }
  where newShot = initShot ship

-- | Add new enemy on random position (update model).
createEnemy :: Model -> Int -> Model
createEnemy m@Started{..} rand = m { enemies = [(toInteger rand, -enemySize)] ++ enemies }

-- | Move enemies by incrementing second coordinate.
moveEnemies :: [Coords] -> Integer -> [Coords]
moveEnemies enemies score = map (\enemy -> ((fst enemy), (snd enemy) + (enemySpeed score))) enemies

-- | Move shots by decrementing second coordinate.
moveShots :: [Coords] -> [Coords]
moveShots shots = map (\shot -> ((fst shot), (snd shot) - shotSpeed)) shots

-- | Filter shots only on game screen.
filterShots :: [Coords] -> [Coords]
filterShots shots = filter (not . shotIsOut) shots
  where
    shotIsOut :: Coords -> Bool
    shotIsOut shot = yShotMax < 0
      where
        yShotMax = (snd shot) + shotSize

-- | Filter only live enemies.
filterLiveEnemies :: [Coords] -> [Coords] -> [Coords]
filterLiveEnemies enemies shots = filter (\e -> not (isEnemyKilled e shots)) enemies
  where
    isEnemyKilled :: Coords -> [Coords] -> Bool
    isEnemyKilled enemy shots = not . null $ filter (\s -> enemyShotIntersect enemy s) shots

-- | Check if any enemy is out of screen.
isGameOver :: [Coords] -> Bool
isGameOver enemies = not . null $ filter (\e -> (snd e) > (screenSize- enemySize)) enemies

-- | Check if enemy intersect with shot.
enemyShotIntersect :: Coords -> Coords -> Bool
enemyShotIntersect enemy shot = (yEnemyMax > yShotMin) && (xEnemyMax > xShotMin) && (yEnemyMin < yShotMax) && (xEnemyMin < xShotMax)
  where
    xEnemyMin = fst enemy
    xEnemyMax = (fst enemy) + enemySize
    yEnemyMin = snd enemy
    yEnemyMax = (snd enemy) + enemySize
    xShotMin = fst shot
    xShotMax = (fst shot) + shotSize
    yShotMin = snd shot
    yShotMax = (snd shot) + shotSize
