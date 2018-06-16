-- | Haskell language pragma
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

{-|
Module      : Update
Description : Updates model
Copyright   : (c) Samuel Butta, 2018
License     : MIT
Maintainer  : samuel@butta.cz

Define application update model.
-}
module Update where

import qualified Data.Set as Set

import System.Random
import Control.Monad

-- | Miso framework import
import Miso
import Miso.String

import Action
import Model
import Game

-- | Updates model, optionally introduces side effects
updateModel :: Action -> Model -> Effect Action Model
updateModel (Create (r1, r2)) m@Started{..} = noEff $ if (r1 < 3) then createEnemy m r2 else m
updateModel NoOp m = noEff m
updateModel InitAction m = m <# do
  putStrLn "Init" >> pure NoOp
updateModel (Tick _) m =
                      let newModel = updateGame m
                        in
                        newModel <# do
                        i <-randomRIO (1, 100)
                        j <-randomRIO (0, fromInteger (screenSize - enemySize))
                        return $ Create (i,j)
updateModel (KeyboardPress keys) m@Started{..}
  | Set.member 39 keys = noEff $ moveShipLeft m
  | Set.member 37 keys = noEff $ moveShipRight m
  | Set.member 40 keys = noEff $ moveShipDown m
  | Set.member 38 keys = noEff $ moveShipUp m
  | Set.member 32 keys = noEff $ shoot m
  | otherwise = noEff $ m
