"
I have test of global uses of roassal
"
Class {
	#name : #RSRoassalTest,
	#superclass : #RSTest,
	#instVars : [
		'c'
	],
	#category : #'Roassal3-Scripting-Tests'
}

{ #category : #'tests - conditions' }
RSRoassalTest >> testCommands [
	| shape removedCommands |
	shape := RSShapeBuilder new.
	self assert: shape commands size equals: 0.
	shape shapeClass: RSBox.
	self assert: shape commands size equals: 2.
	
	shape := RSShapeBuilder box.
	self assert: shape commands size equals: 2.

	shape removeCommandsBySelector: #size:.
	self assert: shape commands size equals: 1.
	
	shape := RSShapeBuilder box
		allowRepeatCommands;
		size: 10;
		size: [ 100 ];
		size: [ :m | m ];
		size: #yourself.
	self assert: shape commands size equals: 6.
	removedCommands := shape removeCommandsBySelector: #size:.
	self assert: shape commands size equals: 1.
	self assert: removedCommands size equals: 5 

	
]

{ #category : #'tests - abstract' }
RSRoassalTest >> testShapeDNU [
	| shape |
	shape := RSShapeBuilder box.
	shape size: 100.
	self should: [ shape foo ] raise: Error
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
