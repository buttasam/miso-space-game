-- | Haskell language pragma
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE RecordWildCards #-}

module View where

import Miso
import Miso.String (MisoString, ms)
import Miso.Svg hiding (height_, id_, style_, width_)
import qualified Data.Map as M

import Action
import Model

px :: Show a => a -> MisoString
px e = ms $ show e ++ "px"

-- | Render a model
rootBase :: [View a] -> View a
rootBase content = div_ [] [ svg_ [ height_ $ px screenSize
                                  , width_ $ px screenSize
                                  ] [ g_  [] (bg : content) ]
                           ]
  where
    bg = rect_ [ width_ (px screenSize), height_ (px screenSize) ] []

-- | Constructs a virtual DOM from a model
viewModel :: Model -> View Action
viewModel m@Started{..} = rootBase (renderShots m ++ [
                                    renderScore score,
                                    renderShip ship ,
                                    renderEnemy (100, 70)
                                    ])

renderShots :: Model -> [View Action]
renderShots Started{..} = map renderShot shots

renderScore :: Integer -> View Action
renderScore score = text_ [ x_ $ px 10
                          , y_ $ px 20
                          , style
                          ] [ text scoreText]
  where
    scoreText = ms ("Score: "  ++ (show score))
    style = style_ $ M.fromList [ ("fill", "red")
                                , ("font-size", "20px")
                                , ("text-anchor", "left") ]


renderShip :: Coords -> View Action
renderShip ship = rect_ [  width_ $ px shipSize
                    , height_ $ px shipSize
                    , x_ $ px (fst ship)
                    , y_ $ px (snd ship)
                    , style
                    ] []
    where
      style = style_ $ M.fromList [ ("fill", "green") ]



renderEnemy :: Coords -> View Action
renderEnemy enemy = rect_ [  width_ $ px enemySize
                    , height_ $ px enemySize
                    , x_ $ px (fst enemy)
                    , y_ $ px (snd enemy)
                    , style
                    ] []
    where
      style = style_ $ M.fromList [ ("fill", "yellow") ]


renderShot :: Coords -> View Action
renderShot shot = rect_ [ width_ $ px shotSize
                  , height_ $ px shotSize
                  , x_ $ px (fst shot)
                  , y_ $ px (snd shot)
                  , style_ $ M.fromList [ ("fill", "green")]
                  ] []
