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
		'sum'
	],
	#category : #'Roassal3-Pie-Core'
}

{ #category : #'accessing - computed' }
RSPieBuilder >> alphaAngleFor: e [
	| temporalSum |
	values ifNil: [ self slice: #yourself ].
	temporalSum := 0.
	1 to: e index-1 do: [ :i |
		temporalSum := temporalSum + values at: i
		 ].
	^ temporalSum * 360 / sum
]

{ #category : #'accessing - computed' }
RSPieBuilder >> betaAngleFor: e [
	| temporalSum |
	temporalSum := 0.
	1 to: e index do: [ :i |
		temporalSum := temporalSum + values at: i
	].
	^ temporalSum * 360 / sum
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
	aView addAll: (elements := shape elementsOn: objects)
]

{ #category : #public }
RSPieBuilder >> slice: aBlockOrASymbol [
	values := objects collect: aBlockOrASymbol.
	sum := values sum.
]
