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
	#superclass : #RSAbstractBuilder,
	#instVars : [
		'objects',
		'values',
		'sumValues',
		'totalSum',
		'labelElements',
		'label'
	],
	#category : #'Roassal3-Pie-Core'
}

{ #category : #'accessing - computed' }
RSPieBuilder >> alphaAngleFor: e [
	values ifNil: [ self slice: #yourself ].
	
	^ (sumValues at: e index) * 360 / totalSum.
]

{ #category : #'accessing - computed' }
RSPieBuilder >> betaAngleFor: e [
	^ ((sumValues at: e index) + (values at: e index)) * 360 / totalSum.
]

{ #category : #initialization }
RSPieBuilder >> initialize [
	super initialize.
	shape := RSShapeBuilder arc
		onElement;
		innerRadius: 0;
		externalRadius: 100;
		color: [:e | e index even 
			ifTrue: [Color gray]
			ifFalse: [Color lightGray] ];
		alphaAngle: [:e | self alphaAngleFor: e ];
		betaAngle: [:e | self betaAngleFor: e ];
		onModel.
]

{ #category : #'accessing - computed' }
RSPieBuilder >> label [ 
	^ label ifNil: [ 
		label := RSPieLabelBuilder label
			builder: self;
			yourself.
		 ]
]

{ #category : #accessing }
RSPieBuilder >> labelElements [
	"return the labels created by this builder"
	^ labelElements 
]

{ #category : #accessing }
RSPieBuilder >> objects [
	^objects
]

{ #category : #public }
RSPieBuilder >> objects: someObjects [
	objects := someObjects
]

{ #category : #hooks }
RSPieBuilder >> renderIn: aView [
	aView addAll: (elements := shape elementsOn: objects).
	label ifNil: [ ^ self ].
	aView addAll: (labelElements := label elementsOn: objects).
]

{ #category : #public }
RSPieBuilder >> slice: aBlockOrASymbol [
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
	values := objects collect: aBlockOrASymbol.
	sumValues := Array new: objects size.
	tempSum := 0.
	values doWithIndex: [ :v :i |
		sumValues at: i put: tempSum.
		tempSum := tempSum + v
		 ].
	totalSum := tempSum.
]

{ #category : #'accessing - computed' }
RSPieBuilder >> totalSum [
	^ totalSum
]
