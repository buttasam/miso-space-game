{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

{-|
Module      : Main
Description : Main module
Copyright   : (c) Samuel Butta, 2018
License     : MIT
Maintainer  : samuel@butta.cz

Starting point of application.
-}
module Main where

import Control.Concurrent
import Control.Monad

import Miso
import Miso.String

import Game
import View
import Update
import Action
import Model


foreign import javascript unsafe "$r = performance.now();"
  now :: IO Double

-- | Utility for periodic tick subscriptions
every :: Int -> (Double -> action) -> Sub action model
every n f _ sink = void . forkIO . forever $ do
  threadDelay n
  sink =<< f <$> Main.now

-- | Entry point for a miso application
main :: IO ()
main = startApp App {..}
  where
    initialAction = InitAction    -- initial action to be executed on application load
    model         = Started initShip initScore initEnemies initShots -- initial model
    update        = updateModel   -- update function
    view          = viewModel     -- view function
    events        = defaultEvents -- deccfault delegated events
    subs          = [keyboardSub KeyboardPress -- arrows + WASD
                     ,every 50000 Tick]            -- empty subscription list
    mountPoint    = Nothing       -- mount point for application (Nothing defaults to 'body')
