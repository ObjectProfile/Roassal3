[list of classes](reference.md)
# RSCamera
All shapes in Roassal are contained in a `RSCanvas`. The canvas has an infinite 2D dimension. The portion of the canvas that is visible within the window is given by a camera. `RSCamera` describes a camera in Roassal. A camera has a scale and a position.

*Responsibility*: identify the portion and the zoom level of a canvas that must be visible. Whenever the canvas is scrolled with the mouse or the key, then the camera is responsible for this.

*Collaborators*: A `RSCanvas` has a `RSCamera`. 

*Variables*:
`position` is a point representing coordinates of the canvas on which the viewing window frame will be centered. Position can be changes with the method `#translateBy:` and `#translateTo:`. Both methods accept canvas based coordinates

`scale` defines a magnitude of zooming applied to the canvas and its elements.

*Example*:
```Smalltalk
c := RSCanvas new.
1 to: 100 do: [ :i |
	| g |
	g := RSGroup new.
	g add: (RSEllipse new size: 30; color: Color gray lighter).
	g add: (RSLabel new text: i).
	c add: g asShape ].
RSGridLayout on: c shapes.
camera := c canvas camera.
camera translateBy: 500 @ 50.
camera scale: 0.5.
c
```