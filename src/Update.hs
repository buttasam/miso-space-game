-- | Haskell language pragma
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module Update where

import qualified Data.Set as Set

import System.Random

-- | Miso framework import
import Miso
import Miso.String

import Action
import Model
import Game

-- | Updates model, optionally introduces side effects
updateModel :: Action -> Model -> Effect Action Model
updateModel (Create rand) m@Started{..} = noEff $ if (score `mod` 50 == 0) then createEnemy m rand else m
updateModel NoOp m = noEff m
updateModel InitAction m = m <# do
  putStrLn "Init" >> pure NoOp
updateModel (Tick _) m =
                      let newModel = updateGame m
                        in
                        newModel <# do
                        i <- randomRIO (0, fromInteger (screenSize - enemySize))
                        return $ Create i
updateModel (KeyboardPress keys) m@Started{..}
  | Set.member 39 keys = noEff $ moveShipLeft m
  | Set.member 37 keys = noEff $ moveShipRight m
  | Set.member 40 keys = noEff $ moveShipDown m
  | Set.member 38 keys = noEff $ moveShipUp m
  | Set.member 32 keys = noEff $ shoot m
  | otherwise = noEff $ m
