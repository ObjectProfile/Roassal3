"
I can create shapes for roassal based on a model
"
Class {
	#name : #RSShapeBuilder,
	#superclass : #RSAbstractShapeBuilder,
	#category : #'Roassal3-Core'
}

{ #category : #'instance creation' }
RSShapeBuilder class >> arc [
	"TODO find the best name, ring, arc, circle sector, ellipse segment, foobar, etc"
	^ self new
		shapeClass: TSPieSlice;
		yourself 
]

{ #category : #'instance creation - polygon' }
RSShapeBuilder class >> arrow [
	"inverted vee"
	^ self polygonWithPoints: (Array
		with: 1 @ 1
		with: 0 @ 0.333
		with: -1 @ 1
		with: 0 @ -1)
]

{ #category : #'instance creation' }
RSShapeBuilder class >> bitmap [
	 ^ self new
		innerClass: TSBitmap;
		elementClass: RSElement;
		yourself 
]

{ #category : #'instance creation' }
RSShapeBuilder class >> box [
	^ self rectangle
]

{ #category : #'instance creation' }
RSShapeBuilder class >> circle [
	^ self ellipse
]

{ #category : #'instance creation' }
RSShapeBuilder class >> composite [
	^ self new
		innerClass: TSComposite;
		elementClass: RSElement;
		yourself 
]

{ #category : #'instance creation - polygon' }
RSShapeBuilder class >> cross [
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

{ #category : #'instance creation - polygon' }
RSShapeBuilder class >> diamond [
	^ self polygonWithPoints: (Array
		with: 0 @ 1
		with: 1 @ 0
		with: 0 @ -1
		with: -1 @ 0)
]

{ #category : #'instance creation' }
RSShapeBuilder class >> ellipse [
	^ self new
		shapeClass: TSEllipse;
		yourself 
]

{ #category : #'instance creation - polygon' }
RSShapeBuilder class >> heptagon [
	^ self polygonWithPoints: (TSPolygon generatePointsFitSquare: 7)
]

{ #category : #'instance creation - polygon' }
RSShapeBuilder class >> hexagon [
	^ self polygonWithPoints: (TSPolygon generatePointsFitSquare: 6)
]

{ #category : #'instance creation' }
RSShapeBuilder class >> label [

"Here is an exampe on how to use it
-=-=-=-=-=
v := RSView new.
v @ RSControlsView.

sb := RSShapeBuilder label.
sb interactionDo: #draggable.
sb text: #asString.
elements := sb elementsOn: (Collection withAllSubclasses).

elements do: [ :e | e translateTo: (Random new nextInt: 300) @ (Random new nextInt: 300) ].
v addAll: elements.

RSNormalizer fontSize
	elements: elements;
	to: 30;
	normalize: #numberOfMethods.

v zoomToFit.
v open
-=-=-=-=-=
"

	^ self new
		innerClass: TSLabel;
		elementClass: RSElement;
		color: Color black;
		addAction: (RSAction new action: [:el | 
			| text tshape |
			tshape := el trachelShape.
			text := tshape text.
			text ifNil: [ text := el model ].
			tshape text: text asString ] ) 
		yourself 
]

{ #category : #'instance creation' }
RSShapeBuilder class >> multiline [ 
	| shape |
	shape := self label.
	shape addAction:  (RSAction new action: [:e |
		| tshape composite |
		tshape := e trachelShape.
		composite := TSComposite new.
		composite addAll: (tshape text lines collect: [:line |
			| label |
			label := tshape copy.
			label initializeMatrix. 
			label text: (line copyReplaceAll: String tab with: '   ').
			label announcer: nil.
			label ]).
		
		RSVerticalLineLayout new 
			alignLeft; 
			gapSize: 0; 
			on: composite shapes.
		composite announcer: tshape announcer.
		composite adjustToChildren.
		e privateTrachelShape: composite.
		 ]).
	^ shape
]

{ #category : #'instance creation - polygon' }
RSShapeBuilder class >> octagon [
	^ self polygonWithPoints: (TSPolygon generatePointsFitSquare: 8)
]

{ #category : #'instance creation - polygon' }
RSShapeBuilder class >> pentagon [
	^ self polygonWithPoints: (TSPolygon generatePointsFitSquare: 5)
]

{ #category : #'instance creation' }
RSShapeBuilder class >> polygon [
	^ self new
		innerClass: TSPolygon;
		elementClass: RSElement;
		yourself 
]

{ #category : #'instance creation - polygon' }
RSShapeBuilder class >> polygonWithPoints: points [
	 ^ self polygon
		privatePoints: points;
		yourself 
]

{ #category : #'instance creation' }
RSShapeBuilder class >> rectangle [
	^ self new
		shapeClass: TSBox;
		yourself 
]

{ #category : #'instance creation - polygon' }
RSShapeBuilder class >> rhomboid [
	^ self polygonWithPoints: (Array
		with: -1 @ -1
		with: 0.333 @ -1
		with: 1 @ 1
		with: -0.333 @ 1)
]

{ #category : #'instance creation - polygon' }
RSShapeBuilder class >> square [
	^ self polygonWithPoints: (TSPolygon generatePointsFitSquare: 4)
]

{ #category : #'instance creation - polygon' }
RSShapeBuilder class >> star [
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

{ #category : #'instance creation' }
RSShapeBuilder class >> svgPath [
	^ self new
		innerClass: TSSVGPath;
		elementClass: RSElement;
		yourself 
]

{ #category : #'instance creation - polygon' }
RSShapeBuilder class >> triangle [
	^ self polygonWithPoints: (TSPolygon generatePointsFitSquare: 3)
]

{ #category : #'instance creation - polygon' }
RSShapeBuilder class >> vee [
	^ self polygonWithPoints: (Array
		with: -1 @ -1
		with: 0 @ -0.333
		with: 1 @ -1
		with: 0 @ 1)
]

{ #category : #'public - accessing' }
RSShapeBuilder >> elementOn: object index: index [
	^ self basicElementOn: object index: index
]

{ #category : #accessing }
RSShapeBuilder >> shapeClass [
	^ self innerClass 
]

{ #category : #accessing }
RSShapeBuilder >> shapeClass: aClass [
	self innerClass: aClass;
		elementClass: RSElement;
		size: 5;
		color: Color gray
]
