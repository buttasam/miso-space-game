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
updateModel (KeyboardPress keys) m@(Started ship score)
  | Set.member 39 keys = noEff $ m { ship = ((fst ship) + 1, (snd ship)), score = score }
  | Set.member 37 keys = noEff $ m { ship = ((fst ship) - 1, (snd ship)), score = score }
  | Set.member 40 keys = noEff $ m { ship = ((fst ship), (snd ship) + 1), score = score }
  | Set.member 38 keys = noEff $ m { ship = ((fst ship), (snd ship) - 1), score = score }
  | Set.member 32 keys = m <# do
      putStrLn "Shoot" >> pure NoOp
  | otherwise = noEff $ m
