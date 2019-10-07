Class {
	#name : #RSGroupTest,
	#superclass : #TSTest,
	#category : #'Roassal3-Scripting-Tests'
}

{ #category : #tests }
RSGroupTest >> testCache01 [

	| es el |
	es := RSShapeBuilder box elementsOn: (1 to: 5).
	self assert: es class equals: TSGroup.
	self assert: es elementFromModelCache isEmpty.
	
	el := es elementFromModel: 2.
	self assert: el class equals: RSElement.
	self assert: el model equals: 2.
	
	self deny: es elementFromModelCache isEmpty.
]

{ #category : #tests }
RSGroupTest >> testCache02 [

	| es el els |
	es := RSShapeBuilder box elementsOn: #(1 1).
	
	el := es elementFromModel: 1.
	self assert: el class equals: RSElement.
	self assert: el model equals: 1.
	
	els := es elementsFromModel: 1.
	self assert: els class equals: TSGroup.
	self assert: els size equals: 2
]

{ #category : #tests }
RSGroupTest >> testCache03 [

	| es el |
	es := RSShapeBuilder box elementsOn: #(1 1).
	
	es elementsFromModel: 1.
	el := es elementFromModel: 1.
	self assert: el class equals: RSElement.
	self assert: el model equals: 1.
	
]

{ #category : #tests }
RSGroupTest >> testCache04 [

	| es |
	es := RSShapeBuilder box elementsOn: #(1).
	self assert: (es elementsFromModel: 1) size equals: 1.
	
	es addAll: (RSShapeBuilder box elementsOn: #(1)). 
	self assert: (es elementsFromModel: 1) size equals: 2.
]

{ #category : #tests }
RSGroupTest >> testElementFromModel [
	| group |
	group := RSShapeBuilder box elementsOn: (1 to: 5).
	self assert: (group elementFromModel: 1) == group first.
	self assert: (group elementFromModel: 5) == group last.

]
