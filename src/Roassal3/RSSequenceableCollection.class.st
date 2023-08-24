"
Internally uses an OrderedCollection/RSGroup to iterate over the shapes.
This is the reason why is a linear render tree or linear search
"
Class {
	#name : #RSSequenceableCollection,
	#superclass : #RSShapeCollection,
	#instVars : [
		'group'
	],
	#category : #'Roassal3-Rendering'
}

{ #category : #adding }
RSSequenceableCollection >> add: newObject [
	group add: newObject
]

{ #category : #enumerating }
RSSequenceableCollection >> do: aBlock [
	group do: aBlock
]

{ #category : #initialization }
RSSequenceableCollection >> initialize [
	super initialize.
	group := RSGroup new
]

{ #category : #removing }
RSSequenceableCollection >> remove: oldObject ifAbsent: anExceptionBlock [
	group remove: oldObject ifAbsent: anExceptionBlock
]

{ #category : #'finding/searching' }
RSSequenceableCollection >> shapesAtPoint: position [
	| result |
	result := OrderedCollection new.
	group reverseDo: [ :shape |
		shape addShapesIn: result position: position.
	].
	^ result
]

{ #category : #'finding/searching' }
RSSequenceableCollection >> shapesAtRectangle: aRectangle [
	^ group select: [ :each | each encompassingRectangle intersects: aRectangle ]
]

{ #category : #'finding/searching' }
RSSequenceableCollection >> updateShape: aShape [
	aShape encompassingRectangle: nil
]
