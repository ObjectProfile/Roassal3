Extension { #name : #TSShape }

{ #category : #'*Roassal3-Shapes' }
TSShape class >> arc [
	^ TSPieSlice new
]

{ #category : #'*Roassal3-Shapes' }
TSShape class >> arrow [
	"inverted vee"
	^ self polygonWithPoints: (Array
		with: 1 @ 1
		with: 0 @ 0.333
		with: -1 @ 1
		with: 0 @ -1)
]

{ #category : #'*Roassal3-Shapes' }
TSShape class >> bitmap [
	^ TSBitmap new
]

{ #category : #'*Roassal3-Shapes' }
TSShape class >> box [
	^ self rectangle
]

{ #category : #'*Roassal3-Shapes' }
TSShape class >> circle [
	^ self ellipse
]

{ #category : #'*Roassal3-Shapes' }
TSShape class >> composite [ 
	^ TSComposite new
]

{ #category : #'*Roassal3-Shapes' }
TSShape class >> cross [
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
TSShape class >> diamond [
	^ self polygonWithPoints: (Array
		with: 0 @ 1
		with: 1 @ 0
		with: 0 @ -1
		with: -1 @ 0)
]

{ #category : #'*Roassal3-Shapes' }
TSShape class >> ellipse [
	^ TSEllipse new
]

{ #category : #'*Roassal3-Shapes' }
TSShape class >> heptagon [
	^ self polygonWithPoints: (TSPolygon generatePointsFitSquare: 7)
]

{ #category : #'*Roassal3-Shapes' }
TSShape class >> hexagon [
	^ self polygonWithPoints: (TSPolygon generatePointsFitSquare: 6)
]

{ #category : #'*Roassal3-Shapes' }
TSShape class >> label [
	^ TSLabel new
]

{ #category : #'*Roassal3-Shapes' }
TSShape class >> octagon [
	^ self polygonWithPoints: (TSPolygon generatePointsFitSquare: 8)
]

{ #category : #'*Roassal3-Shapes' }
TSShape class >> pentagon [
	^ self polygonWithPoints: (TSPolygon generatePointsFitSquare: 5)
]

{ #category : #'*Roassal3-Shapes' }
TSShape class >> polygon [
	^ TSPolygon new
]

{ #category : #'*Roassal3-Shapes' }
TSShape class >> polygonWithPoints: points [
	^ self polygon
		privatePoints: points;
		yourself
]

{ #category : #'*Roassal3-Shapes' }
TSShape class >> rectangle [
	^ TSBox new
]

{ #category : #'*Roassal3-Shapes' }
TSShape class >> rhomboid [
	^ self polygonWithPoints: (Array
		with: -1 @ -1
		with: 0.333 @ -1
		with: 1 @ 1
		with: -0.333 @ 1)
]

{ #category : #'*Roassal3-Shapes' }
TSShape class >> square [
	^ self polygonWithPoints: (TSPolygon generatePointsFitSquare: 4)
]

{ #category : #'*Roassal3-Shapes' }
TSShape class >> star [
	| star5Points outerPoints innerPoints innerRadius ar |
	star5Points := Array new: 10.
	outerPoints := TSPolygon generateUnitNgonPoints: 5 rotation: 0.
	innerPoints := TSPolygon generateUnitNgonPoints: 5 rotation: Float pi / -5.
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
	star5Points := TSPolygon fitPolygonToSquare: star5Points.
	^ self polygonWithPoints: star5Points
]

{ #category : #'*Roassal3-Shapes' }
TSShape class >> svgPath [
	^ TSSVGPath new
]

{ #category : #'*Roassal3-Shapes' }
TSShape class >> triangle [
	^ self polygonWithPoints: (TSPolygon generatePointsFitSquare: 3)
]

{ #category : #'*Roassal3-Shapes' }
TSShape class >> vee [
	^ self polygonWithPoints: (Array
		with: -1 @ -1
		with: 0 @ -0.333
		with: 1 @ -1
		with: 0 @ 1)
]
