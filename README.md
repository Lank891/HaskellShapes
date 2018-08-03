# HaskellShapes
Simple module with shapes and operations on them

Module has:
(*) Shape with 3 constructors: Circle (needs point and radius), Rect (needs 2 points) and Tri (needs 3 points), they represent Circle, Rectangle and Triangle
(*) Point with 1 constructor: Point (needs 2 floats) - represents point on x-y plane
(*) Shapes and Points derives: Eq, Read, custom Show, custom class Trans with smap function
(*) Function `surface` - returns surface of a shape
(*) Function `circum` - returns circumfence of a shape
(*) Function `move` - changes coordinates of all points in given shape (doesn't work with points)
(*) baseX, where X = Circle/Rect/Tri - it is like creating shape, but 1st point is 0,0 and you don't need to write it
(*) Function `smap` from Trans class - it works like map: you give if function (float -> float) and it operates on points coordinates (in pure point or, when used with shape, on all points in shape (and on radius if the shape is a circle)

Simple input and output (module imported as Sh):
*Main> let a = Sh.Circle (Sh.Point 2 2) 3
*Main> let b = Sh.Rect (Sh.Point 1 1) (Sh.Point 3 3)
*Main> let p = Sh.Point (-1) (-2)
*Main> let c = Sh.baseTri p (Sh.Point 3 0)
*Main> a
Circle with middle point (2.0, 2.0) and radius 3.0
*Main> b
Rectangle with left bottom corner in (1.0, 1.0) and right upper corner in (3.0, 3.0)
*Main> p
(-1.0, -2.0)
*Main> c
Triangle with three points: (0.0, 0.0), (-1.0, -2.0) and (3.0, 0.0)
*Main> Sh.surface b
4.0
*Main> Sh.circum c
9.708204
*Main> let d = Sh.move a (-1) 1   --Sh.move (shape) (x offset) (y offset)
*Main> d
Circle with middle point (1.0, 3.0) and radius 3.0
*Main> let p2 = Sh.smap (\x -> x*2) p
*Main> p2
(-2.0, -4.0)
*Main> a == Sh.smap  (\x -> x) a
True
*Main> p == p2
False
*Main> show $ Sh.smap (\x -> x^2 + 2) a
"Circle with middle point (6.0, 6.0) and radius 11.0"
