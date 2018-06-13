-- | Haskell language pragma
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module View where

import Miso
import Miso.String
import Miso.Svg hiding (height_, id_, style_, width_)
import qualified Data.Map as M

import Action
import Model

textStyle :: Attribute a
textStyle = style_ $ M.fromList [ ("fill", "red")
                                , ("stroke", "red")
                                , ("font-size", "25px")
                                , ("text-anchor", "middle")
                                ]

px :: Show a => a -> MisoString
px e = ms $ show e ++ "px"

-- | Render a model
rootBase :: [View a] -> View a
rootBase content = div_ [] [ svg_ [ height_ $ px 600
                                  , width_ $ px 600
                                  ] [ g_  [] (bg : content) ]
                           ]
  where
    bg = rect_ [ width_ (px 600), height_ (px 600) ] []

-- | Constructs a virtual DOM from a model
viewModel :: Model -> View Action
viewModel (Started ship) = rootBase [ text_ [ x_ $ px (fst ship)
                                        , y_ $ px (snd ship)
                                        , textStyle
                                        ] [ text "Press ENTER to start" ]
                                ]
