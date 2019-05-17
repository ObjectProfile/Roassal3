"
I have test of global uses of roassal
"
Class {
	#name : #RSRoassalTest,
	#superclass : #TSTest,
	#instVars : [
		'c'
	],
	#category : #'Roassal3-Tests-Roassal'
}

{ #category : #'tests - conditions' }
RSRoassalTest >> testCommands [
	| shape removedCommands |
	shape := RSShapeBuilder new.
	self assert: shape commands size equals: 0.
	shape shapeClass: TSBox.
	self assert: shape commands size equals: 2.
	
	shape := RSShapeBuilder box.
	self assert: shape commands size equals: 2.

	shape removeCommandsBySelector: #size:.
	self assert: shape commands size equals: 1.
	
	shape := RSShapeBuilder box
		size: 10;
		size: [ 100 ];
		size: [ :m | m ];
		size: #yourself.
	self assert: shape commands size equals: 6.
	removedCommands := shape removeCommandsBySelector: #size:.
	self assert: shape commands size equals: 1.
	self assert: removedCommands size equals: 5 

	
]

{ #category : #'tests - elements' }
RSRoassalTest >> testHasEdges [
	| e1 e2 edge |
	e1 := RSElement new.
	e2 := RSElement new.
	self deny: e1 hasEdges.
	self deny: e2 hasEdges.
	edge := RSEdge new from: e1; to: e2.
	self assert: e1 hasEdges.
	self assert: e2 hasEdges.
	self assert: e1 connectedEdges size equals: 1.
]

{ #category : #'tests - abstract' }
RSRoassalTest >> testShapeDNU [
	| shape |
	shape := RSShapeBuilder box.
	shape size: 100.
	self should: [ shape foo ] raise: Error
]

{ #category : #tests }
RSRoassalTest >> testViewBasic [
	| v e |
	v := RSView new.
	self assert: v canvas numberOfShapes equals: 0.
	e := RSShapeBuilder box element.
	v add: e.
	self assert: v canvas numberOfShapes equals: 1.
	v open delete.
]

{ #category : #'tests - abstract' }
RSRoassalTest >> testrsValue [
	"in roassal a parameter for one metric of the visualizacion can be anything"
	| desireColor |
	desireColor := Color red.
	"in object"
	self assert: desireColor equals: (Color red rsValue: nil).
	"in symbol performs the method"
	self assert: desireColor equals: (#red rsValue: Color).
	"in blocck execute it"
	self assert: desireColor equals: ([ :selector | Color perform: selector ] rsValue: #red)
]
