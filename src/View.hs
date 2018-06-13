-- | Haskell language pragma
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module View where

import Miso
import Miso.String

-- | Type synonym for an application model
type Model = Int

-- | Sum type for application events
data Action
  = InitAction
  | NoOp
  deriving (Show, Eq)

-- | Constructs a virtual DOM from a model
viewModel :: Model -> View Action
viewModel x = div_ [] [ text "Miso space game" ]
