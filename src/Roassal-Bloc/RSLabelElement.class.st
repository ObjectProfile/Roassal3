Class {
	#name : #RSLabelElement,
	#superclass : #BlTextElement,
	#instVars : [
		'roassalLabelShape'
	],
	#category : #'Roassal-Bloc-Elements'
}

{ #category : #'instance creation' }
RSLabelElement class >> newWith: aRSLabel [

	^ self basicNew
		initializeWith: aRSLabel;
		yourself
]

{ #category : #adding }
RSLabelElement >> addBlocToRoassalEventHandler: aHandler [

	self addEventHandler: aHandler
]

{ #category : #initialization }
RSLabelElement >> initializeWith: aRSLabel [

	self initialize.

	roassalLabelShape := aRSLabel
]

{ #category : #accessing }
RSLabelElement >> roassalShape [

	^ roassalLabelShape
]

{ #category : #refreshing }
RSLabelElement >> updateFromRoassalShape [

	roassalLabelShape updateBlElement: self
]
