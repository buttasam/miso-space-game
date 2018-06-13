-- | Haskell language pragma
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module View where

import Miso
import Miso.String (MisoString, ms)
import Miso.Svg hiding (height_, id_, style_, width_)
import qualified Data.Map as M

import Action
import Model

textStyle :: Attribute a
textStyle = style_ $ M.fromList [ ("fill", "red")
                                , ("stroke", "red")
                                , ("font-size", "20px")
                                , ("text-anchor", "left")
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
viewModel (Started ship score) = rootBase [ text_ [ x_ $ px 10
                                        , y_ $ px 20
                                        , textStyle
                                        ] [ text scoreText],

                                        rect_ [ width_ $ px 30
                                       , height_ $ px 30
                                       , x_ $ px (fst ship)
                                       , y_ $ px (snd ship)
                                       , style_ $ M.fromList [ ("fill", "white")
                                                             , ("stroke", "black")
                                                             , ("stroke-width", "2")
                                                             ]
                                       ] []
                                ]
      where scoreText = ms ("Score: "  ++ (show score))
