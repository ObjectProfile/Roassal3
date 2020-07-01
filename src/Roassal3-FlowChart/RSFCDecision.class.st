Class {
	#name : #RSFCDecision,
	#superclass : #RSFCSymbol,
	#instVars : [
		'yesElement',
		'noElement'
	],
	#category : #'Roassal3-FlowChart'
}

{ #category : #visiting }
RSFCDecision >> accept: visitor [
	visitor visitDecision: self
]

{ #category : #accessing }
RSFCDecision >> noElement [
	^ noElement
]

{ #category : #accessing }
RSFCDecision >> noElement: anObject [
	noElement := anObject
]

{ #category : #accessing }
RSFCDecision >> yesElement [
	^ yesElement
]

{ #category : #accessing }
RSFCDecision >> yesElement: anObject [
	yesElement := anObject
]
