Class {
	#name : #RSParametricCurveTest,
	#superclass : #TestCase,
	#traits : 'TIceImagesExporting + RSTParametricXYLines',
	#classTraits : 'TIceImagesExporting classTrait + RSTParametricXYLines classTrait',
	#category : #'Roassal3-Examples'
}

{ #category : #examples }
RSParametricCurveTest >> exampleBaricentricCoordinates [

	<script: 'self new exampleBaricentricCoordinates open'>
	^ self sutBaricentricCoordinates: [ :points :param | 
		  | group |
		  group := self
			           groupBaricentricCoordinatesPoint: points first
			           anotherPoint: points second
			           baricentricPoint: points third
			           at: param.

		  RSCanvas new
			  addAll: group;
			  zoomToFit;
			  addInteraction: RSCanvasController new;
			  yourself ]
]

{ #category : #examples }
RSParametricCurveTest >> exampleBaricentricCoordinatesTriangle [

	<script: 'self new exampleBaricentricCoordinatesTriangle open'>
	^ self sutBaricentricCoordinatesTriangle: [ :points :param :anotherParam | 
		  | group |
		  group := self
			           groupBaricentricCoordinatesPoint: points first
			           anotherPoint: points second
			           yetAnotherPoint: points third
			           baricentricPoint: points fourth
			           at: param
			           at: anotherParam.

		  RSCanvas new
			  addAll: group;
			  zoomToFit;
			  addInteraction: RSCanvasController new;
			  yourself ]
]

{ #category : #utilities }
RSParametricCurveTest >> groupBaricentricCoordinatesPoint: aPoint anotherPoint: anotherPoint baricentricPoint: baricentricPoint at: param [

	| group aCircle anotherCircle baricentricCircle line currentBaricentric |
	currentBaricentric := baricentricPoint.

	group := RSGroup new.

	aCircle := RSCircle new
		           model: aPoint;
		           position: aPoint;
		           color: Color transparent;
		           withBorder;
		           draggable;
		           labeled;
		           yourself.

	anotherCircle := RSCircle new
		                 model: anotherPoint;
		                 position: anotherPoint;
		                 color: Color transparent;
		                 withBorder;
		                 draggable;
		                 labeled;
		                 yourself.

	baricentricCircle := RSCircle new
		                     model: currentBaricentric;
		                     position: currentBaricentric;
		                     color: Color transparent;
		                     withBorder;
		                     sameColorAsBorderColor;
		                     labeled;
		                     yourself.

	aCircle when: RSPositionChangedEvent do: [ :ev | 
		currentBaricentric := ev newPosition
			                      unitAffine: anotherCircle position
			                      at: param.
		baricentricCircle position: currentBaricentric ].

	anotherCircle when: RSPositionChangedEvent do: [ :ev | 
		currentBaricentric := aCircle position
			                      unitAffine: ev newPosition
			                      at: param.
		baricentricCircle position: currentBaricentric ].

	line := RSLine new
		        from: aCircle;
		        to: anotherCircle;
		        dotted;
		        yourself.

	^ group
		  add: aCircle;
		  add: anotherCircle;
		  add: baricentricCircle;
		  add: line;
		  yourself
]

{ #category : #utilities }
RSParametricCurveTest >> groupBaricentricCoordinatesPoint: aPoint anotherPoint: anotherPoint yetAnotherPoint: yetAnotherPoint baricentricPoint: baricentricPoint at: param at: anotherParam [

	| group aCircle anotherCircle thirdCircle baricentricCircle line |
	group := RSGroup new.

	aCircle := RSCircle new
		           model: aPoint;
		           position: aPoint;
		           color: Color transparent;
		           withBorder;
		           labeled;
		           yourself.

	anotherCircle := RSCircle new
		                 model: anotherPoint;
		                 position: anotherPoint;
		                 color: Color transparent;
		                 withBorder;
		                 labeled;
		                 yourself.

	thirdCircle := RSCircle new
		               model: yetAnotherPoint;
		               position: yetAnotherPoint;
		               color: Color transparent;
		               withBorder;
		               labeled;
		               yourself.

	baricentricCircle := RSCircle new
		                     model: baricentricPoint;
		                     position: baricentricPoint;
		                     color: Color transparent;
		                     withBorder;
		                     sameColorAsBorderColor;
		                     labeled;
		                     yourself.

	line := RSPolyline new
		        controlPoints: { 
				        aPoint.
				        anotherPoint.
				        yetAnotherPoint.
				        aPoint };
		        dotted;
		        yourself.

	^ group
		  add: aCircle;
		  add: anotherCircle;
		  add: thirdCircle;
		  add: baricentricCircle;
		  add: line;
		  add: (RSLine new
				   from: (aPoint unitAffine: yetAnotherPoint at: param);
				   to: (aPoint unitAffine: anotherPoint at: param);
				   dashed;
				   yourself);
		  add: (RSLine new
				   from: (anotherPoint unitAffine: aPoint at: anotherParam);
				   to: (anotherPoint unitAffine: yetAnotherPoint at: anotherParam);
				   dashed;
				   yourself);
		  add: (RSLine new
				   from:
					   (yetAnotherPoint
						    unitAffine: aPoint
						    at: 1 - param - anotherParam);
				   to:
					   (yetAnotherPoint
						    unitAffine: anotherPoint
						    at: 1 - param - anotherParam);
				   dashed;
				   yourself);
		  yourself
]

{ #category : #'systems under tests' }
RSParametricCurveTest >> sutBaricentricCoordinates: aBlock [

	| aPoint anotherPoint param baricentricPoint |
	aPoint := 100 @ 100.
	anotherPoint := 300 @ 400.
	param := 1 / 4.

	baricentricPoint := aPoint unitAffine: anotherPoint at: param.

	self assert: baricentricPoint equals: 250 @ 325.

	^ aBlock
		  value: { 
				  aPoint.
				  anotherPoint.
				  baricentricPoint }
		  value: param
]

{ #category : #'systems under tests' }
RSParametricCurveTest >> sutBaricentricCoordinatesTriangle: aBlock [

	| aPoint anotherPoint param baricentricPoint yetAnotherPoint anotherParam |
	aPoint := 100 @ 100.
	anotherPoint := 300 @ 400.
	yetAnotherPoint := -100 @ 250.

	param := 1 / 6.
	anotherParam := 1 / 2.

	baricentricPoint := aPoint
		                    unitAffine: anotherPoint
		                    at: param
		                    and: yetAnotherPoint
		                    at: anotherParam.

	self assert: baricentricPoint equals: 400 / 3 @ 300.

	^ aBlock
		  value: { 
				  aPoint.
				  anotherPoint.
				  yetAnotherPoint.
				  baricentricPoint }
		  value: param
		  value: anotherParam
]

{ #category : #tests }
RSParametricCurveTest >> testBaricentricCoordinates [

	self sutBaricentricCoordinates: [ :points :param | 
		| group |
		group := self
			         groupBaricentricCoordinatesPoint: points first
			         anotherPoint: points second
			         baricentricPoint: points third
			         at: param.

		self
			exportShapeOf: group
			accessorBlock: [ :aGroup | aGroup asShape ] ]
]

{ #category : #tests }
RSParametricCurveTest >> testBaricentricCoordinatesTriangle [

	self sutBaricentricCoordinatesTriangle: [ :points :param :anotherParam | 
		| group |
		group := self
			         groupBaricentricCoordinatesPoint: points first
			         anotherPoint: points second
			         yetAnotherPoint: points third
			         baricentricPoint: points fourth
			         at: param
			         at: anotherParam.

		self
			exportShapeOf: group
			accessorBlock: [ :aGroup | aGroup asShape ] ]
]

{ #category : #tests }
RSParametricCurveTest >> testLineDeCasteljauLineClosedControlPoints [

	self
		exportShapeOf:
		RSBasicShapeExamples new lineDeCasteljauLineClosedControlPoints
		accessorBlock: [ :aLine | aLine asGroupWithControlNet asShape ]
]

{ #category : #tests }
RSParametricCurveTest >> testLineDeCasteljauLineNoteBox [

	self
		exportShapeOf: RSBasicShapeExamples new lineDeCasteljauLineNoteBox
		accessorBlock: [ :aLine | aLine asGroupWithControlNet asShape ]
]

{ #category : #tests }
RSParametricCurveTest >> testLineParametricHypotrochoid [

	self exportShapeOf:
		RSBasicShapeExamples new lineParametricHypotrochoid
]

{ #category : #tests }
RSParametricCurveTest >> testLineParametricLissajous [

	self exportShapeOf: RSBasicShapeExamples new lineParametricLissajous
]

{ #category : #tests }
RSParametricCurveTest >> testLineParametricNeil [

	self exportShapeOf: RSBasicShapeExamples new lineParametricNeil
]

{ #category : #tests }
RSParametricCurveTest >> testLineParametricNeil2 [

	self exportShapeOf: RSBasicShapeExamples new lineParametricNeil2
]

{ #category : #tests }
RSParametricCurveTest >> testLineParametricTrochoid [

	self exportShapeOf: RSBasicShapeExamples new lineParametricTrochoid
]

{ #category : #tests }
RSParametricCurveTest >> testLineParametricUnitCircle [

	self exportShapeOf: RSBasicShapeExamples new lineParametricUnitCircle
]

{ #category : #tests }
RSParametricCurveTest >> testLinesDeCasteljauLineDegreeElevation [

	self
		exportShapeOf:
		RSBasicShapeExamples new linesDeCasteljauLineDegreeElevation
		accessorBlock: [ :aGroup | 
			| shapes |
			shapes := aGroup
				          with: { 
						          Color gray.
						          Color red.
						          Color blue.
						          Color brown }
				          collect: [ :aLine :aColor | 
					          (aLine asGroupWithControlNetColoured: aColor) asShape ].

			(RSGroup withAll: shapes) asShape ]
]

{ #category : #tests }
RSParametricCurveTest >> testNoteInteger [

	self exportShapeOf: RSBasicShapeExamples new noteInteger
]

{ #category : #tests }
RSParametricCurveTest >> testNoteLoremIpsum [

	self exportShapeOf: RSBasicShapeExamples new noteLoremIpsum
]

{ #category : #tests }
RSParametricCurveTest >> testParametricXYlineButterfly [

	self exportShapeOf: self parametricXYlineButterfly
]
