"
I'm a Bloc element that is associated with a Roassal shape.
"
Class {
	#name : #RSShapeElement,
	#superclass : #BlElement,
	#instVars : [
		'roassalShape'
	],
	#category : #'Roassal-Bloc-Elements'
}

{ #category : #'instance creation' }
RSShapeElement class >> newWith: aRSShape [

	^ self basicNew
		initializeWith: aRSShape;
		yourself
]

{ #category : #adding }
RSShapeElement >> addBlocToRoassalEventHandler: aHandler [

	self addEventHandler: aHandler
]

{ #category : #accessing }
RSShapeElement >> initializeWith: aRSShape [

	self
		initialize;
		clipChildren: false.
	
	roassalShape := aRSShape
]

{ #category : #accessing }
RSShapeElement >> roassalShape [

	^ roassalShape
]

{ #category : #refreshing }
RSShapeElement >> updateFromRoassalShape [

	roassalShape updateBlElement: self
]
