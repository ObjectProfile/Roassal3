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
	| command |
	command := RSCommand new
		message: (Message selector: #red arguments: #());
		isForModel: true.
	command 
		element: RSElement new;
		component: Color.
	command execute
		
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
