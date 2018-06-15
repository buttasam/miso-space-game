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

  describe "isGameOver" $ do
    it "game not over" $ do
      (isGameOver [(200, 300), (100, 500)]) `shouldBe` False
    it "game not over" $
      (isGameOver [(200, 300), (100, screenSize + 1)]) `shouldBe` True
