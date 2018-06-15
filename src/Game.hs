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
updateGame m@Started{..}
  | isGameOver enemies = GameOver
  | otherwise =  m { score = score + 1,
                     shots = filterShots $ moveShots shots,
                     enemies = filterLiveEnemies (moveEnemies enemies score) shots
                   }

shoot :: Model -> Model
shoot m@Started{..} = m { shots = [newShot] ++ shots }
  where newShot = initShot ship

createEnemy :: Model -> Int -> Model
createEnemy m@Started{..} rand = m { enemies = [(toInteger rand, -enemySize)] ++ enemies }

moveEnemies :: [Coords] -> Integer -> [Coords]
moveEnemies enemies score = map (\enemy -> ((fst enemy), (snd enemy) + (enemySpeed score))) enemies

moveShots :: [Coords] -> [Coords]
moveShots shots = map (\shot -> ((fst shot), (snd shot) - shotSpeed)) shots

filterShots :: [Coords] -> [Coords]
filterShots shots = filter (not . shotIsOut) shots

shotIsOut :: Coords -> Bool
shotIsOut shot = yShotMax < 0
  where
    yShotMax = (snd shot) + shotSize

filterLiveEnemies :: [Coords] -> [Coords] -> [Coords]
filterLiveEnemies enemies shots = filter (\e -> not (isEnemyKilled e shots)) enemies

isEnemyKilled :: Coords -> [Coords] -> Bool
isEnemyKilled enemy shots = not . null $ filter (\s -> enemyShotIntersect enemy s) shots

isGameOver :: [Coords] -> Bool
isGameOver enemies = not . null $ filter (\e -> (snd e) > (screenSize- enemySize)) enemies

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
