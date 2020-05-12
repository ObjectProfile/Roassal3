[list of classes](reference.md)
# RSShape
`RSShape` is the root of all the Roassal shapes. A shape represents a visual element meant to be inserted in a `RSCanvas`. `RSShape` is an abstract class, not meant to be directly instantiated therefore.

*Responsibility*: A shape, i.e., subclass of the class `RSShape` is responsible to model a visual element. 

*Collaborators*: A shape is meaningful when inserted in a canvas

*Variables*:
- `paint`: the color of the Athens paint object used to render the visual shape
- `path`: refers to AthensCairoPath, which is a resource of a foreign object, ie., the cairo on
- `border`:
- `parent`: the parent shape
- `isFixed`: a boolean indicating if the shape is fixed (ie., not subject to the camera position and movement)