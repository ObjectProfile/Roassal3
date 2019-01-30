Class {
	#name : #TSAthensMorph,
	#superclass : #Morph,
	#instVars : [
		'renderer',
		'session',
		'surface',
		'isDrawing',
		'trachelCanvas'
	],
	#category : #'Roassal3-Trachel'
}

{ #category : #accessing }
TSAthensMorph >> canvas [
	^ trachelCanvas
]

{ #category : #accessing }
TSAthensMorph >> canvas: aTrachelCanvas [
	trachelCanvas := aTrachelCanvas
]

{ #category : #'session management' }
TSAthensMorph >> checkSession [
	session == Smalltalk session
		ifFalse: [ 
			surface := nil.
			self createSurface ]
]

{ #category : #'surface management' }
TSAthensMorph >> createSurface [
	surface := AthensCairoSurface extent: self extent asIntegerPoint.
	session := Smalltalk session.
]

{ #category : #drawing }
TSAthensMorph >> drawOn: aCanvas [
	"aCanvas is a FormCanvas"
	| f |
	"#drawOn: cannot be reintrant"
	isDrawing ifTrue: [ ^ self ].
	isDrawing := true. 
	self checkSession.

	self recreateSurfaceIfNecessary.
	aCanvas fillRectangle: bounds color: trachelCanvas color. 
	
	"The drawing has to be done when a change in the shapes occured or when there is an animation."
	surface drawDuring: [:athensCanvas |
		surface clear.
		"We display the elements that are subject to the camera"
		athensCanvas pathTransform
			translateBy: (self extent / 2) asFloatPoint;
			    scaleBy: trachelCanvas camera scale asFloat;
			translateBy: trachelCanvas camera position negated asFloatPoint.
		renderer canvas: athensCanvas.
		trachelCanvas shapes do: [ :trachelShape |
			trachelShape accept: renderer.
		].
	
		"We display the elements that are _NOT_ subject to the camera"
		athensCanvas pathTransform loadIdentity scaleBy: 1.001.
		trachelCanvas fixedShapes do: [ :trachelShape |
			trachelShape drawOn: athensCanvas.
		].
	].
	"aCanvas translucentImage: surface asForm at: self bounds origin."
	"asForm creates a new Form, which is likely to be expensive. This can be cached"
	surface hasBeenFreed ifTrue: [ self createSurface ].
	f := surface asForm.
"
	aCanvas image: f at: self bounds origin sourceRect: (0 @ 0 extent: surface extent) rule: 34.
"
	"surface displayOnMorphicCanvas: aCanvas at: self position."
	[ aCanvas image: f at: self bounds origin asIntegerPoint sourceRect: (0 @ 0 extent: surface extent) rule: 34 ]
		on: Exception "PrimitiveFailed"
		do: [ :ex | "Maybe just memory object pinning issue so skipping a single paint cycle" ].

	isDrawing := false.
]

{ #category : #drawing }
TSAthensMorph >> drawOnMockCanvas [
	"This method is used to trigger all the rendering in a temporary FormCanvas. This method is useful when a bug happens when rendering. Such situation are difficult to debug to the multi-threading and low level graphical primitive. The method #drawOnMockCanvas helps addressing this.

Here is an example:
v := RTView new.
es := RTBox elementsOn: (1 to: 10).
v addAll: es.
RTGridLayout on: es.
v canvas buildMorph drawOnMockCanvas

	"
	self drawOn: (FormCanvas extent: self extent)
]

{ #category : #initialization }
TSAthensMorph >> initialize [
	super initialize.
	self createSurface.
	session := Smalltalk session.
	isDrawing := false
]

{ #category : #accessing }
TSAthensMorph >> open [

	
]

{ #category : #'surface management' }
TSAthensMorph >> recreateSurfaceIfNecessary [
	surface
		ifNotNil: [ self extent asIntegerPoint ~= surface extent
				ifTrue: [ self createSurface.
					trachelCanvas extent: self extent ] ]
]

{ #category : #accessing }
TSAthensMorph >> renderer [
	^ renderer
]

{ #category : #accessing }
TSAthensMorph >> renderer: aRenderer [
	renderer := aRenderer
]
