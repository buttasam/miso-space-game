import Test.Hspec

import Game

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "sanitize edges" $ do
    it "returns value in ege" $ do
      (sanitizeEdges 10 5) `shouldBe` 15
    it "returns value in ege" $
      (sanitizeEdges 0 (-5)) `shouldBe` 0
