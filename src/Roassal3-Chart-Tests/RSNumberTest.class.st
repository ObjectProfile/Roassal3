Class {
	#name : #RSNumberTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Chart-Tests-Base'
}

{ #category : #tests }
RSNumberTest >> testToCount [

	| c |
	c := 1 to: 10 count: 5.
	self assert: c size equals: 5
]

{ #category : #tests }
RSNumberTest >> testToCount2 [

	| c |
	c := 1 to: 10 count: 2.
	self assert: c size equals: 2
]

{ #category : #tests }
RSNumberTest >> testToCount3 [

	| c |
	c := 1 to: 10 count: 1.
	self assert: c size equals: 1.
	self assert: c equals: (Array with: 1)
]

{ #category : #tests }
RSNumberTest >> testToCount4 [

	| c |
	c := 0.02 to: 1.0 count: 120.
	self assert: c first equals: 0.02.
	self assert: c last equals: 1.0.
	self assert: c size equals: 120
]
