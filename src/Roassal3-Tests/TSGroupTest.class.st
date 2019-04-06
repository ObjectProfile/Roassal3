"
A TSGroupTest is a test class for testing the behavior of TSGroup
"
Class {
	#name : #TSGroupTest,
	#superclass : #TSTest,
	#category : #'Roassal3-Tests-Trachel'
}

{ #category : #tests }
TSGroupTest >> testAddShape [
	| g |
	g := TSGroup new.
	g add: TSBox new.
]

{ #category : #tests }
TSGroupTest >> testAsGroup [
	| t |
	t := #(1 2 3) asGroup.
	self assert: t asArray equals: #(1 2 3).
	self assert: t class equals: TSGroup
]

{ #category : #tests }
TSGroupTest >> testCache01 [

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
TSGroupTest >> testCache02 [

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
TSGroupTest >> testCache03 [

	| es el |
	es := RSShapeBuilder box elementsOn: #(1 1).
	
	es elementsFromModel: 1.
	el := es elementFromModel: 1.
	self assert: el class equals: RSElement.
	self assert: el model equals: 1.
	
]

{ #category : #tests }
TSGroupTest >> testCache04 [

	| es |
	es := RSShapeBuilder box elementsOn: #(1).
	self assert: (es elementsFromModel: 1) size equals: 1.
	
	es addAll: (RSShapeBuilder box elementsOn: #(1)). 
	self assert: (es elementsFromModel: 1) size equals: 2.
]

{ #category : #tests }
TSGroupTest >> testDrawGroup [
	| g c com |
	c := TSCanvas new.
	g := TSGroup new.
	g add: TSBox new.
	com := TSComposite new
		shapes: g.
	c addShape: com.
	self assert: c numberOfShapes equals: 1.
	c createMorph drawOnMockCanvas.
]

{ #category : #tests }
TSGroupTest >> testElementFromModel [
	| group |
	group := RSShapeBuilder box elementsOn: (1 to: 5).
	self assert: (group elementFromModel: 1) == group first.
	self assert: (group elementFromModel: 5) == group last.

]
