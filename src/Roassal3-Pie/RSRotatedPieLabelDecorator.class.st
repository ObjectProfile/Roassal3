"
I am a specific interaction based on the example23RotatedAnimation
"
Class {
	#name : #RSRotatedPieLabelDecorator,
	#superclass : #RSAbstractPieDecorator,
	#instVars : [
		'labels',
		'lines',
		'animation'
	],
	#category : #'Roassal3-Pie-Decorators'
}

{ #category : #rendering }
RSRotatedPieLabelDecorator >> createAnimation [
	animation := builder container newAnimation
		from: 0;
		to: 360;
		repeat;
		duration: 15 seconds;
		onStepDo: [ :t | self stepShapes: t ]
]

{ #category : #rendering }
RSRotatedPieLabelDecorator >> createLabels [
	labels := builder objects collect: [ :obj |
		RSLabel new
			text: obj;
			yourself ]
]

{ #category : #rendering }
RSRotatedPieLabelDecorator >> createLines [
	lines := builder objects collect: [ :obj |
		RSPolyline new
			dashArray: #( 4 );
			yourself ]
]

{ #category : #rendering }
RSRotatedPieLabelDecorator >> render [
	| container |
	self createLabels.
	self createLines.
	container := self builder container.
	container
		addAll: lines;
		addAll: labels.
	builder shapes when: RSMouseClick do: [ animation toggle ].
	self createAnimation.
	self stepShapes: 0
]

{ #category : #rendering }
RSRotatedPieLabelDecorator >> stepShapes: t [
	builder shapes doWithIndex: [ :shape :index |
		  | a b label ang ext x p1 p2 p3 line |
		  a := shape propertyAt: #a ifAbsentPut: [ shape alphaAngle ].
		  b := shape propertyAt: #b ifAbsentPut: [ shape betaAngle ].
		  shape
			  alphaAngle: a + t;
			  betaAngle: b + t.
		  label := labels at: index.
		  ang := shape alphaAngle + shape betaAngle / 2 % 360.
		  ext := label extent x / 2 @ 0.
		  x := -250.
		  (ang between: 90 and: 270) ifFalse: [
			  ext := ext negated.
			  x := x negated ].
		  p1 := shape centroid: 0.
		  p2 := shape centroid: 50.
		  p3 := x @ p2 y.
		  line := lines at: index.
		  line shape controlPoints: {
				  p1.
				  p2.
				  p3 }.
		  label position: p3 - ext ]
]
