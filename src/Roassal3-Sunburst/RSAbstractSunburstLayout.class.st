"
I am the abstract class for sunburst visualizations in Roassal2, check my subclasses 

* RTSunburstConstanWidthLayout
* RtSunburstExtentLayout

You can use this layout in with RTLayoutBuilder or with RTSunburstBuilder
and their examples to get more info
"
Class {
	#name : #RSAbstractSunburstLayout,
	#superclass : #RSLayout,
	#instVars : [
		'hasCenter',
		'radialSpacing',
		'builder',
		'firstNode'
	],
	#category : #'Roassal3-Sunburst'
}

{ #category : #testing }
RSAbstractSunburstLayout class >> isAbstract [

	^ self == RSAbstractSunburstLayout
]

{ #category : #accessing }
RSAbstractSunburstLayout >> builder [
	^ builder
]

{ #category : #accessing }
RSAbstractSunburstLayout >> builder: aSunburstBuilder [
	builder := aSunburstBuilder
]

{ #category : #hook }
RSAbstractSunburstLayout >> doExecute: shapes [
	| virtual |
	shapes isEmpty ifTrue: [ ^  self ].
	firstNode := true.
	shapes size = 1 ifTrue: [
		^ self layoutSunburst: shapes first ].
	virtual := RSPieSlice new.
	virtual schildren: shapes.
	shapes do: [ :shape | shape sparent: virtual ].
	virtual sparent: nil.
	virtual depth: 0.
	self layoutSunburst: virtual.
	shapes do: [ :shape | shape sparent: nil ]
]

{ #category : #accessing }
RSAbstractSunburstLayout >> hasCenter [
	^ hasCenter
]

{ #category : #accessing }
RSAbstractSunburstLayout >> hasCenter: aBool [
	hasCenter := aBool
]

{ #category : #initialization }
RSAbstractSunburstLayout >> initialize [
	super initialize.
	self
		hasCenter: true;
		radialSpacing: 5
]

{ #category : #hook }
RSAbstractSunburstLayout >> layoutSunburst: shape [
	self
		setRadius: shape;
		setChildrenAngles: shape
]

{ #category : #accessing }
RSAbstractSunburstLayout >> radialSpacing [
	^ radialSpacing
]

{ #category : #accessing }
RSAbstractSunburstLayout >> radialSpacing: aNumber [
	radialSpacing := aNumber
]

{ #category : #hook }
RSAbstractSunburstLayout >> setCenterRadius: shape [
	self subclassResponsibility
]

{ #category : #hook }
RSAbstractSunburstLayout >> setChildrenAngles: shape [
	| children parentAngle angleOffset parentWeight |
	children := shape schildren.
	parentAngle := shape alphaAngle.
	parentWeight := builder weightOf: shape.
	angleOffset := (shape betaAngle - shape alphaAngle) / parentWeight.
	children doWithIndex: [ :child :index |
		| a b |
		a := parentAngle.
		b := angleOffset * (builder weightOf: child) + a.
		child
			alphaAngle: a;
			betaAngle: b.
		self layoutSunburst: child.
		parentAngle := b. ]
]

{ #category : #hook }
RSAbstractSunburstLayout >> setNormalRadius: shape [
	self subclassResponsibility
]

{ #category : #hook }
RSAbstractSunburstLayout >> setRadius: shape [
	firstNode
		ifTrue: [
			self hasCenter
				ifTrue: [ self setCenterRadius: shape ].
			shape betaAngle: 360. ]
		ifFalse: [ self setNormalRadius: shape ].
	firstNode := false
]
