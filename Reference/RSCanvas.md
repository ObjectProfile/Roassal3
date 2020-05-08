Roassal keeps its shapes (i.e., instance of a subclass of `RSShape`) into a canvas. The class `RSCanvas` implements the Roassal canvas.

Responsibility:

Collaborators:

Variables:
`shapes` keeps a collection of shapes (i.e., instance of a subclass of `RSShape`) as an instance of `RSGroup`. Shapes contained in `shapes` are considered as non-fixed, which means that they are subject to the camera.

`fixedShapes` is an instance of `RSGroup` that contains "fixed" shapes. A fixed shape is a shape that is not subject to the state of the camera. A fixed shape remains at the same position, independently if the canvas is scrolled.

`color` is an instance of the Pharo class `Color` and is used to paint the background.

`morph` refers to an instance of the class `RSAthensMorph`, which is the object that intersects Roassal and Morphic.

`camera` refers to the camera of the canvas.

`clearBackground` is a boolean indicating whether the background must be cleared at each refresh. This is useful sometime to obtain some interesting visual effects.