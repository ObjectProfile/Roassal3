Extension { #name : #RSShapeFactory }

{ #category : #'*Roassal3-Shapes' }
RSShapeFactory class >> arc [
	^ RSPieSlice new
]

{ #category : #'*Roassal3-Shapes' }
RSShapeFactory class >> arrow [
	"inverted vee"
	^ self polygonWithPoints: (Array
		with: 1 @ 1
		with: 0 @ 0.333
		with: -1 @ 1
		with: 0 @ -1)
]

{ #category : #'*Roassal3-Shapes' }
RSShapeFactory class >> bitmap [
	^ RSBitmap new
]

{ #category : #'*Roassal3-Shapes' }
RSShapeFactory class >> box [
	^ self rectangle
]

{ #category : #'*Roassal3-Shapes' }
RSShapeFactory class >> circle [
	^ self ellipse
]

{ #category : #'*Roassal3-Shapes' }
RSShapeFactory class >> composite [ 
	^ RSComposite new
]

{ #category : #'*Roassal3-Shapes' }
RSShapeFactory class >> cross [
	| t t1 |
	t := 2 / 6 asFloat.
	t1 := t negated.
	^ self polygonWithPoints:
		{(-1 @ t1).
		(t1 @ t1).
		(t1 @ -1).
		(t @ -1).
		(t @ t1).
		(1 @ t1).
		(1 @ t).
		(t @ t).
		(t @ 1).
		(t1@ 1).
		(t1@ t).
		(-1@ t)}
]

{ #category : #'*Roassal3-Shapes' }
RSShapeFactory class >> diamond [
	^ self polygonWithPoints: (Array
		with: 0 @ 1
		with: 1 @ 0
		with: 0 @ -1
		with: -1 @ 0)
]

{ #category : #'*Roassal3-Shapes' }
RSShapeFactory class >> ellipse [
	^ RSEllipse new
]

{ #category : #'*Roassal3-Shapes' }
RSShapeFactory class >> heptagon [
	^ self polygonWithPoints: (RSPolygon generatePointsFitSquare: 7)
]

{ #category : #'*Roassal3-Shapes' }
RSShapeFactory class >> hexagon [
	^ self polygonWithPoints: (RSPolygon generatePointsFitSquare: 6)
]

{ #category : #'*Roassal3-Shapes' }
RSShapeFactory class >> label [
	^ RSLabel new
]

{ #category : #'*Roassal3-Shapes' }
RSShapeFactory class >> octagon [
	^ self polygonWithPoints: (RSPolygon generatePointsFitSquare: 8)
]

{ #category : #'*Roassal3-Shapes' }
RSShapeFactory class >> pentagon [
	^ self polygonWithPoints: (RSPolygon generatePointsFitSquare: 5)
]

{ #category : #'*Roassal3-Shapes' }
RSShapeFactory class >> polygon [
	^ RSPolygon new
]

{ #category : #'*Roassal3-Shapes' }
RSShapeFactory class >> polygonWithPoints: points [
	^ self polygon
		privatePoints: points;
		yourself
]

{ #category : #'*Roassal3-Shapes' }
RSShapeFactory class >> rectangle [
	^ RSBox new
]

{ #category : #'*Roassal3-Shapes' }
RSShapeFactory class >> rhomboid [
	^ self polygonWithPoints: (Array
		with: -1 @ -1
		with: 0.333 @ -1
		with: 1 @ 1
		with: -0.333 @ 1)
]

{ #category : #'*Roassal3-Shapes' }
RSShapeFactory class >> square [
	^ self polygonWithPoints: (RSPolygon generatePointsFitSquare: 4)
]

{ #category : #'*Roassal3-Shapes' }
RSShapeFactory class >> star [
	| star5Points outerPoints innerPoints innerRadius ar |
	star5Points := Array new: 10.
	outerPoints := RSPolygon generateUnitNgonPoints: 5 rotation: 0.
	innerPoints := RSPolygon generateUnitNgonPoints: 5 rotation: Float pi / -5.
	"Outer radius is 1; inner radius of star is smaller"
	innerRadius := 0.5.
	innerPoints
		doWithIndex: [ :p :i | innerPoints at: i put: (p x * innerRadius) @ (p y * innerRadius) ].
	star5Points
		doWithIndex: [ :p :i | 
			ar := i even
				ifTrue: [ outerPoints ]
				ifFalse: [ innerPoints ].
			star5Points at: i put: (ar at: i // 2 + (i % 2)) ].
	star5Points := RSPolygon fitPolygonToSquare: star5Points.
	^ self polygonWithPoints: star5Points
]

{ #category : #'*Roassal3-Shapes' }
RSShapeFactory class >> svgPath [
	^ RSSVGPath new
]

{ #category : #'*Roassal3-Shapes' }
RSShapeFactory class >> triangle [
	^ self polygonWithPoints: (RSPolygon generatePointsFitSquare: 3)
]

{ #category : #'*Roassal3-Shapes' }
RSShapeFactory class >> vee [
	^ self polygonWithPoints: (Array
		with: -1 @ -1
		with: 0 @ -0.333
		with: 1 @ -1
		with: 0 @ 1)
]
