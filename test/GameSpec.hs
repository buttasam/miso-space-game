import Test.Hspec

import Game
import Model

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "sanitize edges" $ do
    it "returns value in ege" $ do
      (sanitizeEdges 10 5) `shouldBe` 15
    it "returns value in ege" $
      (sanitizeEdges 0 (-5)) `shouldBe` 0

  describe "is game over" $ do
    it "game not over" $ do
      (isGameOver [(200, 300), (100, 500)]) `shouldBe` False
    it "game not over" $
      (isGameOver [(200, 300), (100, screenSize + 1)]) `shouldBe` True

  describe "move enemies" $ do
    it "zero enemies" $ do
      (moveEnemies [] 2) `shouldBe` []
    it "correct move enemies" $ do
      (moveEnemies [(200, 300), (100, 500)] 2) `shouldBe` [(200, 302), (100, 502)]

{-
  describe "filterShots" $ do
    it "game not over" $ do
      (isGameOver [(200, 300), (100, 500)]) `shouldBe` False

  describe "filterLiveEnemies" $ do
    it "game not over" $ do
      (isGameOver [(200, 300), (100, 500)]) `shouldBe` False

  describe "enemyShotIntersect" $ do
    it "game not over" $ do
      (isGameOver [(200, 300), (100, 500)]) `shouldBe` False
-}
