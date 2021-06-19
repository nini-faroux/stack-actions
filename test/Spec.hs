import Test.Hspec
import Lib

main :: IO ()
main = hspec $
  describe "square" $
    it "squares an integer" $ do
      square 2 `shouldBe` 4
      square 3 `shouldBe` 9
