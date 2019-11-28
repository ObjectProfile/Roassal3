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
	#name : #RSPie,
	#superclass : #RSAbstractShapesBuilder,
	#instVars : [
		'objects',
		'values',
		'sumValues',
		'totalSum',
		'color',
		'segmentSpacing',
		'externalRadius',
		'innerRadius',
		'border',
		'cornerRadii'
	],
	#category : #'Roassal3-Pie-Core'
}

{ #category : #'accessing - computed' }
RSPie >> alphaAngleFor: anAsso [
	values ifNil: [ self slice: #yourself ].
	
	^ (sumValues at: anAsso key) * 360 / totalSum.
]

{ #category : #'accessing - computed' }
RSPie >> betaAngleFor: anAsso [
	^ ((sumValues at: anAsso key) + (values at: anAsso key)) * 360 / totalSum.
]

{ #category : #accessing }
RSPie >> border [
	^ border
]

{ #category : #accessing }
RSPie >> border: aBorder [
	border := aBorder
]

{ #category : #accessing }
RSPie >> color [
	^ color
]

{ #category : #accessing }
RSPie >> color: anObject [
	color := anObject 
	
]

{ #category : #accessing }
RSPie >> cornerRadii [
	^ cornerRadii
]

{ #category : #accessing }
RSPie >> cornerRadii: aNumber [
	cornerRadii := aNumber
]

{ #category : #accessing }
RSPie >> externalRadius [
	^ externalRadius
]

{ #category : #accessing }
RSPie >> externalRadius: aNumber [ 
	externalRadius := aNumber
]

{ #category : #initialization }
RSPie >> initialize [
	super initialize.
	self
		color: [ :as | as key even 
			ifTrue: [ Color lightGray ]
			ifFalse: [ Color gray ] ];
		segmentSpacing: 0;
		cornerRadii: 0;
		innerRadius: 0;
		externalRadius: 120.
		
]

{ #category : #accessing }
RSPie >> innerRadius [
	^ innerRadius
]

{ #category : #accessing }
RSPie >> innerRadius: aNumber [
	innerRadius := aNumber
]

{ #category : #'accessing - computed' }
RSPie >> label [ 
	^ label ifNil: [ 
		label := RSPieLabelDecorator label
			builder: self;
			yourself.
		 ]
]

{ #category : #accessing }
RSPie >> labelElements [
	"return the labels created by this builder"
	^ labelElements 
]

{ #category : #accessing }
RSPie >> objects [
	^ objects
]

{ #category : #public }
RSPie >> objects: someObjects [
	objects := someObjects collectWithIndex: [ :obj :index | index -> obj ]
]

{ #category : #accessing }
RSPie >> segmentSpacing [
	^ segmentSpacing
]

{ #category : #accessing }
RSPie >> segmentSpacing: aNumber [ 
	segmentSpacing := aNumber
]

{ #category : #hooks }
RSPie >> shapeFor: anAsso [
	^ RSPieSlice new
		innerRadius: self innerRadius;
		externalRadius: self externalRadius;
		model: anAsso value;
		color: (self color rsValue: anAsso);
		border: self border;
		cornerRadii: self cornerRadii;
		segmentSpacing: self segmentSpacing;
		popup;
		alphaAngle: (self alphaAngleFor: anAsso);
		betaAngle: (self betaAngleFor: anAsso);
		yourself
]

{ #category : #public }
RSPie >> slice: aBlockOrASymbol [
	"
	Set the way we give a pie share for each element.
	
Example:
-=-=-=-=-=-=
b := RSPieBuilder new.
    
b objects: (Set withAllSubclasses).
b shape interactionDo: #popup.
b slice: #numberOfMethods. 
b build.

RSNormalizer color
	elements: b elements;
	normalize: #numberOfMethods.
b open.
-=-=-=-=-=-=
"
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

{ #category : #'accessing - computed' }
RSPie >> totalSum [
	^ totalSum
]
