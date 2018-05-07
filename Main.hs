-- | Haskell language pragma
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

-- | Haskell module declaration
module Main where

-- | Miso framework import
import Miso
import Miso.String

-- | Type synonym for an application model
type Model = Int

-- | Sum type for application events
data Action
  = InitAction
  | NoOp
  deriving (Show, Eq)

-- | Entry point for a miso application
main :: IO ()
main = startApp App {..}
  where
    initialAction = InitAction    -- initial action to be executed on application load
    model         = 0             -- initial model
    update        = updateModel   -- update function
    view          = viewModel     -- view function
    events        = defaultEvents -- default delegated events
    subs          = []            -- empty subscription list
    mountPoint    = Nothing       -- mount point for application (Nothing defaults to 'body')

-- | Updates model, optionally introduces side effects
updateModel :: Action -> Model -> Effect Action Model
updateModel NoOp m = noEff m
updateModel InitAction m = m <# do
  putStrLn "Hello World" >> pure NoOp

-- | Constructs a virtual DOM from a model
viewModel :: Model -> View Action
viewModel x = div_ [] [ text "Miso space game" ]
