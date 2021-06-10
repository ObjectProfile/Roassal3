"
I am the basic pie builder, check my examples.

About me 
* My shape is an ""arc""... not really my shape is an instance of ""RSShapeBuilder arc""
* the default background color of each arc even
* I use a layout to set the arcs position 
* I also have a #label to create labels around my arcs

.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=
| b classes |
classes := { Array. String. Dictionary. Set }.
b := RSPieBuilder new.
b objects: classes.
b slice: #numberOfMethods.s
b build.
b open
.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=
"
Class {
	#name : #RSPieBuilder,
	#superclass : #RSAbstractShapesBuilder,
	#instVars : [
		'objects',
		'values',
		'sumValues',
		'totalSum',
		'sliceShape',
		'sliceColor'
	],
	#category : #'Roassal3-Pie-Core'
}

{ #category : #'accessing - computed' }
RSPieBuilder >> alphaAngleFor: aShape [
	values ifNil: [ self slice: #yourself ].
	^ (sumValues at: aShape index) * 360 / totalSum.
]

{ #category : #'accessing - computed' }
RSPieBuilder >> betaAngleFor: aShape [
	^ ((sumValues at: aShape index) + (values at: aShape index )) * 360 / totalSum.
]

{ #category : #initialization }
RSPieBuilder >> initialize [
	super initialize.
	self sliceColor: [ :slice | 
		slice index even 
			ifTrue: [ Color lightGray ]
			ifFalse: [ Color gray ] ].
	sliceShape := RSPieSlice new
		segmentSpacing: 0;
		cornerRadii: 0;
		innerRadius: 0;
		externalRadius: 120.
]

{ #category : #accessing }
RSPieBuilder >> objects [
	^ objects
]

{ #category : #accessing }
RSPieBuilder >> objects: someObjects [
	objects := someObjects
]

{ #category : #hooks }
RSPieBuilder >> shapeFor: anObject [
	| slice |
	slice := self sliceShape copy.
	slice
		model: anObject;
		color: (self sliceColor rsValue: slice);
		alphaAngle: (self alphaAngleFor: slice);
		betaAngle: (self betaAngleFor: slice);
		popup.
	^ slice
]

{ #category : #hooks }
RSPieBuilder >> shapeFor: anObject index: index [
	| slice |
	slice := self sliceShape copy.
	slice
		model: anObject;
		index: index;
		color: (self sliceColor rsValue: slice);
		alphaAngle: (self alphaAngleFor: slice);
		betaAngle: (self betaAngleFor: slice);
		popup.
	^ slice
]

{ #category : #public }
RSPieBuilder >> slice: aBlockOrASymbol [
	"Set the way we give a pie share for each element."
	| tempSum |
	values := objects collect: [:m | aBlockOrASymbol value: m value ] as: Array.
	sumValues := Array new: objects size.
	tempSum := 0.
	values doWithIndex: [ :v :i |
		sumValues at: i put: tempSum.
		tempSum := tempSum + v
		 ].
	totalSum := tempSum.
]

{ #category : #accessing }
RSPieBuilder >> sliceColor [
	^ sliceColor
]

{ #category : #accessing }
RSPieBuilder >> sliceColor: anObject [
	"a block or object that can anwser rsValue:"
	sliceColor := anObject 
	
]

{ #category : #accessing }
RSPieBuilder >> sliceShape [
	"you can modify with simples values all atributes of slices except color and angles"
	"review #sliceColor and #slice:"
	^ sliceShape
]

{ #category : #'accessing - computed' }
RSPieBuilder >> totalSum [
	^ totalSum
]

{ #category : #accessing }
RSPieBuilder >> values [
	^ values
]
