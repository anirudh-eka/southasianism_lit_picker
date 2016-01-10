module Main where

import Prelude
import Control.Monad.Eff
import Control.Monad.Eff.Console
import Data.Array
import Data.Maybe
import Math (sqrt)

data Point = Point PointObj | NoPoint
type PointObj = { x :: Number, y :: Number }

showPoint :: Point -> String
showPoint NoPoint = "No point!"
showPoint (Point p) = "(" ++ show p.x ++ ", " ++ show p.y ++ ")"

toPoint :: PointObj -> Point
toPoint obj = Point obj

findNearestPoint :: PointObj -> Array PointObj -> Point
findNearestPoint given pts = findNearestPoint' (toPoint given) NoPoint pts
	where
	findNearestPoint' :: Point -> Point -> Array PointObj -> Point
	findNearestPoint' given nearest [] = nearest
 	findNearestPoint' given nearest pts = maybe (nearest) (\({head: x, tail: xs }) -> findNearestPoint' given (findNearestPoint'' (toPoint x) nearest given) xs) (uncons pts)
 	
 	findNearestPoint'' :: Point -> Point -> Point -> Point
 	findNearestPoint'' p1 p2 given | (p1 `lessThan` p2) given = p1
 								 | otherwise = p2

lessThan :: Point -> Point -> Point -> Boolean
lessThan p1 p2 given = maybe (true) (maybe (\ diff2 -> false) (\ diff1 -> (\ diff2 -> diff1 < diff2 )) (pointDiff given p1)) (pointDiff given p2)

pointDiff :: Point -> Point -> Maybe Number
pointDiff  _ NoPoint = Nothing
pointDiff  NoPoint _ = Nothing
pointDiff (Point p1) (Point p2) = Just (sqrt (((p1.x - p2.x) * (p1.x - p2.x)) + ((p1.y - p2.y) * (p1.y - p2.y))))

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  log "Purescript Loaded."
