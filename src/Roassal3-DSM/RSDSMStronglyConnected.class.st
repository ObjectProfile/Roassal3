"
This class uses DSMGraph
"
Class {
	#name : #RSDSMStronglyConnected,
	#superclass : #RSDSM,
	#instVars : [
		'palette'
	],
	#category : #'Roassal3-DSM-Variations'
}

{ #category : #rendering }
RSDSMStronglyConnected >> borderFor: group [
	"^ RSBorder new width: 1; color: 'lightGray'"
	^ nil
]

{ #category : #rendering }
RSDSMStronglyConnected >> boxFor: group [
	| aGroupOfShapes |
	aGroupOfShapes := self shapesFrom: group.
	^ RSBox new
		color: (self colorFor: group);
		border: (self borderFor: group);
		fromRectangle: aGroupOfShapes encompassingRectangle;
		yourself
]

{ #category : #rendering }
RSDSMStronglyConnected >> colorFor: group [
	^ (self palette scale: group) translucent
]

{ #category : #rendering }
RSDSMStronglyConnected >> createGraph [
	| graph selectedColor |
	objectsX = objectsY ifFalse: [ ^ self error: 'we should have the same data in X and Y' ].
	graph := RSDSMGraph new: objectsX size.
	selectedColor := self selectedColor.
	shapes 
		select: [ :each | each color = selectedColor ]
		thenDo: [ :each | | index |
			index := each propertyAt: #matrixIndex.
			graph addEdge: index y to: index x].
	^ graph
]

{ #category : #accessing }
RSDSMStronglyConnected >> palette [
	^ palette ifNil: [ palette := NSScale category20c ].
]

{ #category : #rendering }
RSDSMStronglyConnected >> renderBoxes: aRSCanvas groups: aCollection [ 
	aRSCanvas addAll: (aCollection 
		select: [ :group | group size > 1 ]
		thenCollect: [ :group | self boxFor: group ])
]

{ #category : #rendering }
RSDSMStronglyConnected >> renderIn: aCanvas [
	super renderIn: aCanvas.
	self renderStrongConnectedBoxes: aCanvas.
]

{ #category : #rendering }
RSDSMStronglyConnected >> renderStrongConnectedBoxes: aCanvas [
	| graph groups |
	graph := self createGraph.
	groups := graph computeSCCs.
	self sortGroups: groups.
	self renderBoxes: aCanvas groups: groups.
]

{ #category : #rendering }
RSDSMStronglyConnected >> shapesFrom: group [
	^ group collect: [ :each | self shapeAt: each @ each ] as: RSGroup.
]

{ #category : #sorting }
RSDSMStronglyConnected >> sortGroups: aCollection [ 
	
]
