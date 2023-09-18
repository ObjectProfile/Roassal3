Class {
	#name : #RSFCFlowline,
	#superclass : #RSFCSymbol,
	#instVars : [
		'from',
		'to'
	],
	#category : #'Roassal3-FlowChart'
}

{ #category : #visiting }
RSFCFlowline >> accept: visitor [
	visitor visitFlowline: self
]

{ #category : #'as yet unclassified' }
RSFCFlowline >> from [
	^ from
]

{ #category : #'as yet unclassified' }
RSFCFlowline >> from: anElement to: anotherElement [
	from := anElement.
	to := anotherElement
]

{ #category : #'as yet unclassified' }
RSFCFlowline >> to [
	^ to
]
