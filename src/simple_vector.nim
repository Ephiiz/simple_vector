import strutils
import math

type
  Vector2D* = ref object of RootObj
    x*: float
    y*: float
  Vector3D* = ref object of Vector2D
    z*: float


#[
  Create vector proc.
]#
proc Vector*(x: float, y: float): Vector2D =
  return Vector2D(x:x, y:y)
proc Vector*(x: float, y: float, z: float): Vector3D =
  return Vector3D(x:x, y:y, z:z)

#[
  Returns string representation of a vector
]#
proc toString*(self: Vector2D): string =
  let output: string = "[" & self.x.formatFloat(ffDefault, 4) & ", " & self.y.formatFloat(ffDefault, 4) & "]"
  return output
proc toString*(self: Vector3D): string =
  let output: string = "[" & self.x.formatFloat(ffDefault, 4) & ", " & self.y.formatFloat(ffDefault, 4) & ", " & self.z.formatFloat(ffDefault, 4) & "]"
  return output

#[
  Return copy of vector
]#
proc copy*(self: Vector2D): Vector2D =
  return Vector(self.x, self.y)
proc copy*(self: Vector3D): Vector3D =
  return Vector(self.x, self.y, self.z)

#[
  Set the x and y component of the vector
]#
proc set*(self: Vector2D, x: float = self.x, y: float = self.y): Vector2D =
  if (x == self.x and y == self.y):
    echo "err, no new vals passed"
  self.x = x
  self.y = y
  return self
proc set*(self: Vector3D, x: float = self.x, y: float = self.y, z: float = self.z): Vector3D =
  if (x == self.x and y == self.y and z == self.z):
    echo "err, no new vals passed"
  self.x = x
  self.y = y
  self.z = z
  return self

#[
  Add value to the vector
]#
proc add*(self: Vector2D, x: float = 0, y: float = 0): Vector2D =
  self.x += x
  self.y += y
  return self
proc add*(self: Vector3D, x: float = 0, y: float = 0, z: float = 0): Vector3D =
  self.x += x
  self.y += y
  self.z += z
  return self

#[
  Sub value from the vector
]#
proc sub*(self: Vector2D, x: float = 0, y: float = 0): Vector2D =
  self.x -= x
  self.y -= y
  return self
proc sub*(self: Vector3D, x: float = 0, y: float = 0, z: float = 0): Vector3D =
  self.x -= x
  self.y -= y
  self.z -= z
  return self

#TODO: check to ensure num isnt infinite for mult and divide procs
#[
  Multiply scalar to vector
]#
proc mult*(self: Vector2D, num: float): Vector2D =
  self.x *= num
  self.y *= num
  return self
proc mult*(self: Vector3D, num: float): Vector3D =
  self.x *= num
  self.y *= num
  self.z *= num
  return self

#[
  Divide vector by scalar
]#
proc divide*(self: Vector2D, num: float): Vector2D =
  self.x /= num
  self.y /= num
  return self
proc divide*(self: Vector3D, num: float): Vector3D =
  self.x /= num
  self.y /= num
  self.z /= num
  return self

#[
  Get vector squared magnitude
]#
proc magSq*(self: Vector2D): float =
  return (self.x*self.x)+(self.y*self.y)
proc magSq*(self: Vector3D): float =
  return (self.x*self.x)+(self.y*self.y)+(self.z*self.z)

#[
  Get vector magnitude
]#
proc mag*(self: Vector2D): float =
  return sqrt(self.magSq())
proc mag*(self: Vector3D): float =
  return sqrt(self.magSq())

#[
  Get the dot product of vector
]#
proc dot*(self: Vector2D, v: Vector2D): float =
  return (self.x * v.x) + (self.y * v.y)
proc dot*(self: Vector3D, v: Vector3D): float =
  return (self.x * v.x) + (self.y * v.y) + (self.z * v.z)

