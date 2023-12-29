"
This class uses DSMGraph
"
Class {
	#name : 'RSDSMStronglyConnected',
	#superclass : 'RSDSM',
	#instVars : [
		'palette'
	],
	#category : 'Roassal-DSM-Variations',
	#package : 'Roassal-DSM',
	#tag : 'Variations'
}

{ #category : 'rendering' }
RSDSMStronglyConnected >> borderFor: group [
	"^ RSBorder new width: 1; color: 'lightGray'"
	^ nil
]

{ #category : 'rendering' }
RSDSMStronglyConnected >> boxFor: group [
	| aGroupOfShapes rectangle |
	aGroupOfShapes := self shapesFrom: group.
	rectangle := aGroupOfShapes encompassingRectangle.
	^ RSBox new
		model: group;
		color: (self colorFor: rectangle);
		border: (self borderFor: group);
		fromRectangle: rectangle;
		yourself
]

{ #category : 'rendering' }
RSDSMStronglyConnected >> colorFor: rectangle [
	^ (self palette scale: rectangle) alpha: 0.2
]

{ #category : 'rendering' }
RSDSMStronglyConnected >> createGraph [
	| graph selectedColor |
	objectsX = objectsY ifFalse: [ ^ self error: 'we should have the same data in X and Y' ].
	graph := RSDSMGraph new: objectsX size.
	selectedColor := self selectedColor.
	objectsX doWithIndex: [ :a :k |
		objectsX doWithIndex: [ :b :j |
			shouldFeedX ifTrue: [
				(self isAssocDependent: a -> b)
					ifTrue: [ graph addEdge: k to: j ]
			] ifFalse: [
				(self isAssocDependent: b -> a)
					ifTrue: [ graph addEdge: k to: j ]
			]
		] ].
	^ graph
]

{ #category : 'accessing' }
RSDSMStronglyConnected >> palette [
	^ palette ifNil: [ palette := NSScale category20 ]
]

{ #category : 'rendering' }
RSDSMStronglyConnected >> renderBoxes: aRSCanvas groups: aCollection [
	aRSCanvas addAll: (aCollection
		select: [ :group | group size > 1 ]
		thenCollect: [ :group | self boxFor: group ])
]

{ #category : 'rendering' }
RSDSMStronglyConnected >> renderIn: aCanvas [
	| graph groups |
	graph := self createGraph.
	groups := graph computeSCCs.
	"this method changes the model"
	self sortGroups: groups.
	graph := self createGraph.
	groups := graph computeSCCs.
	super renderIn: aCanvas.
	self renderBoxes: aCanvas groups: groups
]

{ #category : 'rendering' }
RSDSMStronglyConnected >> shapesFrom: group [
	^ group collect: [ :each | self shapeAt: each @ each ] as: RSGroup
]

{ #category : 'sorting' }
RSDSMStronglyConnected >> sortGroups: aCollection [
	| newModel |
	aCollection sort: [ :a :b | a size > b size ].
	newModel := aCollection
		flatCollect: [ :each | each collect: [ :index | objectsX at: index ] ]
		as: objectsX class.
	objectsX := newModel.
	objectsY := newModel
]
