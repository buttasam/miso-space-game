-- | Haskell language pragma
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module Update where

import qualified Data.Set as Set

-- | Miso framework import
import Miso
import Miso.String

import Action
import Model
import Game

-- | Updates model, optionally introduces side effects
updateModel :: Action -> Model -> Effect Action Model
updateModel NoOp m = noEff m
updateModel InitAction m = m <# do
  putStrLn "Test" >> pure NoOp
updateModel (Tick _) m@(Started ship score) =
  noEff $ m {ship = ship, score = score + 1}
updateModel (KeyboardPress keys) m@(Started ship score)
  | Set.member 39 keys = noEff $ (moveShipLeft m)
  | Set.member 37 keys = noEff $ (moveShipRight m)
  | Set.member 40 keys = noEff $ (moveShipDown m)
  | Set.member 38 keys = noEff $ (moveShipUp m)
  | Set.member 32 keys = m <# do
      putStrLn "Shoot" >> pure NoOp
  | otherwise = noEff $ m
