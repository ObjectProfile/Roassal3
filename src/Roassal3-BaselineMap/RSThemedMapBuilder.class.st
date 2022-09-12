"
Used to have custom colors and  with theme
"
Class {
	#name : #RSThemedMapBuilder,
	#superclass : #RSMapBuilder,
	#category : #'Roassal3-BaselineMap-Customs'
}

{ #category : #'accessing - defaults' }
RSThemedMapBuilder >> defaultContainer [
	| theme |
	theme := self theme.
	^ RSCanvas new 
		color: theme backgroundColor;
		addInteraction: (RSCanvasController new
			noLegend;
			yourself);
		yourself
]

{ #category : #'accessing - defaults' }
RSThemedMapBuilder >> marker [
	| theme marker |
	theme := self theme.
	marker := RSShapeFactory arrow.
	marker color: theme textColor.
	marker size: 10.
	marker := marker asMarker.
	marker offset: 5.
	^ marker
]

{ #category : #'instance creation' }
RSThemedMapBuilder >> newBorderFor: aModel [
	aModel baselineClass ifNotNil: [ ^ nil ].
	^ RSBorder new 
		color: self theme textColor;
		width: 2;
		dashArray: #(4);
		yourself.
]

{ #category : #'instance creation' }
RSThemedMapBuilder >> newBox [
	^ super newBox
		color: self theme selectionColor;
		yourself
]

{ #category : #'instance creation' }
RSThemedMapBuilder >> newLabelFor: anObject [
	^ (super newLabelFor: anObject)
		color: self theme textColor;
		yourself
]

{ #category : #'instance creation' }
RSThemedMapBuilder >> newLineBuilder [
	| marker |
	marker := self marker.
	^ RSLineBuilder bezier
		markerEnd: marker;
		controlPointsController: (RSSmartHorizontalCPController new
			endOffset: marker shape height / 2;
			yourself);
		color: self theme textColor;
		yourself
]

{ #category : #'accessing - defaults' }
RSThemedMapBuilder >> theme [
	^ Smalltalk ui theme
]
