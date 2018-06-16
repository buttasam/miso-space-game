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

  describe "filterShots" $ do
    it "zero shots" $ do
      (filterShots []) `shouldBe` []
    it "one out of screen" $ do
      (filterShots [(200, 300), (100, -100)]) `shouldBe` [(200, 300)]
    it "all in screen" $ do
      (filterShots [(200, 300), (100, 500)]) `shouldBe` [(200, 300), (100, 500)]

  describe "filter live enemies" $ do
    it "zero shots zero enemies" $ do
      (filterLiveEnemies [] []) `shouldBe` []
    it "zero shots one enemy" $ do
      (filterLiveEnemies [(100, 300)] []) `shouldBe` [(100, 300)]
    it "filter one " $ do
      (filterLiveEnemies [(100, 300)] [(105, 299 + enemySize)]) `shouldBe` []

  describe "enemy intersects with shot" $ do
    it "shot intersects" $ do
      (enemyShotIntersect (200, 300) (210, 310)) `shouldBe` True
    it "shot does not intersect" $ do
      (enemyShotIntersect (200, 300) (400, 500)) `shouldBe` False
