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

-- | Updates model, optionally introduces side effects
updateModel :: Action -> Model -> Effect Action Model
updateModel NoOp m = noEff m
updateModel InitAction m = m <# do
  putStrLn "Test" >> pure NoOp
updateModel (Tick _) m@(Started ship score) =
  noEff $ m {ship = ship, score = score + 1}
updateModel (KeyboardPress keys) m@(Started ship score) =
  noEff $ m { ship = ((fst ship) + 1, (snd ship)), score = score}
