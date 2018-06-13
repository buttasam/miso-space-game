import Test.Hspec

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "#Basic test" $
    it "dummy test" $ do
      1 `shouldBe` 1
