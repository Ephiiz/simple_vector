# simple_vector
simple_vector is a vector library for easy use of simple 2D and 3D vectors in nim-lang.

## Usage
The use of the `Vector(x, y, z?)` procedure allows for the creation of both 2D and 3D vectors, by optionally passing a z argument.

```nim
import simple_vector

let v2d = Vector(x: 0, y: 0)        # Create Vector2D by not passing a z argument
let v3d = Vector(x: 0, y: 0, z: 0)  # Create Vector3D by passing a z argument
echo v2d.toString()                 # Returns vector in string representation: "[0.0000, 0.0000]"
let v2d_array = v2d.array()         # Vector in array representation
let v2d_equal = v2d.equals(Vector(2,2))  # Return bool based on if the vectors provided are the same

discard v2d.set(x: 2, y: 3)

# Vector objects have several mathematical methods available as well.
discard v2d.add(x: 5, y: 0)
discard v2d.sub(x: 2, y: 3)

discard v2d.mult(num: 3)
discard v2d.divide(num: 2)

let v2d_magnitude = v2d.mag()

let v2d_dotProduct = v2d.dot(Vector(3,4))
let v3d_crossProduct = v3d.cross(Vector(1,1,1))

let v2d_euclidDistance = v2d.dist() # Find euclidean distance between two vectors

discard v2d.normalize()             # Normalize vector to length 1 (make it a unit vector)
discard v2d.limit(max: 4)           # Limit magnitude of vector to max
discard v2d.setMag(num: 2)          # Set magnitude of vector to provided num

let v2d_heading = v2d.heading()     # Get vector angle of rotation
discard v2d_rotate = v2d.rotate(angle: 0)    # Rotate 2D vector by angle in rad

let v2d_angleBetween = v2d.angleBetween(Vector(2,2))

let v2d_interpolateBetween = v2d.lerp(Vector(2,2), 0.6)  # Interpolate between two vectors by amount, with 0.0 being the start vector and 1.0 being the end vector


```
