module Shapes
( Shape (..)
, Point (..)
, surface
, circum
, move
, baseCircle
, baseRect
, baseTri
, smap
) where

class Trans a where
    smap :: (Float -> Float) -> a -> a
-- class Trans with map function (smap): so it is possible to use function float to float on things like Point or Shape

data Point = Point { x::Float
                   , y::Float
                   } deriving (Eq)
-- Point: coords of point
-- also instance of Show and Trans (later)

data Shape = Circle { middlePoint::Point
                    , radius::Float
                    }
             | Rect { leftBottom::Point
                    , rightUpper::Point
                    }
             | Tri  { point1::Point
                    , point2::Point
                    , point3::Point
                    } deriving (Eq)
-- Circle: Point (middle), radius r; Rect: Point (left bottom), Point (right upper); Tri: 3 points of triangle
-- also instance of Show and Trans (later)

surface :: Shape -> Float
surface (Circle _ r) = pi * r ^ 2
surface (Rect (Point x1 y1) (Point x2 y2) ) = (abs $ x2-x1) * (abs $ y2-y1)
surface (Tri (Point x1 y1) (Point x2 y2) (Point x3 y3) ) =
    let a = sqrt $ ( ( abs $ x2-x1 )^2 ) + ( ( abs $ y2-y1)^2 )
        b = sqrt $ ( ( abs $ x3-x1 )^2 ) + ( ( abs $ y3-y1)^2 )
        c = sqrt $ ( ( abs $ x3-x2 )^2 ) + ( ( abs $ y3-y2)^2 )
    in 0.25 * ( sqrt $ (a+b+c)*(a+b-c)*(a-b+c)*(b+c-a) )
-- surface: Returns surface of given shape

circum :: Shape -> Float
circum (Circle _ r) = 2 * pi * r
circum (Rect (Point x1 y1) (Point x2 y2) ) = 2 * ( ( abs $ x2-x1 ) + ( abs $ y2-y1 ) )
circum (Tri (Point x1 y1) (Point x2 y2) (Point x3 y3) ) =
    let a = sqrt $ ( ( abs $ x2-x1 )^2 ) + ( ( abs $ y2-y1)^2 )
        b = sqrt $ ( ( abs $ x3-x1 )^2 ) + ( ( abs $ y3-y1)^2 )
        c = sqrt $ ( ( abs $ x3-x2 )^2 ) + ( ( abs $ y3-y2)^2 )
    in a + b + c
-- circuit: Returns circumfence of given shape

move :: Shape -> Float -> Float -> Shape
move (Circle (Point x y) r) a b = Circle (Point (x+a) (y+b)) r
move (Rect (Point x1 y1) (Point x2 y2)) a b = Rect (Point (x1+a) (y1+b)) (Point (x2+a) (y2+b))
move (Tri (Point x1 y1) (Point x2 y2) (Point x3 y3)) a b = Tri (Point (x1+a) (y1+b)) (Point (x2+a) (y2+b)) (Point (x3+a) (y3+b))
-- move: Returns shape moved by given x and y values


baseCircle :: Float -> Shape
baseCircle = Circle (Point 0 0)

baseRect :: Point -> Shape
baseRect = Rect (Point 0 0)

baseTri :: Point -> Point -> Shape
baseTri = Tri (Point 0 0)
-- baseX: To create X shape with first point 0, 0

instance Show Point where
    show (Point x y) = "(" ++ (show x) ++ ", " ++ (show y) ++ ")"
-- Show for Point

instance Show Shape where
    show (Circle p r) = "Circle with middle point " ++ (show p) ++ " and radius " ++ (show r)
    show (Rect p1 p2) = "Rectangle with left bottom corner in " ++ (show p1) ++ " and right upper corner in " ++ (show p2)
    show (Tri p1 p2 p3) = "Triangle with three points: " ++ (show p1) ++ ", " ++ (show p2) ++ " and " ++ (show p3)
-- Show for Shape

instance Trans Point where
    smap f (Point x y) = Point (f x) (f y)
-- map (smap) for given point - uses given f (float->float) function on both coords

instance Trans Shape where
    smap f (Circle p r) = Circle (smap f p) (f r)
    smap f (Rect p1 p2) = Rect (smap f p1) (smap f p2)
    smap f (Tri p1 p2 p3) = Tri (smap f p1) (smap f p2) (smap f p3)
-- map (smap) for given shapes - uses given f (float->float) function on all points (and on radius in case of circle)