#[
  Get the cross product of vector3d
]#
proc cross*(self: Vector3D, v: Vector3D): Vector3D =
  let x = self.y * v.z - self.z * v.y
  let y = self.z * v.x - self.x * v.z
  let z = self.x * v.y - self.y * v.x

  return Vector(x,y,z)

#[
  Get euclidean distance between to vector points
]#
proc dist*(self: Vector2D, v: Vector2D): float =
  return v.copy().sub(self.x, self.y).mag()
proc dist*(self: Vector3D, v: Vector3D): float =
  return v.copy().sub(self.x, self.y, self.z).mag()

#[
  Normalize vector to length 1 (make it a unit vector)
]#
proc normalize*(self: Vector2D): Vector2D =
  let len = self.mag()
  if (len != 0):
    discard self.mult(1/len)
  return self
proc normalize*(self: Vector3D): Vector3D =
  let len = self.mag()
  if (len != 0):
    discard self.mult(1/len)
  return self

#[
  Limit magnitude of vector to provided value
]#
proc limit*(self: Vector2D, max: float): Vector2D =
  let mSq = self.magSq()
  if (mSq > max*max):
    discard self.divide(sqrt(mSq)).mult(max)
  return self
proc limit*(self: Vector3D, max: float): Vector3D =
  let mSq = self.magSq()
  if (mSq > max*max):
    discard self.divide(sqrt(mSq)).mult(max)
  return self

#[
  Set magnitude of vector to provided value
]#
proc setMag*(self: Vector2D, num: float): Vector2D =
  return self.normalize().mult(num)
proc setMag*(self: Vector3D, num: float): Vector3D =
  return self.normalize().mult(num)

#[
  Calculate angle of rotation for vector
]#
proc heading*(self: Vector2D): float =
  let h = arctan2(self.y, self.x)
  return h

#[
  Rotate vector by angle, 2d vectors only
]#
proc rotate*(self: Vector2D, angle: float): Vector2D =
  let newHeading = self.heading()+angle
  let mag = self.mag()
  self.x = cos(newHeading)*mag
  self.y = sin(newHeading)*mag
  return self

#[
  Return angle in rad between to vectors
]#
proc angleBetween*(self: Vector2D, v: Vector2D): float =
  let dotmagmag = self.dot(v) / (self.mag() * v.mag())
  # Clamp dotmagmag to [-1,1] due to float rounding issues to prevent acos NaN
  let angle = arccos(min(1, max(-1, dotmagmag)))
  return angle
proc angleBetween*(self: Vector3D, v: Vector3D): float =
  let dotmagmag = self.dot(v) / (self.mag() * v.mag())
  # Clamp dotmagmag to [-1,1] due to float rounding issues to prevent acos NaN
  let angle = arccos(min(1, max(-1, dotmagmag)))
  return angle

#[
  Linear interpolate between to vectors
  Between 0.0 (old vector) and 1.0 (new vector).
]#
proc lerp*(self: Vector2D, v: Vector2D, amt: float = 0): Vector2D =
  self.x += (v.x - self.x) * amt
  self.y += (v.y - self.y) * amt
  return self
proc lerp*(self: Vector3D, v: Vector3D, amt: float = 0): Vector2D =
  self.x += (v.x - self.x) * amt
  self.y += (v.y - self.y) * amt
  self.z += (v.z - self.z) * amt
  return self

#[
  Return a representation of this vector as a float array.
]#
proc array*(self: Vector2D): array[2, float] =
  return [self.x, self.y]
proc array*(self: Vector3D): array[3, float] =
  return [self.x, self.y, self.z]

#[
  Equality check vector
]#
proc equals*(self: Vector2D, v: Vector2D): bool =
  return (self.x == v.x and self.y == v.y)
proc equals*(self: Vector3D, v: Vector3D): bool =
  return (self.x == v.x and self.y == v.y and self.z == v.z)

#[
  Make 2D vector from angle
]#
proc fromAngle*(self: Vector2D, angle: float, length: float = 1): Vector2D =
  let v = Vector(length*cos(angle), length*sin(angle))
  discard self.set(v.x, v.y)
  return v