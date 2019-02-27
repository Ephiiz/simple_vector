# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest
import typetraits
import strutils

import simple_vector
suite "simple_vector":
  test "can create a vector":
    let testVector2D = Vector(0,0)
    let testVector3D = Vector(0,0,0)
    check testVector2D.type.name == "Vector2D"
    check testVector3D.type.name == "Vector3D"
  
  test "can convert vectors to string":
    let testVector2D = Vector(0,1)
    let testVector3D = Vector(0,1.01,2)
    check testVector2D.toString() == "[0.0000, 1.000]"
    check testVector3D.toString() == "[0.0000, 1.010, 2.000]"

  test "can set vector values":
    let testVector2D = Vector(0,1)
    let testVector3D = Vector(0,1.01,2)
    check testVector2D.toString() == "[0.0000, 1.000]"
    check testVector3D.toString() == "[0.0000, 1.010, 2.000]"

    # Can set single value
    discard testVector2D.set(2)
    discard testVector3D.set(2)
    check testVector2D.toString() == "[2.000, 1.000]"
    check testVector3D.toString() == "[2.000, 1.010, 2.000]"

    # Can set multiple values
    discard testVector2D.set(2, 9)
    discard testVector3D.set(2, 1.3, 7.04)
    check testVector2D.toString() == "[2.000, 9.000]"
    check testVector3D.toString() == "[2.000, 1.300, 7.040]"    

  test "can add scalars to vectors":
    let testVector2D = Vector(0,1)
    let testVector3D = Vector(0,1.01,2)

    # Can add single value
    discard testVector2D.add(1)
    discard testVector3D.add(1.1)
    check testVector2D.toString() == "[1.000, 1.000]"
    check testVector3D.toString() == "[1.100, 1.010, 2.000]"

    # Can add multiple values
    discard testVector2D.add(1, 1)
    discard testVector3D.add(1.1, 3, 2.04)
    check testVector2D.toString() == "[2.000, 2.000]"
    check testVector3D.toString() == "[2.200, 4.010, 4.040]"
  
  test "can subtract scalars from vectors":
    let testVector2D = Vector(0,1)
    let testVector3D = Vector(0,1.01,2)

    # Can subtract single value
    discard testVector2D.sub(1)
    discard testVector3D.sub(1.1)
    check testVector2D.toString() == "[-1.000, 1.000]"
    check testVector3D.toString() == "[-1.100, 1.010, 2.000]"

    # Can subtract multiple values
    discard testVector2D.sub(1, 2.1)
    discard testVector3D.sub(1.1, 3, 7.04)
    check testVector2D.toString() == "[-2.000, -1.100]"
    check testVector3D.toString() == "[-2.200, -1.990, -5.040]"

  test "can multiply scalar to vector":
    let testVector2D = Vector(0,1)
    let testVector3D = Vector(0,1.01,2)

    discard testVector2D.mult(2)
    discard testVector3D.mult(2.2)
    check testVector2D.toString() == "[0.0000, 2.000]"
    check testVector3D.toString() == "[0.0000, 2.222, 4.400]"
  
  test "can divide vector by scalar":
    let testVector2D = Vector(1,2)
    let testVector3D = Vector(1,2.01,3)

    discard testVector2D.divide(2)
    discard testVector3D.divide(2.2)
    check testVector2D.toString() == "[0.5000, 1.000]"
    check testVector3D.toString() == "[0.4545, 0.9136, 1.364]"

  test "can get magnitude of vector":
    let testVector2D = Vector(1,2)
    let testVector3D = Vector(1,2.01,3)

    check testVector2D.mag().formatFloat(ffDefault, 6) == "2.23607"
    check testVector3D.mag().formatFloat(ffDefault, 6) == "3.74701"
  
  test "can get dot product of vector":
    let testVector2D = Vector(1,2)
    let testVector3D = Vector(1,2.01,3)

    check testVector2D.dot(Vector(1,1)) == 3
    check testVector3D.dot(Vector(1.03, 2.1)) == 5.251
  
  test "can get cross product of vector":
    let testVector3D = Vector(1,2.01,3)

    check testVector3D.cross(Vector(2,3.4,8)).toString() == "[5.880, -2.000, -0.6200]"
  
  test "can normalize vector":
    let testVector2D = Vector(1,2)
    let testVector3D = Vector(1,2.01,3)
    check testVector2D.normalize().mag() == 1
    check testVector3D.normalize().mag() == 1