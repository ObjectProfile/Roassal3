"
I have tests for RSEdge
"
Class {
	#name : #RSEdgeTest,
	#superclass : #RSTest,
	#instVars : [
		'el1',
		'el2',
		'edge'
	],
	#category : #'Roassal3-Scripting-Tests'
}

{ #category : #running }
RSEdgeTest >> setUp [
	super setUp.
	el1 := RSShapeBuilder box element.
	el2 := RSShapeBuilder box element.
	el1 translateTo: 20 @ 20.
	el2 translateTo: 60 @ 80.
	edge := RSEdge new
		attachPoint: RSCenteredAttachPoint new;
		shape: RSLine new;
		from: el1;
		to: el2;
		yourself. 

]

{ #category : #tests }
RSEdgeTest >> testAddingEdgeAndGroup [

	| v g |
	v := RSView new.
	g := RSGroup new.
	
	g
		add: el1;
		add: el2;
		add: edge.
	v addAll: g.
	self assert: edge shape notNil.
	self assert: edge shape color notNil.
]
