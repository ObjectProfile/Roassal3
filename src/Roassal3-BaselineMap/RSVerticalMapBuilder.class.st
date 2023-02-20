"
I change the layout in a vertical stacked version
"
Class {
	#name : #RSVerticalMapBuilder,
	#superclass : #RSThemedMapBuilder,
	#category : #'Roassal3-BaselineMap-Customs'
}

{ #category : #hooks }
RSVerticalMapBuilder >> adjustWidth: aMaxNumber [
]

{ #category : #'accessing - defaults' }
RSVerticalMapBuilder >> cornerRadius [
	^ 1
]

{ #category : #'accessing - defaults' }
RSVerticalMapBuilder >> defaultContainer [
	^ RSCanvas new @ RSCanvasController simple
]

{ #category : #'elementary operations' }
RSVerticalMapBuilder >> layoutOn: aCanvas [
	^ RSTreeLayout new
		horizontalGap: 5;
		verticalGap: 5;
		on: aCanvas nodes;
		yourself
]

{ #category : #'instance creation' }
RSVerticalMapBuilder >> newLabelFor: aModel [
	^ (super newLabelFor: aModel)
		text: (aModel name copyFrom: 'BaselineOfx' size to: aModel name size);
		yourself
]

{ #category : #'instance creation' }
RSVerticalMapBuilder >> newLineBuilder [
	| theme |
	theme := Smalltalk ui theme.
	^ RSLineBuilder line
		color: Color transparent;
		yourself
]

{ #category : #hooks }
RSVerticalMapBuilder >> renderIn: aCanvas [
	super renderIn: aCanvas.
	self updateWithPreOrder: aCanvas
]

{ #category : #hooks }
RSVerticalMapBuilder >> updateWidth: groupOfShapes layout: layout [
	groupOfShapes do: [ :shape |
		| children |
		children := layout childrenFor: shape.
		children ifNotEmpty: [
			| width |
			self updateWidth: children layout: layout.
			width := children asGroup width.
			shape children first width: width.
			shape width: width ].
		 ]
]

{ #category : #hooks }
RSVerticalMapBuilder >> updateWithPreOrder: aCanvas [
	| layout |
	layout := self layoutOn: aCanvas nodes.
	self updateWidth: (layout rootNodesFor: aCanvas nodes) layout: layout
]
