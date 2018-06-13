-- | Haskell language pragma
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module Update where

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
updateModel (Tick _) m = m <# do
  putStrLn "Ticked" >> pure NoOp
