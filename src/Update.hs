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
updateModel (Tick _) m@(Started ship) = m <# do
  putStrLn (show (fst ship)) >> pure NoOp
updateModel (KeyboardPress keys) m@(Started s) =
  noEff $ m { ship = ((fst s) + 1, (snd s)) }
