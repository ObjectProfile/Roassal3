[list of classes](reference.md)
# RSAthensRenderer
Roassal uses Athens (and therefore Cairo) to performs the rendering. The rendering in Roassal is modularized in the class `RSAthensRenderer`. The connection between Roassal and Athens is expressed by the class `RSAthensRenderer`.

The class `RSAthensRenderer` is essentially a visitor for a `RSCanvas`. The renderer visits the canvas and ultimately calls the Athens primitives for each visited shapes.

If you wish to add a new rendering engine (to produce a PDF file or use an alternative low level graphic engine such as Moz2D), you need to subclass the class `RSRenderer`.

`RSAthensRenderer` visits the canvas and its contained shapes to draw it in a AthensSurface.

*Responsibility*: invoke the low level primitives offered by Athens to render the visual aspect of shapes.

*Collaborators*: `RSAthensMorph` is using the class `RSAthensRenderer` to "draw" a `RSCanvas` instance.