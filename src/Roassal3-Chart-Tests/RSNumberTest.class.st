Class {
	#name : #RSNumberTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Chart-Tests'
}

{ #category : #'as yet unclassified' }
RSNumberTest >> testtoCount [

	| c |
	c := 1 to: 10 count: 5.
	self assert: c size equals: 5
]

{ #category : #'as yet unclassified' }
RSNumberTest >> testtoCount2 [

	| c |
	c := 1 to: 10 count: 2.
	self assert: c size equals: 2
]

{ #category : #'as yet unclassified' }
RSNumberTest >> testtoCount3 [

	| c |
	c := 1 to: 10 count: 1.
	self assert: c size equals: 1.
	self assert: c equals: (Array with: 1)
]
